#!/bin/bash

# Script to toggle kitty padding based on fullscreen state
# This can be triggered by macOS shortcuts or window manager

# Check if we're in fullscreen (you can also pass this as an argument)
if [ "$1" = "fullscreen" ]; then
    # Remove padding in fullscreen
    kitty @ set-spacing padding=0
elif [ "$1" = "windowed" ]; then
    # Restore padding in windowed mode
    kitty @ set-spacing padding=20
else
    # Toggle based on current state (optional)
    echo "Usage: $0 [fullscreen|windowed]"
fi