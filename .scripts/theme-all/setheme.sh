#!/bin/sh
hyprctl setcursor Adwaita 24  
random=$(find ~/Walls/ -name "*.png" | shuf -n 1)
swaybg -i $random & # wallpaper setting
wal -i $random & # extraction of colors to use in all themes
cp --force $random ~/.wallpapers/current.png # swaylock
if [[ ~/.wallpapers/current_blurred ]]; then
  rm ~/.wallpapers/current_blurred.png 
fi
magick $random -blur 0x8 ~/.wallpapers/current_blurred.png # wlogout

if [[ waybar ]]; then
    killall waybar
fi

# Rofi color extraction
#------------------------
# Path to pywal colors
COLORS_FILE="$HOME/.cache/wal/colors"

# Output Rasi file
RASI_FILE="$HOME/.config/rofi/color_wal.rasi"

# Check if pywal colors file exists
if [ ! -f "$COLORS_FILE" ]; then
    echo "Pywal colors file not found at $COLORS_FILE."
    exit 1
fi

# Section for setting colors on rofi
# Read colors from pywal colors file
readarray -t COLORS < "$COLORS_FILE"

# Start writing the rasi file
cat <<EOL > "$RASI_FILE"
* {
    unspoken: ${COLORS[0]};
    foreground-color: ${COLORS[7]};
    selected-background-color: ${COLORS[1]};
    selected-foreground-color: ${COLORS[15]};
    border-color: ${COLORS[2]};
}
EOL

echo "Rasi file created at $RASI_FILE."
sleep 2 # Giving waybar time to fetch colors

# Resurecting waybar
waybar


