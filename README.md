
# FileIo

**Simple [file.io](https://file.io) client for PowerShell.**

## Quickstart

### Upload a file

```powershell
Upload-FileIo $file
# => https://file.io/$id
```

### Print a file

```powershell
Print-FileIo https://file.io/$id
# => $content
```

### Save a file

```powershell
Save-FileIo https://file.io/$id -Out $file
```

## Download

```powershell
iwr https://raw.githubusercontent.com/MarkTiedemann/FileIo/master/FileIo.ps1 -out "$pwd/FileIo.ps1"
```

## License

[WTFPL](http://www.wtfpl.net/) – Do What the F*ck You Want to Public License.

Made with :heart: by [@MarkTiedemann](https://twitter.com/MarkTiedemannDE).
