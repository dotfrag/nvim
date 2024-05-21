return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2", "-ci" },
      },
    },
  },
}
