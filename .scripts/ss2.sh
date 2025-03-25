#!/bin/sh
grim -g "$(slurp)" - | magick - -shave 1x1 PNG:- | swappy -f -
