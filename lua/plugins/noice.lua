return {
  "folke/noice.nvim",
  opts = function(_, opts)
    vim.list_extend(opts.routes, {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "E486" }, -- Pattern not found
            { find = "E21" }, -- Cannot make changes, 'modifiable' is off
          },
        },
        view = "mini",
      },
    })
  end,
}
