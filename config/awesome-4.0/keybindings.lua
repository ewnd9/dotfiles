local awful = require("awful")
local home = os.getenv("HOME")

local naughty = require("naughty")
globalkeys = awful.util.table.join(
  awful.key({ modkey }, "Left",   awful.tag.viewprev),
  awful.key({ modkey }, "Right",  awful.tag.viewnext),
  awful.key({ modkey }, "Escape", awful.tag.history.restore),

  awful.key({ modkey }, "j", function () awful.client.focus.byidx(1) end),
  awful.key({ modkey }, "k", function () awful.client.focus.byidx(-1) end),
  awful.key({ modkey, "Shift" }, "j", function () awful.client.swap.byidx(1) end),
  awful.key({ modkey, "Shift" }, "k", function () awful.client.swap.byidx(-1) end),
  awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative(1) end),
  awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),

  awful.key({ modkey }, "u", awful.client.urgent.jumpto),
  awful.key({ modkey }, "Tab", function ()
    awful.client.focus.history.previous()
    if client.focus then
        client.focus:raise()
    end
  end),

  awful.key({ modkey }, "Return", function () awful.spawn(terminal) end),
  awful.key({ modkey, "Control" }, "r", awesome.restart),
  awful.key({ modkey, "Shift"   }, "q", awesome.quit),

  awful.key({ modkey }, "l", function () awful.tag.incmwfact(0.05) end),
  awful.key({ modkey }, "h", function () awful.tag.incmwfact(-0.05) end),
  awful.key({ modkey }, "space", function () awful.layout.inc(1) end),
  awful.key({ modkey, "Shift" }, "space", function () awful.layout.inc(-1) end),

  awful.key({ modkey }, "r", function () awful.screen.focused().mypromptbox:run() end),
  awful.key({ modkey }, "t", function () awful.spawn(home .. "/dotfiles/scripts/gnome-terminal-tmux.sh") end),
  awful.key({ modkey }, "v", function () awful.spawn(home .. "/dotfiles/scripts/clipboard/open-web.sh") end),
  awful.key({ modkey }, "b", function () awful.spawn(home .. "/dotfiles/scripts/clipboard/open-npm.sh") end),

  awful.key({ }, "XF86AudioMute", function () awful.spawn("amixer -D pulse set Master toggle") end),
  awful.key({ }, "XF86AudioRaiseVolume", function () awful.spawn("amixer -D pulse sset Master 10%+ unmute") end),
  awful.key({ }, "XF86AudioLowerVolume", function () awful.spawn("amixer -D pulse sset Master 10%-") end),

  awful.key({ }, "XF86KbdBrightnessUp", function () awful.spawn(home .. "/dotfiles/scripts/asus/asus-kbd.sh up") end),
  awful.key({ }, "XF86KbdBrightnessDown", function () awful.spawn(home .. "/dotfiles/scripts/asus/asus-kbd.sh down") end),

  awful.key({ }, "XF86Launch1", function () awful.spawn("xbacklight -dec 10") end),
  awful.key({ }, "XF86WebCam", function () awful.spawn("xbacklight -inc 10") end),

  awful.key({ modkey, "Shift" }, "f", function () awful.spawn("gnome-system-monitor") end),
  awful.key({ modkey }, "f", function (c)
    local screen = awful.screen.focused()
    local tag = screen.tags[6]

    if tag then
      if awful.screen.focused().selected_tag.name == '六' then
        awful.tag.history.restore()
      else
        tag:view_only()
      end
    end
  end)
)

clientkeys = awful.util.table.join(
  -- awful.key({ modkey }, "f", function (c)
  --   c.fullscreen = not c.fullscreen
  --   c:raise()
  -- end),
  awful.key({ modkey, "Shift" }, "c", function (c) c:kill() end),
  awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle),
  awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
  awful.key({ modkey }, "o", function (c) c:move_to_screen() end),
  awful.key({ modkey }, "n", function (c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
  end),
  awful.key({ modkey }, "m", function (c)
    c.maximized = not c.maximized
    c:raise()
  end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
-- for i = 1, 9 do
for i = 1, 6 do
  if i ~= 6 then
    globalkeys = awful.util.table.join(globalkeys,
      awful.key({ modkey }, "#" .. i + 9, function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end)
    )
  end

  globalkeys = awful.util.table.join(globalkeys,
    awful.key({ modkey, "Shift" }, "#" .. i + 9, function ()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
          tag:view_only()
        end
      end
    end)
  )
end

clientbuttons = awful.util.table.join(
  awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize)
)

root.keys(globalkeys)
