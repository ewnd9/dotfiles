local wibox = require("wibox")
local vicious = require("vicious")

tempwidget = wibox.widget.textbox()
vicious.register(tempwidget, vicious.widgets.thermal,
  function (widget, args)
    if args[1] > 0 then
      tzfound = true
      return " " .. args[1] .. "C°"
    else return ""
    end
  end
  , 19, "thermal_zone0")
