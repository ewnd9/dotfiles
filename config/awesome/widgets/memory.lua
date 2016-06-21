local wibox = require("wibox")
local vicious = require("vicious")

memtext = wibox.widget.textbox()
vicious.register(memtext, vicious.widgets.mem, "$2MB/$3MB", 13)
