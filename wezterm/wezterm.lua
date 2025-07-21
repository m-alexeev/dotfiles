local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Visuals
config.color_scheme = "Everforest Dark Medium (Gogh)"

config.window_decorations = "RESIZE"

config.initial_cols = 160
config.initial_rows = 48
config.window_background_opacity = 0.7
config.macos_window_background_blur = 30

wezterm.on("toggle_bottom_zoom_pane", function(window, pane)
	local panes = window:active_tab():panes()
	if #panes == 1 then
		window:perform_action(
			wezterm.action.SplitPane({
				direction = "Down",
				size = { Percent = 20 },
			}),
			pane
		)
	else
		window:perform_action(wezterm.action.ActivatePaneByIndex(0), pane)
		wezterm.time.call_after(0.05, function()
			local new_pane = window:active_pane()
			window:perform_action(wezterm.action.TogglePaneZoomState, new_pane)
		end)
	end
end)

-- Keybinds
config.keys = {
	{ key = "h", mods = "CTRL|CMD", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "k", mods = "CTRL|CMD", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "l", mods = "CTRL|CMD", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "j", mods = "CTRL|CMD", action = wezterm.action.ActivatePaneDirection("Down") },
	{
		key = "/",
		mods = "CTRL",
		action = wezterm.action.EmitEvent("toggle_bottom_zoom_pane"),
	},
}

return config
