#!/bin/bash

# Set necessary environment variables
export PATH="/usr/bin:/usr/local/bin:$PATH"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

# Get list of all available players
available_players=$(playerctl -l 2>/dev/null | tr '\n' ',')

# Function to get playing player (skip paused ones)
get_playing_player() {
    for player in spotify firefox chromium vlc mpv; do
        if echo "$available_players" | grep -q "$player"; then
            status=$(playerctl -p "$player" status 2>/dev/null)
            if [ "$status" = "Playing" ]; then
                echo "$player"
                return
            fi
        fi
    done

    # If no playing player found, get the first available one
    for player in spotify firefox chromium vlc mpv; do
        if echo "$available_players" | grep -q "$player"; then
            echo "$player"
            return
        fi
    done
}

# Get the active player
active_player=$(get_playing_player)

# If no player found
if [ -z "$active_player" ]; then
    echo ""
    exit 0
fi

# Get current player information from active player
player_name=$(playerctl -p "$active_player" metadata --format "{{ playerName }}" 2>/dev/null)
artist=$(playerctl -p "$active_player" metadata --format "{{ artist }}" 2>/dev/null)
title=$(playerctl -p "$active_player" metadata --format "{{ title }}" 2>/dev/null)
status=$(playerctl -p "$active_player" status 2>/dev/null)

# If no music is detected or player is stopped
if [ -z "$player_name" ] || [ -z "$title" ] || [ "$status" = "Stopped" ]; then
    echo "No music playing"
    exit 0
fi

# Function to determine logo based on player/source
get_logo() {
    case "$1" in
        *spotify*)
            echo "󰓇"  # Spotify logo (Nerd Font)
            ;;
        *firefox*|*chrome*|*chromium*)
            # Detect YouTube or other web sources
            if echo "$title" | grep -qi "youtube\|yt"; then
                echo "󰗃"  # YouTube logo
            else
                echo "󰖟"  # Browser logo
            fi
            ;;
        *vlc*)
            echo "󰕼"  # VLC logo
            ;;
        *)
            echo ""  # Default generic music logo
            ;;
    esac
}

# Get appropriate logo
logo=$(get_logo "$player_name")

# Limit text length to avoid too long display
max_length=50
if [ ${#artist} -gt 0 ] && [ ${#title} -gt 0 ]; then
    full_text="$artist - $title"
else
    full_text="$title"
fi

# Truncate if too long
if [ ${#full_text} -gt $max_length ]; then
    truncated_text="${full_text:0:$((max_length-3))}..."
else
    truncated_text="$full_text"
fi

# Display result with logo
echo "$logo  $truncated_text"
