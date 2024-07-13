return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>q", desc = "Quit" },
        { "<leader>r", group = "regex", icon = "󰑑" },
        { "<leader>h", group = "hunks", icon = "" },
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
