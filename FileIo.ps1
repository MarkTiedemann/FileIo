
$env:FILEIO_USER_AGENT = 'FileIo - Simple file.io client for PowerShell (github.com/MarkTiedemann/FileIo)'
$env:FILEIO_TIMEOUT_SEC = 5
$env:FILEIO_PROXY = $null

function Upload-FileIo ($file, $expires)
{
    $filePath = "$pwd\$file"
    $fileContentType = [System.Web.MimeMapping]::GetMimeMapping($filePath)
    $fileBytes = [System.IO.File]::ReadAllBytes($filePath)
    $fileEncoding = [System.Text.Encoding]::GetEncoding('iso-8859-1')
    $fileContent = $fileEncoding.GetString($fileBytes)

    if (!$expires) { $expires = 14 } # 14 days by default

    $boundary = New-Guid
    $contentType = 'multipart/form-data; boundary="' + $boundary + '"'

    $template = @'
--{0}
Content-Disposition: form-data; name="file"; filename="{1}"
Content-Type: {2}

{3}
--{0}--

'@

    $body = $template -f $boundary, $file, $fileContentType, $fileContent

    $response = Invoke-WebRequest "https://file.io/?expires=$expires" -Method Post -ContentType $contentType -Body $body -UserAgent $env:FILEIO_USER_AGENT -TimeoutSec $env:FILEIO_TIMEOUT_SEC -Proxy $env:FILEIO_PROXY
    ($response | ConvertFrom-Json).link
}

function Print-FileIo ($link)
{
    (Invoke-WebRequest $link -UserAgent $env:FILEIO_USER_AGENT -TimeoutSec $env:FILEIO_TIMEOUT_SEC  -Proxy $env:FILEIO_PROXY).ToString()
}

function Save-FileIo ($link, $out)
{
    if ($out)
    {
        # save file with new name
        Invoke-WebRequest $link -OutFile $out -UserAgent $env:FILEIO_USER_AGENT -TimeoutSec $env:FILEIO_TIMEOUT_SEC -Proxy $env:FILEIO_PROXY
    }
    else
    {
        # save file with the original name
        $response = Invoke-WebRequest $link -UserAgent $env:FILEIO_USER_AGENT -TimeoutSec $env:FILEIO_TIMEOUT_SEC -Proxy $env:FILEIO_PROXY
        $file = $response.Headers.'Content-Disposition'.Split('=')[-1]
        $filePath = "$pwd\$file"
        $fileEncoding = [System.Text.Encoding]::GetEncoding('iso-8859-1')
        $fileBytes = $fileEncoding.GetBytes($response.ToString())
        [System.IO.File]::WriteAllBytes($filePath, $fileBytes)
    }
}
