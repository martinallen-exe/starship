# Install Starship
iex (irm 'https://starship.rs/install.ps1')

# Check if Starship is installed successfully
if (!(Test-Path (Join-Path $Env:USERPROFILE '.starship\starship.exe'))) {
    Write-Error "Error: Starship installation failed."
    exit 1
}

# Download starship.toml
$RepoUrl = "https://github.com/martinallen-exe/starship/raw/main/starship.toml"  # Replace with the URL to your starship.toml file

$ConfigDir = (Join-Path $Env:APPDATA 'starship')
$ConfigFile = (Join-Path $ConfigDir 'starship.toml')

# Create the configuration directory if it doesn't exist
if (!(Test-Path $ConfigDir)) {
    New-Item -ItemType Directory -Path $ConfigDir | Out-Null
}

# Download starship.toml and save it to the appropriate location
Invoke-WebRequest -Uri $RepoUrl -OutFile $ConfigFile

# Check if the download was successful
if ($?) {
    # Enable Starship
    $PowershellProfile = (Join-Path $Env:USERPROFILE 'Documents\PowerShell\Microsoft.PowerShell_profile.ps1')
    $StarshipInitCommand = "& `"$((Join-Path $Env:USERPROFILE '.starship\starship.exe'))"" init powershell --yes"

    Add-Content -Path $PowershellProfile -Value $StarshipInitCommand

    # Reload the PowerShell profile to activate Starship
    . $PowershellProfile

    # Success message
    Write-Output "Starship installed and configured successfully!"
} else {
    Write-Error "Error: Failed to download starship.toml."
    exit 1
}
