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
