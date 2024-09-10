local wezterm = require("wezterm")

return {
  color_scheme = "Solarized Osaka",
  colors = {
    foreground = "#839496", -- s:base0
    background = "#002b36", -- s:base03
    cursor_bg = "#839496",  -- s:base0
    cursor_border = "#839496", -- s:base0
    cursor_fg = "#002b36", -- s:base03
    selection_bg = "#073642", -- s:base02
    selection_fg = "#839496", -- s:base0

    ansi = {
      "#002b36", "#dc322f", "#859900", "#b58900",
      "#268bd2", "#d33682", "#2aa198", "#eee8d5"
    },
    brights = {
      "#073642", "#cb4b16", "#586e75", "#657b83",
      "#6c71c4", "#d33682", "#2aa198", "#fdf6e3"
    },

    tab_bar = {
      background = "#002b36",
      active_tab = { bg_color = "#657b83", fg_color = "#fdf6e3" },
      inactive_tab = { bg_color = "#073642", fg_color = "#839496" },
      inactive_tab_hover = { bg_color = "#586e75", fg_color = "#fdf6e3", italic = true },
      new_tab = { bg_color = "#073642", fg_color = "#93a1a1" },
      new_tab_hover = { bg_color = "#586e75", fg_color = "#fdf6e3", italic = true },
    },
  },

  font = wezterm.font("JetBrains Mono"),
  font_size = 16,
  window_background_opacity = 0.92,
  window_decorations = "NONE",
  enable_tab_bar = false,

  keys = {
    { key = "f", mods = "CTRL", action = wezterm.action.ToggleFullScreen },
    { key = "q", mods = "CTRL", action = wezterm.action.QuitApplication },
    { key = "h", mods = "SUPER", action = wezterm.action.Hide },
    { key = "v", mods = "ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "h", mods = "ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  },

  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "CTRL",
      action = wezterm.action.OpenLinkAtMouseCursor,
    },
  },
}

