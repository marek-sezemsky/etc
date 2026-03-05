# WSL.exe

tl;dr

```powershell
$dist="FedoraLinux-42"

wsl --update
wsl --install -d "$dist"
wsl --set-default "$dist"
wsl
wsl --shutdown
```

To prevent WSL environment to start Windows-native apps on Host paths, strip those paths from PATH. Put this in your `~/.bashrc`:

```bash
#strip PATH with first `:/mnt/*`
export PATHWIN=$PATH # backup
export PATH="${PATH/%:\/mnt\/*/}"
```
