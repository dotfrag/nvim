return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters = {
      shfmt = { prepend_args = { "-i", "2", "-ci" } },
      biome = { prepend_args = { "format", "--indent-style", "space" } },
    },
    formatters_by_ft = {
      fish = {}, -- reset lazyvim value

      -- biome
      javascript = { "biome" },
      typescript = { "biome" },
      json = { "biome" },
      jsonc = { "biome" },

      -- prettier
      html = { { "prettierd", "prettier" } },
      css = { { "prettierd", "prettier" } },
      scss = { { "prettierd", "prettier" } },
      less = { { "prettierd", "prettier" } },
      yaml = { { "prettierd", "prettier" } },
      markdown = { { "prettierd", "prettier" } },
      ["markdown.mdx"] = { { "prettierd", "prettier" } },
    },
  },
}
