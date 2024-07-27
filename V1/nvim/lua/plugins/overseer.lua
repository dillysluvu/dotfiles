return {
  "stevearc/overseer.nvim",
  config = function()
    require("overseer").setup({
      templates = { "builtin", "user.cpp_build", "user.run_script" },
    })
  end,
}
