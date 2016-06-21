local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")

local naughty = require("naughty")
local menubar = require("menubar")

naughty.config.padding = 30
naughty.config.presets.normal.font = "monospace 20"

require("debian.menu")

if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end

awful.util.spawn_with_shell("xcompmgr &")
beautiful.init("/home/ewnd9/.config/awesome/theme.lua")

terminal = "gnome-terminal"
browser = "google-chrome"
editor = "vim"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"

dofile("/home/ewnd9/.config/awesome/layouts.lua")
dofile("/home/ewnd9/.config/awesome/menu.lua")
dofile("/home/ewnd9/.config/awesome/tags.lua")

dofile("/home/ewnd9/.config/awesome/taskbar.lua")
dofile("/home/ewnd9/.config/awesome/keybindings.lua")
dofile("/home/ewnd9/.config/awesome/rules.lua")
dofile("/home/ewnd9/.config/awesome/signals.lua")
