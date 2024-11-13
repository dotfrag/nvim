local sql_formatter_opts = {
  keywordCase = "upper",
  dataTypeCase = "upper",
  functionCase = "upper",
  expressionWidth = 80,
}

return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      shfmt = { prepend_args = { "-i", "2", "-ci" } },
      biome = { prepend_args = { "format", "--indent-style", "space" } },
      sql_formatter = { prepend_args = { "--config", vim.json.encode(sql_formatter_opts) } },
    },
    formatters_by_ft = {
      --- shell
      fish = {}, -- reset lazyvim value
      sh = { "shfmt", "shellcheck" },

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

      htmldjango = { "djlint" },
      python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
      sql = { "sql_formatter" },
    },
  },
}
