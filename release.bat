ECHO OFF
if "%1" == "--skip-clean" (
    flutter_distributor release --name dev --jobs release-windows --skip-clean
) else (
    flutter_distributor release --name dev --jobs release-windows
)
