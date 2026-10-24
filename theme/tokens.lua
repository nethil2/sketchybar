-- Semantic color roles — monochrome with subtle green-charcoal tint.
local p = require("theme.palette")
local alpha = require("lib.color").alpha

return {
    surface = {
        bar = p.transparent,
        group = p.transparent,
        item_active = p.transparent,
        hover = alpha(p.text, 0.06),
        popup = p.transparent,
    },
    border = {
        group = alpha(p.text, 0.15),
        popup = alpha(p.text, 0.12),
        divider = alpha(p.text, 0.08),
    },
    track = {
        fill = p.text,
        rest = alpha(p.text, 0.12),
    },
    fg = {
        primary = p.text,
        muted = p.subtle,
        faint = p.muted,
    },
    status = {
        ok = p.text,
        warn = p.subtle,
        alert = p.subtle,
        crit = p.text,
        info = p.subtle,
    },
    accent = p.text,
    none = p.transparent,
}
