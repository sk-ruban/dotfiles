local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- ADJUST WINDOW PADDING IF VIM IS ON
local function is_vim(pane)
  return pane:get_foreground_process_name():find("n?vim?") ~= nil
end

local function set_padding(window, pane)
  if is_vim(pane) then
    window:set_config_overrides({
      window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
    })
  else
    window:set_config_overrides({
      window_padding = { left = 40, right = 40, top = 10, bottom = 10 }
    })
  end
end

wezterm.on("window-config-reloaded", function(window, pane)
  set_padding(window, pane)
end)

wezterm.on("update-status", function(window, pane)
  set_padding(window, pane)
end)

config = {
    -- COLOUR SCHEME
    color_scheme = 'kanagawabones',
    
    -- GENERAL
    automatically_reload_config = true,
    enable_tab_bar = false,
    default_cursor_style = "BlinkingBar",
    
    -- FONT
    font = wezterm.font({ family = 'JetBrainsMono Nerd Font', weight = 'Bold' }),
    font_size = 16,
    
    -- WINDOW
    window_close_confirmation = "NeverPrompt",
    window_decorations = 'RESIZE', -- Cannot resize with NONE
    window_background_opacity = 0.9,
    macos_window_background_blur = 30,
    window_frame = {
      font = wezterm.font({ family = 'JetBrainsMono Nerd Font', weight = 'Bold' }),
      font_size = 13,
    },
    window_padding = { left = 30, right = 30, top = 20, bottom = 0 }
}

config.set_environment_variables = {
  PATH = '/opt/homebrew/bin:' .. os.getenv('PATH')
}

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
    {
        key = ',',
        mods = 'SUPER',
        action = wezterm.action.SpawnCommandInNewTab {
            cwd = wezterm.home_dir,
            args = { 'nvim', wezterm.config_file },
        },
    },
    {
        key = '-',
        mods = 'LEADER',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        key = '\\',
        mods = 'LEADER',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    { key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
    { key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
}

return config
