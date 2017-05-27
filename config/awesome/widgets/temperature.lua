-- forked from https://raw.githubusercontent.com/streetturtle/AwesomeWM/master/battery-widget/battery.lua

local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local watch = require("awful.widget.watch")

temp_widget = wibox.widget.textbox()

watch(
  "cat /sys/class/thermal/thermal_zone0/temp",
  10,
  function(widget, stdout, stderr, exitreason, exitcode)
    if string.len(stdout) == 0 then return end
    widget:set_text(tonumber(stdout) / 1000)
  end,
  temp_widget
)
