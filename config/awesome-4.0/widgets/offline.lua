local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local watch = require("awful.widget.watch")

offline_widget = wibox.widget.textbox()

watch(
  "/home/ewnd9/github/offline/run.sh",
  60,
  function(widget, stdout, stderr, exitreason, exitcode)
    widget:set_markup_silently("<span>" .. stdout .. "</span>")
  end,
  offline_widget
)
