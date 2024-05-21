return {
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>q"] = "Quit",
        ["<leader>r"] = { name = "+regex", _ = "which_key_ignore" },
        ["<leader>h"] = { name = "+hunks", _ = "which_key_ignore" },
      },
    },
  },

  {
    "folke/persistence.nvim",
    keys = function()
      return {}
    end,
  },
}
