local header
if vim.g.neovide then
  header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗██████╗ ███████╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║██╔══██╗██╔════╝
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██║  ██║█████╗  
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║  ██║██╔══╝  
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██████╔╝███████╗
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═════╝ ╚══════╝
      ]]
else
  header = [[
██████╗  ██████╗ ████████╗██╗   ██╗██╗███╗   ███╗
██╔══██╗██╔═══██╗╚══██╔══╝██║   ██║██║████╗ ████║
██║  ██║██║   ██║   ██║   ██║   ██║██║██╔████╔██║
██║  ██║██║   ██║   ██║   ╚██╗ ██╔╝██║██║╚██╔╝██║
██████╔╝╚██████╔╝   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
╚═════╝  ╚═════╝    ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]
end

return {
  {
    "folke/snacks.nvim",
    optional = true,
    opts = {
      dashboard = {
        width = 50,
        preset = {
          header = header,
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')", key = "f" },
            { icon = " ", desc = "New File", action = ":ene | startinsert", key = "n" },
            { icon = " ", desc = "Explorer", action = ":Neotree", key = "e" },
            { icon = " ", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')", key = "r" },
            { icon = " ", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')", key = "g" },
            { icon = " ", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", key = "c" },
            { icon = "󰦛 ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰁯 ", action = function() require("persistence").load({ last = true }) end, desc = "Restore Last Session", key = "S" },
            { icon = " ", desc = "Lazy Extras", action = ":LazyExtras", key = "x" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },

  {
    "nvimdev/dashboard-nvim",
    optional = true,
    opts = function()
      local function config()
        vim.cmd.cd(vim.fn.stdpath("config"))
        require("persistence").load()
      end

    -- stylua: ignore start
    local function restore_session() require("persistence").load() end
    local function restore_last_session() require("persistence").load({ last = true }) end
    local function quit() vim.api.nvim_input("<cmd>qa<cr>") end
      -- stylua: ignore end

      return {
        logo = header,
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
        -- stylua: ignore
        center = {
          { action = 'lua LazyVim.pick()()',              desc = "Find File",            icon = "", key = "f" },
          { action = "ene | startinsert",                 desc = "New File",             icon = "", key = "n" },
          { action = "Neotree",                           desc = "Explorer",             icon = "", key = "e" },
          { action = 'lua LazyVim.pick("oldfiles")()',    desc = "Recent Files",         icon = "", key = "r" },
          { action = 'lua LazyVim.pick("live_grep")()',   desc = "Find Text",            icon = "", key = "g" },
          { action = config,                              desc = "Config Session",       icon = "", key = "c" },
          { action = 'lua LazyVim.pick.config_files()()', desc = "Config Files",         icon = "", key = "C" },
          { action = restore_session,                     desc = "Restore Session",      icon = "󰁯", key = "s" },
          { action = restore_last_session,                desc = "Restore Last Session", icon = "󰦛", key = "S" },
          { action = "LazyExtras",                        desc = "Lazy Extras",          icon = "", key = "x" },
          { action = "Lazy",                              desc = "Lazy",                 icon = "󰒲", key = "l" },
          { action = quit,                                desc = "Quit",                 icon = "", key = "q" },
        },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }
    end,
    config = function(_, opts)
      local win_height = vim.api.nvim_win_get_height(0) + 2 -- plus 2 for status bar
      local _, logo_count = string.gsub(opts.logo, "\n", "") -- count newlines in logo
      local logo_height = logo_count + 2 -- logo size + newlines
      local actions_height = #opts.config.center * 2 - 1 -- minus 1 for last item
      local total_height = logo_height + actions_height + 2 -- plus for 2 for footer
      local margin = math.floor((win_height - total_height) / 2)
      local logo = string.rep("\n", margin) .. opts.logo .. "\n"
      opts.config.header = vim.split(logo, "\n")

      for _, button in ipairs(opts.config.center) do
        button.desc = "  " .. button.desc .. string.rep(" ", 40 - #button.desc)
        button.key_format = "%s"
      end

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

      require("dashboard").setup(opts)
    end,
  },
}
