return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>d", desc = "Delete Buffer" },
        { "<leader>dp", hidden = true },
        { "<leader>h", group = "hunks", icon = "" },
        { "<leader>ht", desc = "Toggle" },
        { "<leader>q", desc = "Quit" },
        { "<leader>r", group = "regex", icon = "󰑑" },
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
