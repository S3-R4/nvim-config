#!/bin/bash
# Get the directory of the current file from the first argument
DIR="$1"
wezterm cli split-pane --cwd "$DIR"
