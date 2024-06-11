return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Oil",
  init = function()
    if vim.fn.argc(-1) == 1 then
      ---@diagnostic disable-next-line: param-type-mismatch
      local stat = vim.uv.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("oil")
      end
    end
  end,
  opts = {},
}
