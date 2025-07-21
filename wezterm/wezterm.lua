local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Visuals
config.color_scheme = "Everforest Dark Medium (Gogh)"

config.window_decorations = "RESIZE"

config.initial_cols = 160
config.initial_rows = 48
config.window_background_opacity = 0.7
config.macos_window_background_blur = 30

-- Keybinds
config.keys = {
	{
		key = "/",
		mods = "CTRL",
		action = wezterm.action.SplitPane({
			direction = "Down",
			size = { Percent = 20 },
		}),
	},
	{ key = "h", mods = "CTRL|CMD", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CTRL|CMD", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CTRL|CMD", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CTRL|CMD", action = wezterm.action.ActivatePaneDirection("Down") },
}

return config
