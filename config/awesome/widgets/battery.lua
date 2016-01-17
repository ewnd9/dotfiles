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
