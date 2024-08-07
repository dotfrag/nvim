return {
  "nvim-telescope/telescope.nvim",
  optional = true,
  keys = {
    { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search Buffer" },
    { "<leader>sf", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    { "<leader>s.", "<cmd>Telescope resume<cr>", desc = "Resume" },
    {
      "<leader>fd",
      function()
        require("telescope.builtin").find_files({
          search_dirs = { "~/repos/dotfiles", "~/repos/dotfiles-private" },
          no_ignore = true,
        })
      end,
      desc = "Find Dotfiles",
    },
    {
      "<leader>fl",
      function()
        require("telescope.builtin").find_files({ cwd = LazyVim.get_plugin_path("LazyVim") })
      end,
      desc = "Find Plugin Files",
    },
    {
      "<leader>fL",
      function()
        require("telescope.builtin").live_grep({ cwd = LazyVim.get_plugin_path("LazyVim"), glob_pattern = "*.lua" })
      end,
      desc = "Grep Plugin Files",
    },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<c-enter>"] = "to_fuzzy_refine",
          ["<C-n>"] = "cycle_history_next",
          ["<C-p>"] = "cycle_history_prev",
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        },
      },
    },
  },
}
