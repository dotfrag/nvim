return {
  {
    "danymat/neogen",
    event = "LazyFile",
    opts = {},
  },

  {
    "LudoPinelli/comment-box.nvim",
    event = "LazyFile",
    keys = {
      { "<leader>cbb", "<cmd>CBccbox<cr>", desc = "Box" },
      { "<leader>cbl", "<cmd>CBlrline<cr>", desc = "Line" },
      { "<leader>cbL", "<cmd>CBline<cr>", desc = "Line Break" },
      { "<leader>cbd", "<cmd>CBd<cr>", desc = "Delete" },
    },
  },

  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>cb", group = "comment-box" },
      },
    },
  },
}
