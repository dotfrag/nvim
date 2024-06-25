return {
  {
    "supermaven-inc/supermaven-nvim",
    event = "LazyFile",
    build = ":SupermavenUseFree",
    opts = {},
  },

  -- {
  --   "nvim-cmp",
  --   dependencies = {
  --     "supermaven-inc/supermaven-nvim",
  --     build = ":SupermavenUseFree",
  --     opts = {
  --       disable_inline_completion = true,
  --     },
  --   },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     table.insert(opts.sources, 1, {
  --       name = "supermaven",
  --       group_index = 1,
  --       priority = 100,
  --     })
  --   end,
  -- },

  {
    "folke/noice.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.routes, {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "Starting Supermaven" },
              { find = "Supermaven Free Tier" },
            },
          },
          skip = true,
        },
      })
    end,
  },
}
