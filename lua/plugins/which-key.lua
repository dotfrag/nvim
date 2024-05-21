return {
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>q"] = "Quit",
        ["<leader>r"] = { name = "+regex" },
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
