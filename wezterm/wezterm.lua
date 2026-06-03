local wezterm = require("wezterm")

local config = wezterm.config_builder()

local act = wezterm.action
-- Visuals
config.color_scheme = "Black Metal (Bathory) (base16)"
config.font = wezterm.font("FiraCode Nerd Font", { weight = "Medium" })
config.font_size = 13

config.window_decorations = "RESIZE"
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 60

config.initial_cols = 160
config.initial_rows = 48
config.window_background_opacity = 0.9
config.macos_window_background_blur = 120
config.leader = { key = 'a', mods = 'CTRL' }

-- Keybinds
config.keys = {
  -- Word skipping
  { key = "LeftArrow",  mods = "OPT",      action = wezterm.action({ SendString = "\x1bb" }) },
  { key = "RightArrow", mods = "OPT",      action = wezterm.action({ SendString = "\x1bf" }) },
  -- Move across windows
  { key = "h",          mods = "CTRL|CMD", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "k",          mods = "CTRL|CMD", action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "l",          mods = "CTRL|CMD", action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "j",          mods = "CTRL|CMD", action = wezterm.action.ActivatePaneDirection("Down") },
  -- Toggle bottom term
  {
    key = "/",
    mods = "CTRL",
    action = wezterm.action.TogglePaneZoomState,
  },
  -- Split pane Vertically / Horizontally
  {
    key = "k",
    mods = "SHIFT|CMD",
    action = wezterm.action.SplitPane({ direction = "Up", size = { Percent = 50 } }),
  },
  {
    key = "h",
    mods = "SHIFT|CMD",
    action = wezterm.action.SplitPane({ direction = "Left", size = { Percent = 50 } }),
  },
  {
    key = "l",
    mods = "SHIFT|CMD",
    action = wezterm.action.SplitPane({ direction = "Right", size = { Percent = 50 } }),
  },
  {
    key = "j",
    mods = "SHIFT|CMD",
    action = wezterm.action.SplitPane({ direction = "Down", size = { Percent = 50 } }),
  },
  {
    key = "h",
    mods = "LEADER",
    action = act.AdjustPaneSize { 'Left', 5 }
  },
  {
    key = "j",
    mods = "LEADER",
    action = act.AdjustPaneSize { 'Up', 5 }
  },
  {
    key = "k",
    mods = "LEADER",
    action = act.AdjustPaneSize { 'Down', 5 }
  },
  {
    key = "l",
    mods = "LEADER",
    action = act.AdjustPaneSize { 'Right', 5 }
  },
}

return config
