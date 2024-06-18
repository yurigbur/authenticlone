param (
    [string]$mode = "exe", #exe, cert
    [string]$inPath,
    [string]$outPath
)

function LoadParamsFromExe {
    param (
        [string]$exePath
    )

    $signature = Get-AuthenticodeSignature -FilePath $exePath

    if ($signature.Status -eq 'Valid') {
        $existingCert = $signature.SignerCertificate
        return $existingCert

    } else {
        Write-Output "The input executable is not signed or the signature is not valid."
    }

}

function LoadParamsFromX509 {
    param (
        [string]$certPath
    )

    $existingCert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($certPath)

    return $existingCert
}

function SelfSignExecutable {
    param (
        $params,
        [string]$exePath
    )

    $newCert = New-SelfSignedCertificate -CloneCert $params -CertStoreLocation "Cert:\CurrentUser\My"

    $pass = ConvertTo-SecureString -String "asdfasdf1234" -Force -AsPlainText
    Set-AuthenticodeSignature -FilePath $exePath -Certificate $newCert #-TimestampServer "http://timestamp.digicert.com"
    
    #Export-PfxCertificate -Cert $newCert -FilePath $pfxPath -Password $pass

}


$params = @{}
if ($mode -eq "exe"){
    $params = LoadParamsFromExe -exePath $inPath
}
elseif ($mode -eq "cert") {
    $params = LoadParamsFromX509 -certPath $inPath
}
else {
    Write-Host "Unknown mode"
    return
}

SelfSignExecutable -params $params -exePath $outPath



