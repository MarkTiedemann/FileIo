
function Upload-FileIo ($file) 
{
    $filePath = "$pwd\$file"
    $fileContentType = [System.Web.MimeMapping]::GetMimeMapping($filePath)
    $fileBytes = [System.IO.File]::ReadAllBytes($filePath)
    $fileContent = [System.Text.Encoding]::GetEncoding('iso-8859-1').GetString($fileBytes)

    $boundary = New-Guid

    $template = @'
--{0}
Content-Disposition: form-data; name="file"; filename="{1}"
Content-Type: {2}

{3}
--{0}--

'@

    $body = $template -f $boundary, $file, $fileContentType, $fileContent
    $contentType = 'multipart/form-data; boundary="' + $boundary + '"'
    $response = Invoke-WebRequest https://file.io -Method Post -ContentType $contentType -Body $body
    ($response | ConvertFrom-Json).link
}

function Print-FileIo ($link) 
{
    (Invoke-WebRequest $link).ToString()
}

function Save-FileIo ($link, $out) 
{
    Invoke-WebRequest $link -OutFile $out   
}
