if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    $progressPreference = 'silentlyContinue'
    Install-PackageProvider -Name NuGet -Force | Out-Null
    Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null
    Repair-WinGetPackageManager -AllUsers
}

if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

choco install docker -y
choco install docker-desktop -y
choco install rust -y
winget install wez.wezterm
winget install Helix.Helix
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"

$SourceDir = (Resolve-Path ".").Path
$HOMEPath  = (Resolve-Path "$HOME").Path
$AppData   = $env:AppData

# Targets: link to both HOME and AppData; strip ".config/" only for AppData
$Targets = @(
    [pscustomobject]@{ Name = 'HOME';    Path = $HOMEPath; StripConfig = $false },
    [pscustomobject]@{ Name = 'AppData'; Path = $AppData;  StripConfig = $true  }
)

# Ensure directory exists
function Ensure-Directory {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
    }
}

# Create or update symlink idempotently
function Ensure-Symlink {
    param(
        [string]$DestPath,
        [string]$TargetPath
    )
    $needsLink = $true
    if (Test-Path -LiteralPath $DestPath) {
        try {
            $item = Get-Item -LiteralPath $DestPath -Force
            if ($item.LinkType -eq 'SymbolicLink' -and $item.Target -eq $TargetPath) {
                $needsLink = $false
            } else {
                Remove-Item -LiteralPath $DestPath -Recurse -Force
            }
        } catch {
            Remove-Item -LiteralPath $DestPath -Recurse -Force
        }
    }
    if ($needsLink) {
        New-Item -ItemType SymbolicLink -Path $DestPath -Target $TargetPath | Out-Null
        Write-Host "Linked: $DestPath -> $TargetPath"
    } else {
        Write-Host "Up-to-date: $DestPath"
    }
}

# Helper: for AppData, strip leading ".config/" (case-insensitive)
function Adjust-RelativePathForTarget {
    param(
        [string]$Rel,
        [bool]$StripConfig
    )
    if ($StripConfig) {
        if ($Rel -match '^(?i)\.config[\\/](.+)$') {
            return $Matches[1]
        }
    }
    return $Rel
}

# Enumerate immediate child directories only (packages)
Get-ChildItem -Path $SourceDir -Directory | ForEach-Object {
    $PackageDir = $_.FullName

    # Walk files inside each package
    Get-ChildItem -Path $PackageDir -Recurse -File | ForEach-Object {
        # Path relative to the package root (strip the package folder)
        $Rel = $_.FullName.Substring($PackageDir.Length).TrimStart('\','/')

        foreach ($t in $Targets) {
            $RelForTarget = Adjust-RelativePathForTarget -Rel $Rel -StripConfig $t.StripConfig

            # If stripping ".config/" resulted in an empty path (edge case), skip
            if ([string]::IsNullOrWhiteSpace($RelForTarget)) { return }

            $DestPath = Join-Path $t.Path $RelForTarget
            $DestDir  = Split-Path $DestPath -Parent
            if ($DestDir) { Ensure-Directory -Path $DestDir }
            Ensure-Symlink -DestPath $DestPath -TargetPath $_.FullName
        }
    }
}

mv setup-python setup-python.ps1
powershell -ExecutionPolicy Bypass -File .\setup-python.ps1
mv setup-python.ps1 setup-python
