---------------------------
-- Default awesome theme --
---------------------------

local theme = {}
local home = os.getenv("HOME")
local theme_dir = home .. "/.config/awesome/theme"

theme.font          = "Sans 8"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = 0
theme.border_width  = 0
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = theme_dir .. "/taglist/squarefw_2.png"
theme.taglist_squares_unsel = theme_dir .. "/taglist/squarew_2.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme_dir .. "/submenu.png"
theme.menu_height = 15
theme.menu_width  = 100

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = theme_dir .. "/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = theme_dir .. "/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = theme_dir .. "/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = theme_dir .. "/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme_dir .. "/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = theme_dir .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme_dir .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = theme_dir .. "/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme_dir .. "/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = theme_dir .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme_dir .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = theme_dir .. "/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme_dir .. "/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = theme_dir .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme_dir .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = theme_dir .. "/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme_dir .. "/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme_dir .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme_dir .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = theme_dir .. "/titlebar/maximized_focus_active.png"

theme.wallpaper = theme_dir .. "/background.png"

-- You can use your own layout icons like this:
theme.layout_fairh = theme_dir .. "/layouts/fairhw.png"
theme.layout_fairv = theme_dir .. "/layouts/fairvw.png"
theme.layout_floating  = theme_dir .. "/layouts/floatingw.png"
theme.layout_magnifier = theme_dir .. "/layouts/magnifierw.png"
theme.layout_max = theme_dir .. "/layouts/maxw.png"
theme.layout_fullscreen = theme_dir .. "/layouts/fullscreenw.png"
theme.layout_tilebottom = theme_dir .. "/layouts/tilebottomw.png"
theme.layout_tileleft   = theme_dir .. "/layouts/tileleftw.png"
theme.layout_tile = theme_dir .. "/layouts/tilew.png"
theme.layout_tiletop = theme_dir .. "/layouts/tiletopw.png"
theme.layout_spiral  = theme_dir .. "/layouts/spiralw.png"
theme.layout_dwindle = theme_dir .. "/layouts/dwindlew.png"
theme.layout_cornernw = theme_dir .. "/layouts/cornernww.png"
theme.layout_cornerne = theme_dir .. "/layouts/cornernew.png"
theme.layout_cornersw = theme_dir .. "/layouts/cornersww.png"
theme.layout_cornerse = theme_dir .. "/layouts/cornersew.png"

theme.awesome_icon = theme_dir .. "/awesome16.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
