local wezterm = require 'wezterm';

return {
  -- color_scheme = "OneHalfDark",
  enable_csi_u_key_encoding = true,
  use_ime = false,
  hide_tab_bar_if_only_one_tab = true,
  font_size = 14.0,
  font = wezterm.font("Fira Code"),
  window_close_confirmation = "NeverPrompt",
  leader = { key="a", mods="CTRL" },
  keys = {
    { key = "s", mods = "LEADER",       action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    { key = "v", mods = "LEADER",       action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    -- Turn off the default CMD-m Hide action on macOS by making it
    -- send the empty string instead of hiding the window
    { key = "m", mods = "CMD", action = "Nop" },
   -- { key = "space", mods = "SHIFT", action = "Nop" },
  },
};
