#!/usr/bin/env bash

SOURCE_FILES=(support_colors helpers)

for SCRIPT in "${SOURCE_FILES[@]}"; do
    SCRIPT="./src/${SCRIPT}.sh"

    if [ -f SCRIPT ]; then
        echo -e "$(tput setaf 1)The file does not exists [$SCRIPT].$(tput sgr0)"

        exit 1
    fi

    source $SCRIPT
done

checkRunningOnMacOS() {
    local UNAMEOUT="$(uname -s)"
    local MACHINE

    case "${UNAMEOUT}" in
    Darwin*) MACHINE=mac ;;
    *) MACHINE="AVOID"
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
    if [ ! -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
        if ! confirm "Do you want to install [Oh My Zsh]"; then
            warning "Installation will not proceed."

            return 1
        fi

        /usr/bin/env sh -c "$(curl -fsSL $ZSH_INSTALL_URL)"

        success "Oh My Zsh installation complete!"
    else
        info "Oh My Zsh is already installed"
    fi
}

main () {
    checkRunningOnMacOS
    installXcode
    installOhMyZsh
}

main
