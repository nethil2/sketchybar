#!/bin/bash
# Active app name via omniwmctl focused window.
# Falls back to sketchybar's front_app event when IPC is unavailable.

APP=$(omniwmctl query focused-window --format json 2>/dev/null \
  | jq -r '.result.payload.window.app.name // empty' 2>/dev/null)

if [ -n "$APP" ]; then
  sketchybar --set front_app label="$APP"
elif [ -n "$INFO" ]; then
  sketchybar --set front_app label="$INFO"
fi
