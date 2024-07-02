local pick = function()
  if LazyVim.pick.picker.name == "telescope" then
    return vim.cmd("Telescope projects")
  elseif LazyVim.pick.picker.name == "fzf" then
    local fzf_lua = require("fzf-lua")
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

return {
  "nvimdev/dashboard-nvim",
  opts = function()
    local logo = [[
██████╗  ██████╗ ████████╗██╗   ██╗██╗███╗   ███╗
██╔══██╗██╔═══██╗╚══██╔══╝██║   ██║██║████╗ ████║
██║  ██║██║   ██║   ██║   ██║   ██║██║██╔████╔██║
██║  ██║██║   ██║   ██║   ╚██╗ ██╔╝██║██║╚██╔╝██║
██████╔╝╚██████╔╝   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
╚═════╝  ╚═════╝    ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]

    local function config()
      vim.cmd.cd(vim.fn.stdpath("config"))
      require("persistence").load()
    end

    local function config_files()
      vim.cmd.cd(vim.fn.stdpath("config"))
      LazyVim.pick.config_files()
    end

    -- stylua: ignore start
    local function restore_session() require("persistence").load() end
    local function restore_last_session() require("persistence").load({ last = true }) end
    local function quit() vim.api.nvim_input("<cmd>qa<cr>") end
    -- stylua: ignore end

    local opts = {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        -- stylua: ignore
        center = {
          { action = LazyVim.pick(),            desc = "Find File",            icon = "", key = "f" },
          { action = "ene | startinsert",       desc = "New File",             icon = "", key = "n" },
          { action = "Neotree",                 desc = "Explorer",             icon = "", key = "e" },
          { action = pick,                      desc = "Projects",             icon = "", key = "p" },
          { action = LazyVim.pick("oldfiles"),  desc = "Recent Files",         icon = "", key = "r" },
          { action = LazyVim.pick("live_grep"), desc = "Find Text",            icon = "", key = "g" },
          { action = config,                    desc = "Config Session",       icon = "", key = "c" },
          { action = config_files,              desc = "Config Files",         icon = "", key = "C" },
          { action = restore_session,           desc = "Restore Session",      icon = "󰁯", key = "s" },
          { action = restore_last_session,      desc = "Restore Last Session", icon = "󰦛", key = "S" },
          { action = "LazyExtras",              desc = "Lazy Extras",          icon = "", key = "x" },
          { action = "Lazy",                    desc = "Lazy",                 icon = "󰒲", key = "l" },
          { action = quit,                      desc = "Quit",                 icon = "", key = "q" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = "  " .. button.desc .. string.rep(" ", 40 - #button.desc)
      button.key_format = "%s"
    end

    local win_height = vim.api.nvim_win_get_height(0) + 2 -- plus 2 for status bar
    local _, logo_count = string.gsub(logo, "\n", "") -- count newlines in logo
    local logo_height = logo_count + 2 -- logo size + newlines
    local actions_height = #opts.config.center * 2 - 1 -- minus 1 for last item
    local total_height = logo_height + actions_height + 2 -- plus for 2 for footer
    local margin = math.floor((win_height - total_height) / 2)
    logo = string.rep("\n", margin) .. logo .. "\n"
    opts.config.header = vim.split(logo, "\n")

    -- open dashboard after closing lazy
    if vim.o.filetype == "lazy" then
      vim.api.nvim_create_autocmd("WinClosed", {
        pattern = tostring(vim.api.nvim_get_current_win()),
        once = true,
        callback = function()
          vim.schedule(function()
            vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
          end)
        end,
      })
    end

    return opts
  end,
}
