-- OmniWM backend: workspace state, focus, and a push watcher.
local watcher = require("lib.watcher")

local M = {}

-- sketchybar runs under launchd with a minimal PATH, so resolve the binary.
local BIN = "/opt/homebrew/bin/omniwmctl"

M.event = "omniwm_workspace_changed"

local WATCH = [[sh -c 'while :; do ]]
    .. BIN .. [[ watch active-workspace,windows-changed --reconnect ]]
    .. [[--exec sketchybar --trigger ]] .. M.event .. [[; ]]
    .. [[sleep 1; done']]

-- Register the event and (re)start the watcher.
function M.start()
    sbar.add("event", M.event)
    watcher.start("/tmp/sketchybar_omniwm_watch.pid", WATCH, "omniwmctl watch")
end

-- isCurrent is the workspace on screen; isFocused only tracks the one holding
-- the focused window, which lags when switching to an empty workspace.
local QUERY = BIN .. " query workspaces | jq -r "
    .. [['.result.payload.workspaces[] | "\(.rawName) \(.counts.total) \(.isCurrent)"']]

-- cb(state) with state[name] = { occupied = bool, focused = bool }.
-- An empty table means the query failed (e.g. WM restarting).
function M.query(cb)
    sbar.exec(QUERY, function(out)
        local state = {}
        for name, count, focused in tostring(out):gmatch("(%S+) (%d+) (%a+)") do
            state[name] = { occupied = tonumber(count) > 0, focused = focused == "true" }
        end
        cb(state)
    end)
end

function M.focus_cmd(name)
    return BIN .. ' workspace focus-name "' .. name .. '"'
end

return M
