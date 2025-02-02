#!/usr/bin/env bash

info() {
    local MESSAGE
    MESSAGE="$1"

    line "$MESSAGE" 'BLUE'
}

success() {
    local MESSAGE
    MESSAGE="$1"

    line "$MESSAGE" 'GREEN'
}

warning() {
    local MESSAGE
    MESSAGE="$1"

    line "$MESSAGE" 'YELLOW'
}

danger() {
    local MESSAGE
    MESSAGE="$1"

    line "$MESSAGE" 'RED'
}

line() {
    local TEXT
    local COLOR_NAME
    local COLOR_VALUE

    TEXT="$1"
    COLOR_NAME="${2:-""}"

    case "${COLOR_NAME}" in
        BLACK*)     COLOR_VALUE="$BLACK" ;;
        RED*)       COLOR_VALUE="$RED" ;;
        GREEN*)     COLOR_VALUE="$GREEN" ;;
        BLUE*)      COLOR_VALUE="$BLUE" ;;
        YELLOW*)    COLOR_VALUE="$YELLOW" ;;
        BOLD*)      COLOR_VALUE="$BOLD" ;;
        *)          COLOR_VALUE=""
    esac
    

    if [ -n "$COLOR_VALUE" ]; then
        echo "${COLOR_VALUE}$TEXT${NC}"
    else
        echo "$TEXT"
    fi
}

ask() {
    local MESSAGE
    local LIMIT
    
    MESSAGE="$1"
    LIMIT="${2:-0}"

    ARGS=()

    if [ "$LIMIT" -gt 0 ]; then
        ARGS=(-n "$LIMIT")
    fi

    read "${ARGS[@]}" -p "$(line "$MESSAGE")" RESPONSE

    echo "$RESPONSE"
}

confirm() {
    local COUNTER
    local TIMES
    local MESSAGE
    local RESPONSE

    COUNTER=0
    TIMES=${2:-3}
    MESSAGE="$1"

    while [ true ]; do
        if [ ! "$COUNTER" -lt "$TIMES" ]; then
            return 1
        fi

        RESPONSE=$(ask "$MESSAGE? [y/n]: " 1)

        echo

        if [[ $RESPONSE =~ ^[Yy]$ ]]; then
            return 0
        elif [[ $RESPONSE =~ ^[Nn]$ ]]; then
            return 1
        else
            warning "Invalid option [${RESPONSE}]"

            ((COUNTER++))
        fi
    done
}
