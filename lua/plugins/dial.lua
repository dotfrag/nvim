return {
  "monaqa/dial.nvim",
  optional = true,
  opts = function(_, opts)
    table.remove(opts.groups.default, 2)
  end,
}
