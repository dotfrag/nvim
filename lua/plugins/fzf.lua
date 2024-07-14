return {
  "ibhagwan/fzf-lua",
  optional = true,
  keys = function(_, keys)
    local fd_opts = require("fzf-lua").defaults.files.fd_opts
    local rg_opts = require("fzf-lua").defaults.grep.rg_opts

    vim.list_extend(keys, {
      { "<leader>/", "<cmd>FzfLua grep_curbuf<cr>", desc = "Search Buffer" },
      { "<leader>sf", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader>s.", "<cmd>FzfLua resume<cr>", desc = "Resume" },
      {
        "<leader>fd",
        LazyVim.pick("files", { fd_opts = ". ~/repos/dotfiles ~/repos/dotfiles-private " .. fd_opts }),
        desc = "Find Dotfiles",
      },
      { "<leader>fl", LazyVim.pick("files", { cwd = LazyVim.get_plugin_path("LazyVim") }), desc = "Find Plugin Files" },
      {
        "<leader>fL",
        LazyVim.pick("live_grep", {
          cwd = LazyVim.get_plugin_path("LazyVim"),
          rg_opts = "-g '*.lua' " .. rg_opts,
        }),
        desc = "Grep Plugin Files",
      },
    })
  end,
}
