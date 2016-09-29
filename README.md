
# FileIo

**Simple [file.io](https://file.io) client for PowerShell.**

## Usage

### Upload a file

`Upload-FileIo $file => https://file.io/$id`
```powershell
Upload-FileIo test.txt
# => https://file.io/r4nd0m
```

**- with a [custom expiration time](https://www.file.io/#api) (default: `14` days)**

`Upload-FileIo $file -Expires $time => https://file.io/$id`
```powershell
Upload-FileIo test.txt -Expires 1w
# => https://file.io/r4nd0m
```

### Print a file

`Print-FileIo https://file.io/$id => $content`
```powershell
Print-FileIo https://file.io/r4nd0m
# => Hello PowerShell
```

### Save a file

`Save-FileIo https://file.io/$id`
```powershell
Save-FileIo https://file.io/r4nd0m
```
**- with a new name**

`Save-FileIo https://file.io/$id -Out $file`
```powershell
Save-FileIo https://file.io/r4nd0m -Out new.txt
```

#### Customization

After loading the module, you may overwrite some of its default settings:

```powershell
$env:FILEIO_USER_AGENT = 'My Custom User Agent'
# default: FileIo - Simple file.io client for PowerShell (github.com/MarkTiedemann/FileIo)

$env:FILEIO_TIMEOUT_SEC = 10
# default: 5

$env:FILEIO_PROXY = 'http://myproxy.local'
# default: $null
```

## Download

```powershell
iwr https://raw.githubusercontent.com/MarkTiedemann/FileIo/master/FileIo.ps1 -out "$pwd/FileIo.ps1"
```

## License

[WTFPL](http://www.wtfpl.net/) – Do What the F*ck You Want to Public License.

Made with :heart: by [@MarkTiedemann](https://twitter.com/MarkTiedemannDE).
