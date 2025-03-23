#!/bin/sh
random=$(find ~/Wallpapers/ -name "*.png" | shuf -n 1)
wal -i $random &
swaybg -i $random &
cp --force $random ~/.wallpapers/current.png
if [[ ~/.wallpapers/current_blurred ]]; then
  rm ~/.wallpapers/current_blurred.png
fi
magick $random -blur 0x8 ~/.wallpapers/current_blurred.png
