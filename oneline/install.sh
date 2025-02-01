#!/usr/bin/env bash

set -u

GITHUB_USER="asciito"
GITHUB_REPO="macos-setup"
GITHUB_BRANCH="main"
DOWNLOAD_LINK="https://github.com/$GITHUB_USER/$GITHUB_REPO/archive/refs/heads/$GITHUB_BRANCH.zip"
PROJECT_DIR="$HOME/.macos-setup/"

# Ensure directory exists
mkdir -p "$PROJECT_DIR"

# Download repo
curl -o "$PROJECT_DIR/project.zip" -fsSL "$DOWNLOAD_LINK"

# Check unzip is present
if [ -z "$(unzip -v)" ]; then
    echo "$(tput setaf 1)'unzip' command is not available, please check if it's installed$(tput sgr0)"

    exit 1
fi

# Unzip the project files and remove files when is done
unzip -q "$PROJECT_DIR/project.zip" -d "$PROJECT_DIR"
rm -f "$PROJECT_DIR/project.zip" .git

# Change permissions for every `.sh` file in the project, just in case...
find "$PROJECT_DIR" -type f -name "*.sh" -exec chmod +x {} \;

# Execute the `init` shell script
"$PROJECT_DIR/init.sh"
