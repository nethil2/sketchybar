-- System icon with a small system menu
local metrics = require("theme.metrics")
local icons = require("theme.icons")
local fonts = require("theme.fonts")
local tokens = require("theme.tokens")
local ui = require("ui")

local logo = ui.item("apple.logo", {
    icon = {
        string = "\u{F302}",
        font = fonts.get("icon", "Bold", "md"),
        color = tokens.fg.primary,
    },
    label = { drawing = false },
    padding_left = metrics.space.md,
    padding_right = metrics.space.sm,
})

local entries = {
    { "settings", icons.settings, "Settings", "open -a 'System Settings'" },
    { "activity", icons.activity, "Activity Monitor", "open -a 'Activity Monitor'" },
    { "lock", icons.lock, "Lock Screen", "pmset displaysleepnow" },
}

for _, e in ipairs(entries) do
    local id, glyph, text, cmd = e[1], e[2], e[3], e[4]
    ui.popup.row(logo, "apple.menu." .. id, {
        icon = { string = glyph },
        label = { string = text },
    }, cmd)
end

ui.popup.attach(logo)
