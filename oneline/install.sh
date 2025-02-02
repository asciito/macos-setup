#!/usr/bin/env bash

set -e

# Define variables
NC=""
RED=""
BLUE=""

# Check if stdout is a terminal
if test -t 1; then
    # Check if colors are supported
    NCOLORS=$(tput colors)

    if [ -n "$NCOLORS" ] && [ "$NCOLORS" -ge 8 ]; then
        NC="$(tput sgr0)"
        RED="$(tput setaf 1)"
        BLUE="$(tput setaf 4)"
    fi
fi

GITHUB_USER="asciito"
GITHUB_REPO="macos-setup"
GITHUB_BRANCH="main"
DOWNLOAD_LINK="https://github.com/$GITHUB_USER/$GITHUB_REPO/archive/refs/heads/$GITHUB_BRANCH.zip"
PROJECT_DIR="$HOME/.macos-setup"
ZIP_FILENAME="${GITHUB_REPO}-${GITHUB_BRANCH}"

# Ensure directory exists
mkdir -p "$PROJECT_DIR"

# Download repo
cat <<INFO

${BLUE}Downloading repository...${NC}

INFO
sleep 1
curl -o "$PROJECT_DIR/$ZIP_FILENAME.zip" -fSL "$DOWNLOAD_LINK"

# Check unzip is present
if [ -z "$(unzip -v)" ]; then
    echo "${RED}'unzip' command is not available, please check if it's installed${NC}"

    exit 1
fi

cat <<INFO

${BLUE}Unzipping project...${NC}

INFO
sleep 1

# Unzip the project files and remove files when is done
unzip -oq "$PROJECT_DIR/$ZIP_FILENAME" -d "$PROJECT_DIR"
mv "$PROJECT_DIR/$ZIP_FILENAME/"* "$PROJECT_DIR/"

# shellcheck disable=SC2115
rm -rf "$PROJECT_DIR/$ZIP_FILENAME.zip" "$PROJECT_DIR/$ZIP_FILENAME" "$PROJECT_DIR/oneline"

# Change permissions for every `.sh` file in the project, just in case...
find "$PROJECT_DIR" -type f -name "*.sh" -exec chmod +x {} \;

sleep 1
cat <<INFO
${BLUE}Ok, now it's time to install all your tools${NC}

INFO
sleep 2

# Execute the `init` shell script
"$PROJECT_DIR/init.sh"
