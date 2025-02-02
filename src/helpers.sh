#!/usr/bin/env bash

info() {
    local MESSAGE="$1"

    line "$MESSAGE" 'BLUE'
}

success() {
    local MESSAGE="$1"

    line "$MESSAGE" 'GREEN'
}

warning() {
    local MESSAGE="$1"

    line "$MESSAGE" 'YELLOW'
}

danger() {
    local MESSAGE="$1"

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
    local MESSAGE="$1"
    local LIMIT="${2:-0}"

    ARGS=()

    if [ "$LIMIT" -gt 0 ]; then
        ARGS=(-n $LIMIT)
    fi

    read "${ARGS[@]}" -p "$(line "$MESSAGE")" RESPONSE

    echo "$RESPONSE"
}

confirm() {
    local COUNTER=0
    local TIMES=${2:-3}
    local MESSAGE="$1"
    local RESPONSE

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
