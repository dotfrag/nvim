return {
  "ibhagwan/fzf-lua",
  optional = true,
  -- stylua: ignore
  keys = {
    { "<leader>/", "<cmd>FzfLua grep_curbuf<cr>", desc = "Search Buffer" },
    { "<leader>sf", LazyVim.pick("auto"), desc = "Find Files (Root Dir)" },
    { "<leader>s.", "<cmd>FzfLua resume<cr>", desc = "Resume" },
    { "<leader>fl", LazyVim.pick("files", { cwd = LazyVim.get_plugin_path("LazyVim") }), desc = "Find Plugin Files" },
    { "<leader>fL", LazyVim.pick("live_grep", { cwd = LazyVim.get_plugin_path("LazyVim") }), desc = "Grep Plugin Files" },
  },
}
