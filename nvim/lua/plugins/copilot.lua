return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        -- 面板配置
        panel = {
          enabled = true,
          auto_refresh = true, -- 是否自动刷新建议
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom", -- 可选: bottom | top | left | right
            ratio = 0.4,
          },
        },

        -- 建议配置
        suggestion = {
          enabled = true,
          auto_trigger = true, -- 设置为 true 可自动显示建议
          debounce = 75, -- 延迟时间(毫秒)
          keymap = {
            accept = "<M-l>", -- 接受建议的快捷键
            accept_word = false, -- 接受单词建议
            accept_line = false, -- 接受整行建议
            next = "<M-]>", -- 下一个建议
            prev = "<M-[>", -- 上一个建议
            dismiss = "<C-]>", -- 取消建议
          },
        },

        -- 文件类型配置
        filetypes = {
          yaml = true, -- 启用特定文件类型
          markdown = true,
          help = false,
          gitcommit = true,
          gitrebase = true,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
          -- 添加您需要支持的其他文件类型
          python = true,
          javascript = true,
          typescript = true,
          lua = true,
          markdown = true,
        },

        -- Node 命令配置
        copilot_node_command = "node", -- 或指定特定路径

        -- 服务器选项覆盖
        server_opts_overrides = {
          settings = {
            advanced = {
              listCount = 10, -- 面板中的建议数量
              inlineSuggestCount = 5, -- 内联建议数量
            },
          },
        },
      })
    end,
  },
}
