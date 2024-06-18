# Authenticlone

Authenticlone is a simple powershell script that clones the information of a provided Authenticode signature to a self-signed certificate and signs an executable with it. It can clone the certificate directly from an executable of use a provided X509 certificate.

## Requirements
- Microsoft Powershell
- Windows SDK (was neede at some point for Authenticode, not sure anymore)

## Usage
**Examples**

```powershell
.\authenticlone.ps1 -mode exe -inPath "\Path\to\original\signed.exe" -outPath "\Path\to\new.exe"
.\authenticlone.ps1 -mode cert -inPath "\Path\to\certificate\file.cer" -outPath "\Path\to\new.exe"
```