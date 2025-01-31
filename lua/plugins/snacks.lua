return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>dps", false },
    },
    opts = {
      words = {
        debounce = 250, -- time in ms to wait before updating
      },
      styles = {
        notification = {
          wo = { wrap = true }, -- wrap notifications
        },
      },
      scroll = {
        enabled = false,
        animate = {
          easing = "outQuad",
        },
      },
    },
  },
}
