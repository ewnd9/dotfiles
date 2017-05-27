-- forked from https://raw.githubusercontent.com/streetturtle/AwesomeWM/master/battery-widget/battery.lua

local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local watch = require("awful.widget.watch")

battery_widget = wibox.widget.textbox()

watch(
  "acpi",
  10,
  function(widget, stdout, stderr, exitreason, exitcode)
    local batteryType
    local _, status, charge_str = string.match(stdout, '(.+): (%a+), (%d+)%.*')

    if (tonumber(charge_str) < 20) then
      widget:set_markup_silently("<span color='red'>" .. charge_str .. "%</span>")
    else
      widget:set_markup_silently("<span color='white'>" .. charge_str .. "%</span>")
    end
  end,
  battery_widget
)
