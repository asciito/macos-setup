#!/usr/bin/env bash

checkRunningOnMacOS() {
    local UNAMEOUT="$(uname -s)"

    case "${UNAMEOUT}" in
        Darwin*)            MACHINE=mac;;
        *)                  MACHINE="AVOID"
    esac

    if [ "$MACHINE" == "AVOID" ]; then
        echo "${RED}Unsupported OS [$(uname -s)]. This script can be only run on ${BOLD}${BLACK}MacOS${NC}."

        exit 1
    fi
}

installXcode() {
    if ! xcode-select -v > /dev/null 2>&1; then
        echo "${RED}Xcode is not install${NC}, But don't worry, I will install it for you.."
        sleep 1
        echo "${BLUE}Installing Xcode...${NC}"
        sleep 2
        xcode-select --install
    fi

    echo "${GREEN}${BOLD}Xcode is installed!${NC}"
}