-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "Chromium" },
      properties = { tag = tags[1][1] } },
    { rule = { class = "Intellij Idea" },
      properties = { tag = tags[1][2] } },
    { rule = { class = "Skype" },
      properties = { tag = tags[1][5] } },
  { rule = { class = "Telegram" },
    properties = { tag = tags[1][5] } },
    { rule = { class = "Geary" },
      properties = { tag = tags[1][9] } },
    { rule = { class = "Guake" },
      properties = {opacity = 0.7} },
  { rule = { class = "Terminator" },
    properties = { size_hints_honor = false } },
  { rule = { class = "Gnome-Terminal" },
    properties = { size_hints_honor = false } },
  { rule = { class = "Gnome-terminal" },
    properties = { size_hints_honor = false } }
}
-- }}}

