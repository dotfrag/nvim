return {
  "iguanacucumber/magazine.nvim",
  name = "nvim-cmp",
  optional = true,
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.mapping["<CR>"] = function(fallback)
      cmp.abort()
      fallback()
    end
    opts.mapping["<C-y>"] = LazyVim.cmp.confirm()
    opts.mapping["<C-d>"] = cmp.mapping.scroll_docs(4)
    opts.mapping["<C-u>"] = cmp.mapping.scroll_docs(-4)

    -- https://github.com/LazyVim/LazyVim/pull/4052#issuecomment-2249293126
    opts.window = {
      completion = cmp.config.window.bordered({
        border = {
          { "󱐋", "WarningMsg" },
          { "─", "Comment" },
          { "╮", "Comment" },
          { "│", "Comment" },
          { "╯", "Comment" },
          { "─", "Comment" },
          { "╰", "Comment" },
          { "│", "Comment" },
        },
      }),
      documentation = cmp.config.window.bordered({
        border = {
          { "", "DiagnosticHint" },
          { "─", "Comment" },
          { "╮", "Comment" },
          { "│", "Comment" },
          { "╯", "Comment" },
          { "─", "Comment" },
          { "╰", "Comment" },
          { "│", "Comment" },
        },
      }),
    }
  end,
  keys = function()
    return {
      {
        "<C-l>",
        function()
          return vim.snippet.active({ direction = 1 }) and "<cmd>lua vim.snippet.jump(1)<cr>" or "<Tab>"
        end,
        expr = true,
        silent = true,
        mode = { "i", "s" },
      },
      {
        "<C-h>",
        function()
          return vim.snippet.active({ direction = -1 }) and "<cmd>lua vim.snippet.jump(-1)<cr>" or "<Tab>"
        end,
        expr = true,
        silent = true,
        mode = { "i", "s" },
      },
    }
  end,
}
