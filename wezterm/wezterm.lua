local wezterm = require("wezterm")

return {
	color_scheme = "Catppuccin Mocha",
	--color_scheme = "Twilight (dark) (terminal.sexy)",

	enable_tab_bar = false,
	font_size = 16,
	font = wezterm.font("JetBrains Mono"),
	macos_window_background_blur = 40,
	-- macos_window_background_blur = 30,

	-- window_background_image = "/home/mcv/Pictures/meo.png",
	-- window_background_image_hsb = {
	--   brightness = 0.01,
	--   hue = 1.0,
	--   saturation = 0.5,
	-- },

	window_background_opacity = 0.92,
	-- window_background_opacity = 1,
	-- window_background_opacity = 0.78,
	-- window_background_opacity = 0.20,
	window_decorations = "NONE",

	keys = {
		{ key = "f", mods = "CTRL", action = wezterm.action.ToggleFullScreen },
		{ key = "q", mods = "CTRL", action = wezterm.action.QuitApplication },
		{ key = "h", mods = "SUPER", action = wezterm.action.Hide },
		{ key = "v", mods = "ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "h", mods = "ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	},

	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}
