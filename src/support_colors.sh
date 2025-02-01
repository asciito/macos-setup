#!/usr/bin/env bash

# Define variables
export NC=""
export BLACK=""
export RED=""
export GREEN=""
export YELLOW=""
export BLUE=""
export BOLD=""

# Check if stdout is a terminal
if test -t 1; then
    # Check if colors are supported
    NCOLORS=$(tput colors)

    if test -n "$NCOLORS" && test "$NCOLORS" -ge 8; then
        NC="$(tput sgr0)"
        BLACK="$(tput setaf 0)"
        RED="$(tput setaf 1)"
        GREEN="$(tput setaf 2)"
        YELLOW="$(tput setaf 3)"
        BLUE="$(tput setaf 4)"
        BOLD="$(tput bold)"
    fi
fi