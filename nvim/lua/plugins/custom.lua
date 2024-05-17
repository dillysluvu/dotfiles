local plugins = {
  "michaelrommel/nvim-silicon",
  lazy = true,
  cmd = "Silicon",
  init = function()
    local wk = require("which-key")
    wk.register({
      ["<leader>sp"] = { ":Silicon<CR>", "Snapshot Code" },
    }, { mode = "v" })
  end,
  config = function()
    require("silicon").setup({
      font = "JetBrainsMonoNL Nerd Font=34;Noto Color Emoji=34",
      theme = "Visual Studio Dark+",
    })
  end,
}
return plugins
