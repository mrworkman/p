-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.default_prog = { "zsh", "-ilc", "exec tmux" }

-- This is where you actually apply your config choices
-- config.color_scheme = 'PaperColor Light (base16)'
config.color_scheme = "Steve"

config.font = wezterm.font("Fira Code", { weight = "Regular" })
config.font_size = 14
config.enable_tab_bar = false

-- MacOS specific.
config.keys = {
   {
      key = "LeftArrow",
      mods = "SUPER",
      action = act.SendKey { key = 'Home', mods = "NONE" },
   },
   {
      key = "RightArrow",
      mods = "SUPER",
      action = act.SendKey { key = 'End', mods = "NONE" },
   },
}

config.window_padding = {
   left = 0,
   top = 2,
   right = 0,
   bottom = 0,
}

-- and finally, return the configuration to wezterm
return config
