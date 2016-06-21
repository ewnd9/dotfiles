local wibox = require("wibox")
local beautiful = require("beautiful")
local vicious = require("vicious")

batwidget = wibox.widget.textbox()
baticon = wibox.widget.imagebox(beautiful.widget_bat)

vicious.register(batwidget, vicious.widgets.bat,
  function (widget, args)
    if args[2] == 0 then return ""
    else
      if args[2] < 20 then
        return "<span color='red'>".. args[2] .. "%</span>"
      else
        return "<span color='white'>".. args[2] .. "%</span>"
      end
    end
  end, 61, "BAT0"
)
