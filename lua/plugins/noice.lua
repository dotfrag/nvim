return {
  "folke/noice.nvim",
  opts = function(_, opts)
    opts.presets.lsp_doc_border = true
    vim.list_extend(opts.routes, {
      -- mini
      {
        filter = {
          any = {
            {
              event = "msg_show",
              any = {
                { find = "E486" }, -- Pattern not found
                { find = "E21" }, -- Cannot make changes, 'modifiable' is off
              },
            },
            {
              event = "notify",
              find = "Toggling hidden files:", -- Neo-tree hidden files
            },
          },
        },
        view = "mini",
      },

      -- skip
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "window%-picker" }, -- Neo-tree window picker warning
            { find = "^/" }, -- Search pattern -- FIXME: :pwd
          },
        },
        opts = { skip = true },
      },
    })
  end,
}
