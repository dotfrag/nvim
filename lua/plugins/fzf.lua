local rg_opts = ""
if LazyVim.has_extra("editor.fzf") then
  rg_opts = require("fzf-lua").defaults.grep.rg_opts
end

return {
  "ibhagwan/fzf-lua",
  optional = true,
  keys = {
    { "<leader>/", "<cmd>FzfLua grep_curbuf<cr>", desc = "Search Buffer" },
    { "<leader>sf", LazyVim.pick("auto"), desc = "Find Files (Root Dir)" },
    { "<leader>s.", "<cmd>FzfLua resume<cr>", desc = "Resume" },
    { "<leader>fl", LazyVim.pick("files", { cwd = LazyVim.get_plugin_path("LazyVim") }), desc = "Find Plugin Files" },
    {
      "<leader>fL",
      LazyVim.pick("live_grep", {
        cwd = LazyVim.get_plugin_path("LazyVim"),
        rg_opts = "-g '*.lua' " .. rg_opts,
      }),
      desc = "Grep Plugin Files",
    },
  },
}
