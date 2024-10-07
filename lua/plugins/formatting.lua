local sql_formatter_opts = {
  keywordCase = "upper",
  dataTypeCase = "upper",
  functionCase = "upper",
  expressionWidth = 80,
}

return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters = {
      shfmt = { prepend_args = { "-i", "2", "-ci" } },
      biome = { prepend_args = { "format", "--indent-style", "space" } },
      sql_formatter = { prepend_args = { "--config", vim.json.encode(sql_formatter_opts) } },
    },
    formatters_by_ft = {
      fish = {}, -- reset lazyvim value

      -- biome
      javascript = { "biome" },
      typescript = { "biome" },
      json = { "biome" },
      jsonc = { "biome" },

      -- prettier
      html = { "prettierd" },
      css = { "prettierd" },
      scss = { "prettierd" },
      less = { "prettierd" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
      ["markdown.mdx"] = { "prettierd" },

      sql = { "sql_formatter" },

      htmldjango = { "djlint" },
    },
  },
}
