return {
  {
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
    opts = {
      settings = {
        options = {
          enable_default_searches = false,
        },

        search = {
          MacAnaconda3 = {
            command = "fd /bin/python$ /opt/anaconda3/envs/ --full-path",
          },
          MacOS = {
            command = "fd 'bin/python' /Library/Frameworks/Python.framework/ --full-path",
          },
          workspace = {
            command = "fd 'bin/python' .venv -I --full-path",
          },
        },
      },
    },
    event = "VeryLazy",
  },
}
