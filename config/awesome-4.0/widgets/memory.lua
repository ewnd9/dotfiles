-- forked from https://raw.githubusercontent.com/streetturtle/AwesomeWM/master/battery-widget/battery.lua

local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local watch = require("awful.widget.watch")

memory_widget = wibox.widget.textbox()

watch(
  "cat /proc/meminfo",
  10,
  function(widget, stdout, stderr, exitreason, exitcode)
    -- forked from https://github.com/Mic92/vicious/blob/master/widgets/mem_linux.lua
    local mem = { buf = {}, swp = {} }

    for line in io.lines("/proc/meminfo") do
      for k, v in string.gmatch(line, "([%a]+):[%s]+([%d]+).+") do
        if     k == "MemTotal"  then mem.total = math.floor(v/1024)
        elseif k == "MemFree"   then mem.buf.f = math.floor(v/1024)
        elseif k == "Buffers"   then mem.buf.b = math.floor(v/1024)
        elseif k == "Cached"    then mem.buf.c = math.floor(v/1024)
        elseif k == "SwapTotal" then mem.swp.t = math.floor(v/1024)
        elseif k == "SwapFree"  then mem.swp.f = math.floor(v/1024)
        end
      end
    end

    -- Calculate memory percentage
    mem.free  = mem.buf.f + mem.buf.b + mem.buf.c
    mem.inuse = mem.total - mem.free
    mem.bcuse = mem.total - mem.buf.f
    mem.usep  = math.floor(mem.inuse / mem.total * 100)
    -- Calculate swap percentage
    mem.swp.inuse = mem.swp.t - mem.swp.f
    mem.swp.usep  = math.floor(mem.swp.inuse / mem.swp.t * 100)

    widget:set_text(mem.inuse .. "MB/" .. mem.total .. "MB")
  end,
  memory_widget
)
