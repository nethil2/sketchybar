# nethil2's SketchyBar

## Dependencies

Install Lua SketchyBar, OmniWM, fonts, and CLI tools:

```sh
xcode-select --install

brew tap FelixKratz/formulae

# Core deps
brew install felixkratz/formulae/sketchybar media-control jq lua \
  ripgrep macchina btop

# Casks
brew install --cask omniwm \
  font-space-mono-nerd-font font-gabarito \
  font-jetbrains-mono-nerd-font font-sketchybar-app-font
```

Build SbarLua (required for this Lua-based config):

```sh
(git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/)
```

## Installation

```sh
# clone this repo into your config dir
git clone https://github.com/nethil2/sketchybar ~/.config/sketchybar

# make sure sketchybarrc is executable
chmod +x ~/.config/sketchybar/sketchybarrc

# start sketchybar service
brew services start felixkratz/formulae/sketchybar

# or if it's already running
sketchybar --reload
```

## Permissions

Grant accessibility permissions to **SketchyBar** and **OmniWM** in  
**System Settings > Privacy & Security > Accessibility**.

## Notes

- This config geometry is calibrated for a 16 inch MacBook. Edit `./theme/metrics.lua` to fit your screen size.
- Uses OmniWM via `omniwmctl` for workspaces/app info. Make sure `omniwmctl` is in your PATH.
- Wi-Fi label uses `~/Applications/WifiSSIDHelper.app` (build separately if missing).
