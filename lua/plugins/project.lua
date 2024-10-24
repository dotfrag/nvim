return {
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    keys = {
      { "<leader>fp", DotVim.fzf.projects, desc = "Projects" },
    },
  },

  {
    "ibhagwan/fzf-lua",
    optional = true,
    keys = {
      { "<leader>fp", DotVim.fzf.projects, desc = "Projects" },
    },
  },

  {
    "nvimdev/dashboard-nvim",
    optional = true,
    opts = function(_, opts)
      local projects = { action = DotVim.fzf.projects, desc = "Projects", icon = "", key = "p" }
      table.insert(opts.config.center, 3, projects)
    end,
  },
}
