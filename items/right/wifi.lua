-- Wi-Fi status icon and network name (SSID)
local tokens = require("theme.tokens")
local metrics = require("theme.metrics")
local fonts = require("theme.fonts")
local icons = require("theme.icons")
local ui = require("ui")

local IFACE = "en0"

local wifi = ui.item("wifi", {
    icon = {
        color = tokens.accent,
        string = icons.wifi.off,
        padding_left = metrics.space.sm,
        padding_right = metrics.space.sm,
    },
    label = {
        font = fonts.get("numeric", "Regular", "md"),
        padding_right = metrics.space.sm,
    },
})

local HELPER = "/Users/nethil2/Applications/WifiSSIDHelper.app/Contents/MacOS/WifiSSIDHelper"

local function update()
    local cmd = "ifconfig " .. IFACE .. " | awk '/status:/{print $2}'; " .. HELPER
    sbar.exec(cmd, function(out)
        local lines = {}
        for line in tostring(out):gmatch("[^\r\n]+") do
            table.insert(lines, line)
        end
        local status = (lines[1] or ""):match("^%s*(.-)%s*$") or ""
        local ssid = (lines[2] or ""):match("^%s*(.-)%s*$") or ""
        local connected = status == "active" and ssid ~= ""
        wifi:set({
            icon = { string = connected and icons.wifi.on or icons.wifi.off },
            label = { string = connected and ssid or "", drawing = connected },
        })
    end)
end

wifi:subscribe({ "wifi_change", "system_woke", "forced" }, update)
update()
