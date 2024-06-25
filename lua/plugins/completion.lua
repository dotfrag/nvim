return {
  "nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.mapping["<CR>"] = function(fallback)
      cmp.abort()
      fallback()
    end
    opts.mapping["<C-y>"] = LazyVim.cmp.confirm()
    opts.mapping["<C-d>"] = cmp.mapping.scroll_docs(4)
    opts.mapping["<C-u>"] = cmp.mapping.scroll_docs(-4)
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
