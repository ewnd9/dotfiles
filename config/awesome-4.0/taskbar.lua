local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local home = os.getenv("HOME")

local function client_menu_toggle_fn()
  local instance = nil

  return function ()
    if instance and instance.wibox.visible then
      instance:hide()
      instance = nil
    else
      instance = awful.menu.clients({ theme = { width = 250 } })
    end
  end
end

-- Create a wibox for each screen and add it
local taglist_buttons = awful.util.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
      if client.focus then
          client.focus:move_to_tag(t)
      end
  end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
      if client.focus then
          client.focus:toggle_tag(t)
      end
  end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = awful.util.table.join(
  awful.button({ }, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      -- Without this, the following
      -- :isvisible() makes no sense
      c.minimized = false
      if not c:isvisible() and c.first_tag then
        c.first_tag:view_only()
      end
      -- This will also un-minimize
      -- the client, if needed
      client.focus = c
      c:raise()
    end
  end),
  awful.button({ }, 3, client_menu_toggle_fn()),
  awful.button({ }, 4, function ()
    awful.client.focus.byidx(1)
  end),
  awful.button({ }, 5, function ()
    awful.client.focus.byidx(-1)
  end)
)

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

dofile(home .. "/.config/awesome/widgets/offline.lua")
dofile(home .. "/.config/awesome/widgets/battery.lua")
dofile(home .. "/.config/awesome/widgets/memory.lua")
dofile(home .. "/.config/awesome/widgets/spacer.lua")
dofile(home .. "/.config/awesome/widgets/temperature.lua")

awful.screen.connect_for_each_screen(function(s)
  set_wallpaper(s)
  awful.tag({ "一", "二", "三", "四", "五", "六", "七", "八", "九" }, s, awful.layout.layouts[1])

  s.mypromptbox = awful.widget.prompt()
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)))

  s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)
  s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)
  s.mywibox = awful.wibar({ position = "top", screen = s })
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      mylauncher,
      s.mytaglist,
      s.mypromptbox
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.systray(),
      spacer,
      memory_widget,
      spacer,
      offline_widget,
      spacer,
      temp_widget,
      spacer,
      battery_widget,
      spacer,
      s.mylayoutbox
    },
  }
end)
