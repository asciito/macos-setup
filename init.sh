#!/usr/bin/env bash

set -u

SCRIPTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_FILES=(support_colors helpers)
ZSH_INSTALL_URL="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
HOMEBREW_INSTALL_URL="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"

for fname in "${SOURCE_FILES[@]}"; do
    SCRIPT="$SCRIPTDIR/src/$fname.sh"

    if [ -f SCRIPT ]; then
        echo -e "$(tput setaf 1)The script does not exists [$fname].$(tput sgr0)"

        exit 1
    fi

    # shellcheck disable=SC1090
    source "$SCRIPT"
done

checkRunningOnMacOS() {
    local UNAMEOUT
    local MACHINE

    UNAMEOUT="$(uname -s)"

    case "${UNAMEOUT}" in
        Darwin*)    MACHINE=mac ;;
        *)          MACHINE="AVOID"
    esac

    if [ "$MACHINE" = "AVOID" ]; then
        warning "Unsupported OS [$(uname -s)]. This script can be only run on ${BOLD}MacOS${YELLOW}."

        exit 1
    fi
}

installXcode() {
    if ! xcode-select -v >/dev/null 2>&1; then
        if ! confirm "Do you want to install [Xcode]"; then
            warning "Installation will not proceed."

            return 1
        fi

        echo "$(danger "Xcode is not installed$"), But don't worry, I will install it for you.."
        sleep 1
        info "Installing Xcode..."
        sleep 2
        xcode-select --install

        success "Xcode installation complete!"

        return 0
    else
        info "Xcode is already installed"
    fi

    return 0
}

installOhMyZsh()
{
    # Pre install zsh if not available
    if [ -z "$(zsh --version 2>/dev/null)" ]; then
        brew install zsh
    fi

    if [ ! -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
        if ! confirm "Do you want to install [Oh My Zsh]"; then
            warning "Installation will not proceed."

            return 1
        fi

        /usr/bin/env sh -c "$(curl -fsSL "$ZSH_INSTALL_URL")"


        info "Installing Homebrew on Zsh..."
        sleep 2

        echo >> "$HOME/.zshrc"
        echo "eval $("$HOMEBREW_PREFIX"/bin/brew shellenv)" >> "$HOME/.zshrc"

        success "Oh My Zsh installation complete!"
    else
        info "Oh My Zsh is already installed"
    fi
}

installHomebrew()
{
    if [ -z "$(command -v brew)" ]; then
        if ! confirm "No brew installation was found, do you want to install it"; then
            warning "Installation abort"
        fi

        info "Installing [HOMEBREW]..."
        sleep 1
        /bin/bash -c "$(curl -fsSL "$HOMEBREW_INSTALL_URL")"
        
        echo >> "$HOME/.bashrc"
        echo "eval $("$HOMEBREW_PREFIX"/bin/brew shellenv)" >> "$HOME/.bashrc"
        eval "$("$HOMEBREW_PREFIX/bin/brew" shellenv)"

    else
        info "Homebrew is already installed"
    fi
}

installGit() {
    if [ -z "$(git --version 2>/dev/null)" ]; then
        if ! confirm "Do you want to install [Git]"; then
            warning "Installation will not proceed."

            return 1
        fi

        brew install git
    else
        info "Git is already installed"
    fi
}

main () {
    checkRunningOnMacOS
    installXcode
    installHomebrew
    installGit
    installOhMyZsh
}

main
