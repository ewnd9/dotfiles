awful.rules.rules = {
  { rule = { },
    properties = { border_width = beautiful.border_width,
                   border_color = beautiful.border_normal,
                   focus = true,
                   keys = clientkeys,
                   buttons = clientbuttons } },
  { rule = { class = "Chromium" },
    properties = { tag = tags[1][1] } },
  { rule = { class = "google-chrome" },
    properties = { tag = tags[1][1] } },
  { rule = { class = "google-chrome" }, except = { instance = "google-chrome" },
    properties = { floating = true } },
  { rule_any = { class = { "Skype", "telegram" } },
      properties = { tag = tags[1][5] } },
  { rule = { class = "Guake" },
    properties = {opacity = 0.7} },
  { rule = { class = "Gnome-terminal" },
    properties = { size_hints_honor = false } },
  { rule_any = { class = { "feh", "Eog", "Electron", "Journal", "journal", "Xavier" } }, -- image viewer
    properties = { floating = true } }
}
