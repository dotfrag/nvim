return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      "biome", -- javascript formatter
      "djlint", -- django formatter
      "prettierd", -- html formatter
      "sql-formatter", -- sql formatter
    })

    LazyVim.on_load("mason.nvim", function()
      DotVim.run()
    end)
  end,
}
