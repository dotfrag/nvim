return {
  {
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
        html = { "prettierd" },
        css = { "prettierd" },
        scss = { "prettierd" },
        less = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        ["markdown.mdx"] = { "prettierd" },
      },
    },
  },

  {
    "LudoPinelli/comment-box.nvim",
    event = "LazyFile",
  },
}
