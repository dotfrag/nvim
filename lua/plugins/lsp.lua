local biome = require("lspconfig.server_configurations.biome")
local biome_ft = biome.default_config.filetypes
biome_ft = vim.tbl_filter(function(ft)
  return not vim.tbl_contains({ "astro" }, ft)
end, biome_ft)

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      biome = { filetypes = biome_ft },
    },
  },
}
