local function augroup(name)
  return vim.api.nvim_create_augroup("dotvim_" .. name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd

-- close some filetypes with <q>
-- https://github.com/LazyVim/LazyVim/blob/6202dd164466250b5c188918b34b3e8a3fec2604/lua/lazyvim/config/autocmds.lua#L53
autocmd("FileType", {
  group = "lazyvim_close_with_q",
  pattern = {
    "fugitiveblame",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true, desc = "Quit buffer" })
  end,
})

-- open dashboard when closing all buffers
-- https://github.com/LazyVim/LazyVim/discussions/3901#discussioncomment-10023866
autocmd("BufDelete", {
  group = augroup("bufdelpost_autocmd"),
  desc = "BufDeletePost User autocmd",
  callback = function()
    vim.schedule(function()
      vim.api.nvim_exec_autocmds("User", {
        pattern = "BufDeletePost",
      })
    end)
  end,
})
autocmd("User", {
  pattern = "BufDeletePost",
  group = augroup("dashboard_on_empty"),
  desc = "Open Dashboard when no available buffers",
  callback = function(ev)
    local deleted_name = vim.api.nvim_buf_get_name(ev.buf)
    local deleted_ft = vim.api.nvim_get_option_value("filetype", { buf = ev.buf })
    local deleted_bt = vim.api.nvim_get_option_value("buftype", { buf = ev.buf })
    local dashboard_on_empty = deleted_name == "" and deleted_ft == "" and deleted_bt == ""

    if dashboard_on_empty then
      vim.cmd("Dashboard")
    end
  end,
})

-- disable autoformat for yazi config files
autocmd("BufEnter", {
  group = augroup("disable_autoformat"),
  pattern = "*/yazi/*.toml",
  callback = function()
    vim.b.autoformat = false
  end,
})

-- -- organise imports for typescript files
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = augroup("organise_imports"),
--   pattern = "*.ts",
--   callback = function()
--     ---@diagnostic disable-next-line: assign-type-mismatch
--     vim.lsp.buf.code_action({ apply = true, context = { only = { "source.addMissingImports.ts" }, diagnostics = {} } })
--     ---@diagnostic disable-next-line: assign-type-mismatch
--     vim.lsp.buf.code_action({ apply = true, context = { only = { "source.removeUnused.ts" }, diagnostics = {} } })
--   end,
-- })
