return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
    "mfussenegger/nvim-dap-python", --optional
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  branch = "regexp",
  keys = {
    { "<leader>cv", "<cmd>VenvSelect<cr>", { desc = "Select VirtualEnv" } },
  },
  config = function()
    require("venv-selector").setup({
      settings = {
        options = {
          enable_default_searches = false,
        },
        search = {
          anaconda3 = {
            command = "fd /bin/python$ /opt/anaconda3/envs/ --full-path",
            tyep = "Mac:anaconda3",
          },
          current = {
            command = "fd 'bin/python' /Library/Frameworks/Python.framework/ --full-path",
            type = "MacOS",
          },
          venv = {
            command = "fd 'bin/python' .venv -I --full-path",
            type = "currentDirectoryVenv",
          },
        },
      },
    })
  end,
  event = "VeryLazy",
}
