local function augroup(name)
  return vim.api.nvim_create_augroup("dotvim_" .. name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd

-- disable autoformat for yazi config files
autocmd("BufEnter", {
  group = augroup("disable_autoformat"),
  pattern = "*/yazi/*.toml",
  callback = function()
    vim.b.autoformat = false
  end,
})

-- close some filetypes with <q>
-- https://github.com/LazyVim/LazyVim/blob/6202dd164466250b5c188918b34b3e8a3fec2604/lua/lazyvim/config/autocmds.lua#L53
autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "fugitiveblame",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- open dashboard when closing all buffers
-- https://github.com/LazyVim/LazyVim/discussions/3901#discussioncomment-9976798
vim.api.nvim_create_autocmd("BufDelete", {
  group = augroup("dashboard_on_empty"),
  callback = function(args)
    local deleted_name = vim.api.nvim_buf_get_name(args.buf)
    local deleted_ft = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
    local dashboard_on_empty = (deleted_name == "" and deleted_ft == "")
      or (vim.api.nvim_buf_get_name(0) == "" and vim.api.nvim_get_option_value("filetype", { buf = 0 }) == "")
    if dashboard_on_empty then
      vim.cmd("Dashboard")
    end
  end,
})
