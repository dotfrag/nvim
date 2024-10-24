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

function M.projects()
  if LazyVim.pick.picker.name == "telescope" then
    return vim.cmd("Telescope projects")
  elseif LazyVim.pick.picker.name == "fzf" then
    local project = require("project_nvim.project")
    local history = require("project_nvim.utils.history")
    local results = history.get_recent_projects()
    local utils = require("fzf-lua.utils")

    local function hl_validate(hl)
      return not utils.is_hl_cleared(hl) and hl or nil
    end

    local function ansi_from_hl(hl, s)
      return utils.ansi_from_hl(hl_validate(hl), s)
    end

    ------@param selected string[]
    ------@param pick? boolean
    ---local function cd(selected, pick)
    ---  local path = selected[1]
    ---  if vim.fn.getcwd() == vim.env.HOME then
    ---    local ok = project.set_pwd(path)
    ---    if ok and not pick then
    ---      vim.api.nvim_win_close(0, false)
    ---      LazyVim.info("Change project dir to " .. path)
    ---    end
    ---  end
    ---  if pick then
    ---    fzf_lua.files({ cwd = path })
    ---  else
    ---  end
    ---end

    local opts = {
      fzf_opts = {
        ["--header"] = string.format(
          ":: <%s> to %s | <%s> to %s | <%s> to %s",
          ansi_from_hl("FzfLuaHeaderBind", "ctrl-s"),
          ansi_from_hl("FzfLuaHeaderText", "live_grep"),
          ansi_from_hl("FzfLuaHeaderBind", "ctrl-r"),
          ansi_from_hl("FzfLuaHeaderText", "oldfiles"),
          ansi_from_hl("FzfLuaHeaderBind", "ctrl-w"),
          ansi_from_hl("FzfLuaHeaderText", "change_dir")
        ),
      },
      fzf_colors = true,
      actions = {
        ["default"] = {
          function(selected)
            -- cd(selected, true)
            fzf_lua.files({ cwd = selected[1] })
          end,
        },
        ["ctrl-s"] = {
          function(selected)
            fzf_lua.live_grep({ cwd = selected[1] })
          end,
        },
        ["ctrl-r"] = {
          function(selected)
            fzf_lua.oldfiles({ cwd = selected[1] })
          end,
        },
        ["ctrl-w"] = {
          function(selected)
            -- cd(selected)
            local path = selected[1]
            local ok = project.set_pwd(path)
            if ok then
              vim.api.nvim_win_close(0, false)
              LazyVim.info("Change project dir to " .. path)
            end
          end,
        },
      },
    }

    fzf_lua.fzf_exec(results, opts)
  end
end

return M
