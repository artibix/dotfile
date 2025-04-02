return {
  {
    "ojroques/nvim-osc52",
    config = function()
      require("osc52").setup({
        max_length = 0, -- 无限制长度
        silent = true, -- 静默模式，不显示消息
        trim = false, -- 不裁剪空白字符
        tmux_passthrough = true, -- 如果在 tmux 中，启用透传
      })

      -- 复制到系统剪贴板函数
      local function copy(lines, _)
        require("osc52").copy(table.concat(lines, "\n"))
      end

      -- 复制到系统剪贴板（寄存器 '+' 和 '*'）
      local function copy_register()
        if
          vim.v.event.operator == "y"
          and (vim.v.event.regname == "+" or vim.v.event.regname == "*" or vim.v.event.regname == "")
        then
          require("osc52").copy_register(vim.v.event.regname == "" and '"' or vim.v.event.regname)
        end
      end

      -- 使用 OSC52 作为剪贴板提供程序
      vim.api.nvim_create_autocmd("TextYankPost", { callback = copy_register })

      -- 设置 Neovim 剪贴板提供程序
      vim.g.clipboard = {
        name = "osc52",
        copy = { ["+"] = copy, ["*"] = copy },
        paste = {
          ["+"] = function()
            return { vim.fn.getreg("+") }
          end,
          ["*"] = function()
            return { vim.fn.getreg("*") }
          end,
        },
        cache_enabled = true,
      }
    end,
  },
}
