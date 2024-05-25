return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      "shellcheck", -- bash linter
      "prettierd", -- html formatter
      "biome", -- javascript formatter
    })
  end,
}
