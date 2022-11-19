$Url = "https://discord.com/api/webhooks/..."
$Path = 'c:\path\to\file.txt'

$File = [System.IO.File]::ReadAllBytes($Path)
$Enc = [System.Text.Encoding]::GetEncoding('UTF-8').GetString($File)
$Boundary = [System.Guid]::NewGuid().ToString()
$LF = "`r`n"

$Body = (
	"--$Boundary",
	"Content-Disposition: form-data; name=`"files[0]`"; filename=`"file.txt`"",
	"Content-Type: text/html$LF",
	$Enc,
	"--$Boundary--$LF"
) -join $LF

$Res = Invoke-RestMethod -Uri $Url -Method Post -ContentType "multipart/form-data; boundary=`"$Boundary`"" -Body $Body
