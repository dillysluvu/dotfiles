return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        --component_separators = "|",
        --section_separators = "",
        --theme = "catppuccin",
        theme = "solarized_dark",
      },
    })
  end,
}
