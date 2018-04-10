local awful = require("awful")
local beautiful = require("beautiful")

awful.rules.rules = {
  { rule = { },
    properties = { border_width = beautiful.border_width,
                   border_color = beautiful.border_normal,
                   focus = awful.client.focus.filter,
                   raise = true,
                   keys = clientkeys,
                   buttons = clientbuttons,
                   screen = awful.screen.preferred,
                   placement = awful.placement.no_overlap+awful.placement.no_offscreen } },
  -- Add titlebars to normal clients and dialogs
  { rule_any = { type = { "normal", "dialog" } },
    properties = { titlebars_enabled = false } },
  { rule = { class = "google-chrome" },
    properties = { screen = 1, tag = 1 } },
  -- All chrome modals
  { rule = { class = "google-chrome" }, except = { instance = "google-chrome" },
    properties = { floating = true } },
  { rule_any = { class = { "Skype", "telegram", "Anki" } },
    properties = { screen = 1, tag = "五" } },
  { rule_any = { class = { "Main.py", "Pqiv" } }, -- .py is guake
    properties = { floating = true } },
    -- properties = { floating = true, opacity = 0.7 } },
  { rule_any = {
      class = {
        "feh",
        "Eog",
        "Electron",
        "record-desktop",
        "Xavier",
        "hain",
        "Hain",
        "electron",
        "cerebro",
        "Cerebro",
        "Zazu",
        "Ulauncher",
        "Nodemenu-gtk.py"
      }
    },
    properties = { floating = true, placement = awful.placement.centered },
    -- callback = function(c)
    --   awful.spawn('nautilus')
    -- end
  },
  -- Remove gaps
  { rule = { class = "Gnome-terminal" },
    properties = { size_hints_honor = false } }
}
