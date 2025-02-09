return {
  {
    "folke/snacks.nvim",
    optional = true,
    -- stylua: ignore
    keys = {
      { "<leader>dps", false },
      { "<leader>/", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sf", function() Snacks.picker.files() end, desc = "Find Files (Root Dir)" },
      { "<leader>.", function() Snacks.picker.resume() end, desc = "Resume" },
      { "<leader>fd", function() Snacks.picker.files({ dirs = { "~/repos/dotfiles", "~/repos/dotfiles-private" } }) end, desc = "Find Dotfiles" },
      { "<leader>fl", function() Snacks.picker.files({ dirs = { LazyVim.get_plugin_path("LazyVim") } }) end, desc = "Find LazyVim Files" },
      { "<leader>fL", function() Snacks.picker.grep({ dirs = { LazyVim.get_plugin_path("LazyVim") } }) end, desc = "Grep LazyVim Files" },
      -- { "<leader>fP", DotVim.snacks.plugin_files, desc = "Find Plugin Files" },
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
