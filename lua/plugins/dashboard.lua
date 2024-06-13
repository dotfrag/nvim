local pick = function()
  if LazyVim.pick.picker.name == "telescope" then
    return vim.cmd("Telescope projects")
  elseif LazyVim.pick.picker.name == "fzf" then
    local fzf_lua = require("fzf-lua")
    local history = require("project_nvim.utils.history")
    local results = history.get_recent_projects()
    fzf_lua.fzf_exec(results, {
      actions = {
        ["default"] = {
          function(selected)
            fzf_lua.files({ cwd = selected[1] })
          end,
        },
      },
    })
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
    local logo_height = 6 + 3 -- logo size + newlines
    local actions_height = #opts.config.center * 2 - 1 -- minus 1 for last item
    local total_height = logo_height + actions_height + 2 -- plus for 2 for footer
    local margin = math.floor((win_height - total_height) / 2)
    logo = string.rep("\n", margin) .. logo .. "\n\n"
    opts.config.header = vim.split(logo, "\n")

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    return opts
  end,
}
