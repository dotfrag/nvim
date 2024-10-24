---@class dotvim.util.fzf
local M = {}

local fzf_lua = require("fzf-lua")

function M.plugin_files()
  local path = vim.fn.stdpath("data") .. "/lazy/"
  local dirs = vim.fs.dir(path)

  local plugins = {}
  for i in dirs do
    table.insert(plugins, i)
  end

  local opts = {
    fzf_colors = true,
    actions = {
      ["default"] = {
        function(selected)
          fzf_lua.files({ cwd = path .. selected[1] })
        end,
      },
      ["ctrl-s"] = {
        function(selected)
          fzf_lua.live_grep({ cwd = path .. selected[1] })
        end,
      },
    },
  }

  fzf_lua.fzf_exec(plugins, opts)
end

return M
