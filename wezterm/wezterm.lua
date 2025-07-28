local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Visuals
config.color_scheme = "Everforest Dark Medium (Gogh)"

config.window_decorations = "RESIZE"

config.initial_cols = 160
config.initial_rows = 48
config.window_background_opacity = 0.8
config.macos_window_background_blur = 30

-- Keybinds
config.keys = {
	-- Word skipping
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
	{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
	-- Move across windows
	{ key = "h", mods = "CTRL|CMD", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "k", mods = "CTRL|CMD", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "l", mods = "CTRL|CMD", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "j", mods = "CTRL|CMD", action = wezterm.action.ActivatePaneDirection("Down") },
	-- Toggle bottom term
	{
		key = "/",
		mods = "CTRL",
		action = wezterm.action.TogglePaneZoomState,
	},
	-- Split pane Vertically / Horizontally
	{
		key = "h",
		mods = "SHIFT|CMD",
		action = wezterm.action.SplitPane({ direction = "Left", size = { Percent = 50 } }),
	},
	{
		key = "k",
		mods = "SHIFT|CMD",
		action = wezterm.action.SplitPane({ direction = "Up", size = { Percent = 50 } }),
	},
	{
		key = "l",
		mods = "SHIFT|CMD",
		action = wezterm.action.SplitPane({ direction = "Right", size = { Percent = 50 } }),
	},
	{
		key = "h",
		mods = "SHIFT|CMD",
		action = wezterm.action.SplitPane({ direction = "Down", size = { Percent = 50 } }),
	},
}

return config
