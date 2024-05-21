return {
  "folke/zen-mode.nvim",
  dependencies = { "folke/twilight.nvim" },
  cmd = "ZenMode",
  -- stylua: ignore
  keys = {
    { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    { "<leader>Z", function() require("zen-mode").toggle({ plugins = { twilight = { enabled = true } } }) end, desc = "Zen Twilight Mode" },
  },
  opts = {
    window = {
      options = {
        number = false,
        relativenumber = false,
      },
    },
    plugins = {
      twilight = { enabled = false },
    },
  },
}
