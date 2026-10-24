#!/bin/bash
# Workspace indicator via omniwmctl (IPC JSON: .result.payload.workspaces[])
# Shows all workspaces; active = accent color, occupied = bright, empty = dim.

WS_JSON=$(omniwmctl query workspaces --format json 2>/dev/null)
echo "$WS_JSON" | jq -e '.ok == true' >/dev/null 2>&1 || {
  sketchybar --set workspaces label="omniwm offline" label.drawing=on label.color=0x99f38ba8
  exit 0
}

sketchybar --set workspaces label.drawing=off

ACCENT=0xff89b4fa FG=0xffcdd6f4 DIM=0x66a6adc8

i=0
echo "$WS_JSON" | jq -c '.result.payload.workspaces[]' | while read -r ws; do
  NUM=$(echo "$ws" | jq -r '.number')
  FOCUSED=$(echo "$ws" | jq -r '.isFocused')
  COUNT=$(echo "$ws" | jq -r '.counts.total // 0')
  NAME=$(echo "$ws" | jq -r '.displayName // (.number | tostring)')
  ITEM="ws$NUM"

  sketchybar --add item "$ITEM" left 2>/dev/null

  if [ "$FOCUSED" = "true" ]; then
    COLOR=$ACCENT
    LABEL="$NAME"
  elif [ "$COUNT" -gt 0 ]; then
    COLOR=$FG
    LABEL="$NAME"
  else
    COLOR=$DIM
    LABEL="$NAME"
  fi

  sketchybar --set "$ITEM" \
    drawing=on \
    label="$LABEL" \
    label.color=$COLOR \
    label.font="SF Pro:Semibold:13.0" \
    padding_left=7 \
    padding_right=7 \
    click_script="omniwmctl command switch-workspace anywhere $NUM"

  # small dot under occupied non-focused workspaces
  if [ "$FOCUSED" != "true" ] && [ "$COUNT" -gt 0 ]; then
    sketchybar --set "$ITEM" icon="●" icon.color=$COLOR icon.font="SF Pro:Regular:7.0" icon.drawing=on
  else
    sketchybar --set "$ITEM" icon.drawing=off
  fi

  if [ $i -eq 0 ]; then
    sketchybar --move "$ITEM" workspaces 2>/dev/null
  else
    sketchybar --move "$ITEM" "ws$((i-1))" 2>/dev/null
  fi
  i=$((i+1))
done
