require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful")
require("naughty")
require("vicious")
require("helpers")
require("teardrop")

if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end

awful.util.spawn_with_shell("xcompmgr &")
beautiful.init("/usr/share/awesome/themes/default/theme.lua")

terminal = "terminator"
browser = "google-chrome"
editor = "vim"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"

layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}

tags = {}
for s = 1, screen.count() do
    tags[s] = awful.tag({"一", "二", "三", "四", "五", "六", "七", "八", "九"}, s, layouts[2])
end

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}
mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })
mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
mytextclock = awful.widget.textclock({ align = "right" })
mysystray = widget({ type = "systray" })

separator = widget({ type = "imagebox" })
separator.image = image(beautiful.widget_sep)

spacer = widget({ type = "textbox" })
spacer.width = 3

cpuicon = widget({ type = "imagebox" })
cpuicon.image = image(beautiful.widget_cpu)

cpugraph  = awful.widget.graph()
cpugraph:set_width(40):set_height(16)
cpugraph:set_background_color(beautiful.fg_off_widget)
cpugraph:set_gradient_angle(0):set_gradient_colors({
  beautiful.fg_end_widget, beautiful.fg_center_widget, beautiful.fg_widget
})
vicious.register(cpugraph, vicious.widgets.cpu, "$1")

cpuwidget = widget({ type = "textbox" })
-- vicious.register(cpuwidget, vicious.widgets.cpu, " $1%", 3)
vicious.register(cpuwidget, vicious.widgets.cpu, function(widget, args)
	return ("%03d%%"):format(args[1])
end)

date_format = "%a %m/%d/%Y %l:%M%p" -- refer to http://en.wikipedia.org/wiki/Date_(Unix) specifiers
networks = {'eth0'}

tzswidget = widget({ type = "textbox" })
vicious.register(tzswidget, vicious.widgets.thermal,
  function (widget, args)
    if args[1] > 0 then
      tzfound = true
      return " " .. args[1] .. "C°"
    else return ""
    end
  end
  , 19, "thermal_zone0")

batwidget = widget({ type = "textbox" })
baticon = widget({ type = "imagebox" })
vicious.register(batwidget, vicious.widgets.bat,
  function (widget, args)
    if args[2] == 0 then return ""
    else
      baticon.image = image(beautiful.widget_bat)
      if args[2] < 30 then
        return "<span color='red'>".. args[2] .. "%</span>"
      else
        return "<span color='white'>".. args[2] .. "%</span>"
      end
    end
  end, 61, "BAT0"
)

memicon = widget({ type = "imagebox" })
memicon.image = image(beautiful.widget_mem)

memtext = widget({ type = "textbox" })
vicious.register(memtext, vicious.widgets.mem, "$2MB/$3MB", 13)

fsicon = widget({ type = "imagebox" })
fsicon.image = image(beautiful.widget_fs)
-- Initialize widgets
fs = {
  r = awful.widget.progressbar(), s = awful.widget.progressbar()
}
-- Progressbar properties
for _, w in pairs(fs) do
  w:set_vertical(true):set_ticks(true)
  w:set_height(16):set_width(5):set_ticks_size(2)
  w:set_border_color(beautiful.border_widget)
  w:set_background_color(beautiful.fg_off_widget)
  w:set_gradient_colors({ beautiful.fg_widget,
     beautiful.fg_center_widget, beautiful.fg_end_widget
  }) -- Register buttons
  w.widget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () exec("nemo", false) end)
  ))
end -- Enable caching
vicious.cache(vicious.widgets.fs)
-- Register widgets
vicious.register(fs.r, vicious.widgets.fs, "${/ used_p}",            599)
vicious.register(fs.s, vicious.widgets.fs, "${/media/files used_p}", 599)

-- function print_net(name, down, up)
--   return '<span color="'
--   .. beautiful.fg_netdn_widget ..'">' .. down .. '</span> <span color="'
--   .. beautiful.fg_netup_widget ..'">' .. up  .. '</span>'
-- end

dnicon = widget({ type = "imagebox" })
upicon = widget({ type = "imagebox" })

-- Initialize widget
netwidget = widget({ type = "textbox" })
-- Register widget
-- vicious.register(netwidget, vicious.widgets.net,
--   function (widget, args)
--     for _,device in pairs(networks) do
--       if tonumber(args["{".. device .." carrier}"]) > 0 then
--         netwidget.found = true
--         dnicon.image = image(beautiful.widget_net)
--         upicon.image = image(beautiful.widget_netup)
--         return print_net(device, args["{"..device .." down_kb}"], args["{"..device.." up_kb}"])
--       end
--     end
--   end, 3)
-- -- }}}

dateicon = widget({ type = "imagebox" })
dateicon.image = image(beautiful.widget_date)
-- Initialize widget
datewidget = widget({ type = "textbox" })
-- Register widget
--vicious.register(datewidget, vicious.widgets.date, date_format, 61)

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s], datewidget,
        spacer, batwidget,
        spacer, tzswidget,
        spacer, memtext,
        spacer, cpuwidget,
        spacer, mysystray,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

dofile("/home/ewnd9/.config/awesome/keybindings.lua")
dofile("/home/ewnd9/.config/awesome/rules.lua")
dofile("/home/ewnd9/.config/awesome/signals.lua")

dofile("/home/ewnd9/.config/awesome/startup.lua")

naughty.notify{
  title="NaughtyNotifcation",
  text="Check, if everything works.",
  opacity=0.5
}
