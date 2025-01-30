#!/usr/bin/env bash

SOURCE_FILES=(support_colors helpers)

for SCRIPT in "${SOURCE_FILES[@]}"; do
    SCRIPT+=".sh"

    if ! source $SCRIPT; then
        echo -e "$(tput setaf 1)There was an error trying to load the script [$SCRIPT]$(tput sgr0)"

        exit 1
    fi
done

checkRunningOnMacOS

installXcode