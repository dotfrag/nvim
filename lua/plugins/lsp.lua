return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local biome = require("lspconfig.configs.biome")
    local biome_ft = biome.default_config.filetypes
    biome_ft = vim.tbl_filter(function(ft)
      return not vim.tbl_contains({ "astro" }, ft)
    end, biome_ft)

    opts.servers.biome = { filetypes = biome_ft }
  end,
}
