#!/bin/bash

# Install Starship
curl -fsSL https://starship.rs/install.sh | bash

# Check if Starship is installed successfully
if [ ! -x "$(command -v starship)" ]; then
    echo "Error: Starship installation failed."
    exit 1
fi

# Download starship.toml
REPO_URL="https://github.com/martinallen-exe/starship/raw/main/starship.toml"  # Replace with the URL to your starship.toml file

# Download starship.toml and save it to the appropriate location
curl -fsSL -o ~/.config/starship.toml $REPO_URL

# Check if the download was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to download starship.toml."
    exit 1
fi

# Enable Starship
echo 'eval "$(starship init bash)"' >> ~/.bashrc

# Reload the bashrc to activate Starship
source ~/.bashrc

# Success message
echo "Starship installed and configured successfully!"
