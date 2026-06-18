local wezterm = require 'wezterm'
local config = {}

-- Use the retro (styled) tab bar and place it at the top
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 32

-- Powerline-style separators
local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

local tab_cwd_cache = {}

local function scheme_tab_colors(conf)
  local colors = conf.colors or {}
  local tab_bar = colors.tab_bar or {}
  local active = tab_bar.active_tab or {}
  local inactive = tab_bar.inactive_tab or {}
  local hover = inactive.hover or {}

  return {
    bg = tab_bar.background or colors.background,
    active_bg = active.bg_color or (colors.ansi and colors.ansi[2]) or colors.foreground,
    active_fg = active.fg_color or colors.background,
    inactive_bg = inactive.bg_color or colors.background,
    inactive_fg = inactive.fg_color or colors.foreground,
    hover_bg = hover.bg_color or active.bg_color or inactive.bg_color,
    hover_fg = hover.fg_color or active.fg_color or inactive.fg_color,
  }
end

local function cwd_path(cwd)
  if cwd == nil then
    return nil
  end

  if cwd.file_path and cwd.file_path ~= '' then
    return cwd.file_path
  end

  local ok, matched = pcall(function()
    return cwd:match('file://[^/]*(/.*)')
  end)
  if ok and matched and matched ~= '' then
    return matched
  end

  local uri = tostring(cwd)
  matched = uri:match('file://[^/]*(/.*)')
  if matched and matched ~= '' then
    return matched
  end

  if uri ~= '' and not uri:find('^file://') then
    return uri
  end

  return nil
end

local function basename(path)
  if path == nil or path == '' then
    return nil
  end

  path = path:gsub('[/\\]+$', '')
  local name = path:match('([^/\\]+)$')
  if name == nil or name == '' then
    return '/'
  end
  return name
end

local function pane_cwd(pane)
  if pane == nil then
    return nil
  end

  local ok, cwd = pcall(function()
    return pane.current_working_dir
  end)
  if not ok then
    return nil
  end

  return cwd_path(cwd)
end

local function folder_name(tab)
  -- Prefer explicit tab title (e.g. project folder set from nvim via wezterm cli)
  if tab.tab_title and #tab.tab_title > 0 then
    return tab.tab_title
  end

  local path = pane_cwd(tab.active_pane)

  if path == nil and tab.panes then
    for _, p in ipairs(tab.panes) do
      path = pane_cwd(p)
      if path then
        break
      end
    end
  end

  if path then
    tab_cwd_cache[tab.tab_id] = path
  else
    path = tab_cwd_cache[tab.tab_id]
  end

  return basename(path) or '~'
end

wezterm.on('update-status', function(window, pane)
  local ok, cwd = pcall(function()
    return pane:get_current_working_dir()
  end)
  if not ok or cwd == nil then
    return
  end

  local path = cwd_path(cwd)
  if path == nil then
    return
  end

  local ok_tab, tab = pcall(function()
    return window:active_tab()
  end)
  if not ok_tab or tab == nil then
    return
  end

  local ok_id, tab_id = pcall(function()
    return tab:tab_id()
  end)
  if ok_id and tab_id then
    tab_cwd_cache[tab_id] = path
  end
end)

wezterm.on('format-tab-title', function(tab, tabs, panes, conf, hover, max_width)
  local ok, title = pcall(folder_name, tab)
  if not ok or title == nil then
    title = tab.tab_title
    if title == nil or #title == 0 then
      title = basename(tab_cwd_cache[tab.tab_id]) or '~'
    end
  end

  local colors = scheme_tab_colors(conf)

  local bg, fg
  if tab.is_active then
    bg, fg = colors.active_bg, colors.active_fg
  elseif hover then
    bg, fg = colors.hover_bg, colors.hover_fg
  else
    bg, fg = colors.inactive_bg, colors.inactive_fg
  end

  title = wezterm.truncate_right(title, max_width - 4)

  return {
    { Background = { Color = colors.bg } },
    { Foreground = { Color = bg } },
    { Text = SOLID_RIGHT_ARROW },
    { Background = { Color = bg } },
    { Foreground = { Color = fg } },
    { Text = ' ' .. title .. ' ' },
    { Background = { Color = colors.bg } },
    { Foreground = { Color = bg } },
    { Text = SOLID_RIGHT_ARROW },
    { Text = ' ' },
  }
end)

return config
