class VirtualHost extends Object {
  final String virtualHost;
  final String folderPath;

  VirtualHost({required this.virtualHost, required this.folderPath});

  @override
  String toString() {
    return <String, String>{
      'virtual_host': virtualHost,
      'folder_path': folderPath,
    }.toString();
  }
}
