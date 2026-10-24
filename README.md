
# nethil2's SketchyBar

## Dependencies

Install Lua SketchyBar, OmniWM, as well as some fonts and CLI tools:

```sh
brew tap FelixKratz/formulae
brew install felixkratz/formulae/sketchybar media-control jq lua
brew install --cask omniwm font-space-mono-nerd-font font-gabarito

xcode-select --install
(git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/)
```

## Installation

```sh
# clone this repo:
git clone https://github.com/pgkyg79f6w-blip/sketchybar ~/.config/sketchybar

# start sketchybar services:
brew services start felixkratz/formulae/sketchybar

# if you already have a sketchybar instance running:
sketchybar --reload
```

## Notes

This config geometry is calibrated for a 16 inch MacBook. Edit `./theme/metrics.lua` to fit your screen size.

