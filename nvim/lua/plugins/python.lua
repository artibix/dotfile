return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
    "mfussenegger/nvim-dap-python", --optional
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  branch = "regexp",
  config = function()
    require("venv-selector").setup({
      settings = {
        search = {
          find_code_venvs = {
            command = "fd /bin/python$ /opt/anaconda3/envs/ --full-path",
          },
        },
      },
    })
    -- 添加键位映射
    vim.keymap.set("n", "<leader>cv", "<cmd>VenvSelect<cr>", { desc = "Select VirtualEnv" })
  end,
  event = "VeryLazy",
}
