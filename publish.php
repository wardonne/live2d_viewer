<?php
declare(strict_types=1);
date_default_timezone_set('Asia/Shanghai');
class Publisher 
{
    private $pubspec = 'pubspec.yaml';
    private $arguments;
    private $pubdate;

    private $sftp;
    private $session;

    private $version;
    public function __construct()
    {
        $this->pubdate = date(DATE_RFC1123);
        $this->arguments = getopt('', [
            'name:',
            'job:',
            'skip-clean',
            'version:',

            'imainver',
            'isubver',
            'istagever',
            'ibuildnum',

            'skip-build',

            'host:',
            'port:',
            'username:',
            'pubkey:',
            'prikey:',
            'remote-path:'
        ]);
        $this->validate();
        $this->version = $this->arguments['version'] ?? '';
    }

    private function validate() : void
    {
        $required = ['name', 'job', 'host', 'port', 'username', 'pubkey', 'prikey', 'remote-path'];
        if($this->skipBuild()) {
            $required[] = 'version';
        }
        foreach($required as $option) {
            if(empty($this->arguments[$option])) {
                throw new InvalidArgumentException('option `' . $option . '` is required');
            }
        }
    }

    public function run() : void
    {
        if(!$this->skipBuild()) {
            $this->build();
            $this->output('Build completed');
        }
        $this->publish();
        $this->output('Published!!');
    }

    private function skipBuild() : bool
    {
        return isset($this->arguments['skip-build']);
    }

    private function restorePubspec() : void
    {
        if(is_file($this->pubspec . '.backup')) {
            unlink($this->pubspec);
            rename($this->pubspec . '.backup', $this->pubspec);
        }
    }

    private function incrementVersion() : void
    {
        $pattern = '/version:\s((\d+).(\d+).(\d+)\+(\d+))/';
        $pubspec = file_get_contents($this->pubspec);
        if(preg_match($pattern, $pubspec, $matches)) {
            list($_, $__, $mainver, $subver, $stagever, $buildnum) = $matches;
            if($this->needIncrementMainVersion()) {
                $mainver++;
                $this->version = "$mainver.0.0+1";
            } elseif($this->needIncrementSubVersion()) {
                $subver++;
                $this->version = "$mainver.$subver.0+1";
            } elseif($this->needIncrementStageVersion()) {
                $stagever++;
                $this->version = "$mainver.$subver.$stagever+1";
            } else {
                $buildnum++;
                $this->version = "$mainver.$subver.$stagever+$buildnum";
            }
            $pubspec = preg_replace($pattern, "version: {$this->version}", $pubspec, 1);
            if(!copy($this->pubspec, $this->pubspec.'.backup')) {
                throw new Exception('can\'t backup pubspec.yaml');
            }
            file_put_contents($this->pubspec, $pubspec);
        } else {
            throw new Exception('can\'t find version number in pubspec.yaml');
        }
    }

    private function needIncrementMainVersion() : bool 
    {
        return isset($this->arguments['imainver']);
    }

    private function needIncrementSubVersion() : bool
    {
        return isset($this->arguments['isubver']);
    }

    private function needIncrementStageVersion() : bool
    {
        return isset($this->arguments['istagever']);
    }

    private function build() : void
    {
        $this->output('Start build application', true);
        $this->output("\tRelease Name: " . $this->arguments['name'], true);
        $this->output("\tRelease Job: {$this->arguments['job']}", true);
        $this->output("\tRelease Skip clean: " . isset($this->arguments['skip-clean']) ? 'True' : 'False', true);
        // increment version number
        $this->incrementVersion();
        try {
            // build
            $releaseCommand = 'flutter_distributor release ';
            $releaseCommand .= "--name {$this->arguments['name']} ";
            $releaseCommand .= "--jobs {$this->arguments['job']} ";
            $releaseCommand .= isset($this->arguments['skip-clean']) ? '--skip-clean' : '';
            $this->execute($releaseCommand);
        } catch(Throwable $e) {
            $this->restorePubspec();
            throw $e;
        }
    }

    private function execute(string $command) : void
    {
        $handle = popen($command, 'r');
        while (!feof($handle)) {
            $this->output(fgets($handle));
        }
        pclose($handle);
    }

    private function output(string $message, bool $eol = false) : void
    {
        echo $message, $eol ? PHP_EOL : '';
    }

    private function publish() : void
    {
        if(!$this->version) {
            throw new Exception('need indicate the version number if you just want to publish');
        }
        $package = 'dist' . DIRECTORY_SEPARATOR . $this->version;
        $executable = $package . DIRECTORY_SEPARATOR . 'live2d_viewer-' . $this->version . '-windows-setup.exe';
        $signature = $this->getSignature($executable);
        $this->updateAppcast(basename($executable), $signature);

        {
            $this->output('Start publish application: ' . $package, true);
            $this->output("\tSFTP Host: {$this->arguments['host']}", true);
            $this->output("\tSFTP Port: {$this->arguments['port']}", true);
            $this->output("\tSFTP Username: {$this->arguments['username']}", true);
            $this->output("\tSFTP Public Key: {$this->arguments['pubkey']}", true);
            $this->output("\tSFTP Private Key: {$this->arguments['prikey']}", true);
            $this->output("\tSFTP Remote Path: {$this->arguments['remote-path']}", true);
        }
        
        $this->connect();
        $this->uploadAppcast();
        $this->uploadPackage($package);
    }

    private function uploadAppcast() : void
    {
        $this->uploadSftp('dist' . DIRECTORY_SEPARATOR . 'appcast.xml', $this->arguments['remote-path'] . '/appcast.xml');
    }

    private function uploadPackage(string $package) : void
    {
        $this->uploadSftp($package, $this->arguments['remote-path'] . '/' . $this->version);
    }

    private function getSignature(string $executable) : string
    {
        $signature = [];
        $this->output('Signation: ' . $executable, true);
        $signatureCommand = 'flutter pub run auto_updater:sign_update ' . $executable;
        if(!exec($signatureCommand, $signature)) {
            throw new Exception('signature failed, command: ' . $signatureCommand);
        }
        return implode('', $signature);
    }

    private function updateAppcast(string $exeName, string $signature) : void
    {
        $xml = '<?xml version="1.0" encoding="UTF-8"?>' . PHP_EOL;
        $xml .= '<rss version="2.0" xmlns:sparkle="http://www.andymatuschak.org/xml-namespaces/sparkle">' . PHP_EOL;
        $xml .= '   <channel>' . PHP_EOL;
        $xml .= '       <title>Live2D Viewer</title>' . PHP_EOL;
        $xml .= '       <description>Live2D Viewer is a windows desktop app to show some live2d model</description>' . PHP_EOL;
        $xml .= '       <language>en</language>' . PHP_EOL;
        $xml .= '       <item>' . PHP_EOL;
        $xml .= "           <title>Version {$this->version}</title>" . PHP_EOL;
        $xml .= "           <pubDate>{$this->pubdate}</pubDate>" . PHP_EOL;
        $xml .= "           <enclosure url='https://appcast.wardonet.cn/live2d-viewer/{$this->version}/$exeName'" . PHP_EOL;
        $xml .= "                    sparkle:dsaSignature='$signature'" . PHP_EOL;
        $xml .= "                    sparkle:version='{$this->version}'" . PHP_EOL;
        $xml .= '                    sparkle:os="windows"' . PHP_EOL;
        $xml .= '                    length="0"' . PHP_EOL;
        $xml .= '                    type="application/octet-stream" />' . PHP_EOL;
        $xml .= '       </item>' . PHP_EOL;
        $xml .= '   </channel>' . PHP_EOL;
        $xml .= '</rss>' . PHP_EOL;
        $this->output('Updating appcast', true);
        file_put_contents('dist' . DIRECTORY_SEPARATOR . 'appcast.xml', $xml);
    }

    private function connect() : void
    {
        $this->output('Connecting: ' . $this->arguments['host'] . ':' . $this->arguments['port'], true);
        $this->session = ssh2_connect($this->arguments['host'], $this->arguments['port']);
        if($this->session === false) {
            throw new Exception('can\'t connect to ' . $this->arguments['host'] . ':' . $this->arguments['port']);
        }
        $this->output('Login authenticating', true);
        if(!ssh2_auth_pubkey_file(
            $this->session, 
            $this->arguments['username'], 
            $this->arguments['pubkey'], 
            $this->arguments['prikey']
        )) {
            throw new Exception('can\'t pass login authentication');
        }
        $this->output('Opening sftp connection', true);
        $this->sftp = ssh2_sftp($this->session);
        if($this->sftp === false) {
            throw new Exception('can\'t connect sftp');
        }
    }

    private function uploadSftp(string $localPath, string $remotePath) : void
    {
        if(is_file($localPath)) {
            $stat = @ssh2_sftp_stat($this->sftp, $remotePath);
            if($stat === false) {
                ssh2_sftp_mkdir($this->sftp, dirname($remotePath), 0777, true);
            }
            $this->output('Uploading: ' . $localPath, true);
            ssh2_scp_send($this->session, $localPath, $remotePath, 0777);
        } else {
            $this->output('Listing: ' . $localPath, true);
            $dirs = scandir($localPath);
            foreach($dirs as $dir) {
                if($dir == '.' || $dir == '..') continue;
                $this->uploadSftp($localPath . DIRECTORY_SEPARATOR . $dir, $remotePath . '/' . $dir);
            }
        }
    }
}

function main() {
    try {
        if(!extension_loaded('ssh2')) {
            throw new Exception('extension `ssh2` not loaded');
        }
        $publisher = new Publisher();
        $publisher->run();
    } catch(Throwable $e) {
        echo $e->getMessage(), PHP_EOL;
        echo $e->getTraceAsString(), PHP_EOL;
    }
}

main();