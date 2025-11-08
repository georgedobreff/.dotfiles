#!/bin/bash

# LAUNCH ALL APPS IN THE BACKGROUND
omarchy-launch-webapp "https://gemini.google.com" &
sleep 1
omarchy-launch-editor &
sleep 1
alacritty --class=StartupTerminal &
omarchy-launch-browser &
omarchy-launch-webapp "https://github.com/" &
omarchy-launch-or-focus-webapp Discord "https://discord.com/" &
omarchy-launch-or-focus-webapp YouTube "https://youtube.com/" &

# WAIT FOR ALL WINDOWS TO SPAWN
sleep 2

# 4. MOVE THE APPS TO THEIR WORKSPACES
# We use 'movetoworkspacesilent' to move them without stealing focus

# --- Workspace 1 ---
hyprctl dispatch movetoworkspacesilent 1, class:^chrome-gemini.google.com__-Default
hyprctl dispatch movetoworkspacesilent 1, class:^Alacritty
hyprctl dispatch movetoworkspacesilent 1, class:^StartupTerminal

# --- Workspace 2 ---
hyprctl dispatch movetoworkspacesilent 2, class:^chromium
hyprctl dispatch movetoworkspacesilent 2, class:^chrome-github.com__-Default

# --- Workspace 3 ---
hyprctl dispatch movetoworkspacesilent 3, class:^chrome-discord.com__-Default
hyprctl dispatch movetoworkspacesilent 3, class:^chrome-youtube.com__-Default

# WAIT FOR MOVES TO REGISTER
sleep 2

#APPLY SPLIT RATIOS

# --- Workspace 1 ---
hyprctl dispatch workspace 1
hyprctl dispatch focuswindow class:^chrome-gemini.google.com__-Default
hyprctl dispatch resizeactive -400 0

hyprctl dispatch focuswindow class:^Alacritty
hyprctl dispatch resizeactive 0 350

hyprctl dispatch focuswindow class:^StartupTerminal
hyprctl dispatch resizeactive 0 -350

# --- Workspace 2 ---
hyprctl dispatch workspace 2
hyprctl dispatch focuswindow class:^chromium
hyprctl dispatch resizeactive 282 0

# --- Workspace 3 ---
hyprctl dispatch workspace 3
hyprctl dispatch focuswindow class:^chrome-discord.com__-Default
hyprctl dispatch resizeactive 204 0

# Switch focus back to workspace 1
hyprctl dispatch workspace 1
