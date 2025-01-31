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

checkRunningOnMacOS

installXcode