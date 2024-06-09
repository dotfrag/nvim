return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      "prettierd", -- html formatter
      "biome", -- javascript formatter
    })
  end,
}
