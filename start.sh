#!/bin/bash

if [[ "$(uname)" != "Linux" ]]; then
    echo "Error: this script only runs on Linux."
    exit 1
fi

if [[ "$XDG_CURRENT_DESKTOP" != *"GNOME"* ]]; then
    echo "Error: this script requires Gnome desktop environment."
    exit 1
fi

echo "All correct"
chmod +x ./src/_exec.sh
./src/_exec.sh