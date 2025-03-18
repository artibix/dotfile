return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("venv-selector").setup({
      auto_refresh = true,
      search_venv_managers = true,
      search_workspace = true,
      search = true,
      name = ".venv",
      fd_binary_name = "fd",
      notify_user_on_activate = true,
    })

    -- 添加键位映射
    vim.keymap.set("n", "<leader>cv", "<cmd>VenvSelect<cr>", { desc = "Select VirtualEnv" })
  end,
  event = "VeryLazy",
}
