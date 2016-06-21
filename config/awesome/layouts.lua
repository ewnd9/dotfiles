local awful = require("awful")

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
    tags[s] = awful.tag({"一", "二", "三", "四", "五", "六", "七", "八", "九"}, s, layouts[3])

    for i = 1, 9 do
      awful.tag.setmwfact(0.25, tags[s][i])
    end
end
