local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
  return vim.api.nvim_create_augroup("dotvim_" .. name, { clear = true })
end

-- close some filetypes with <q>
-- https://github.com/LazyVim/LazyVim/blob/6202dd164466250b5c188918b34b3e8a3fec2604/lua/lazyvim/config/autocmds.lua#L53
autocmd("FileType", {
  group = "lazyvim_close_with_q",
  pattern = {
    "fugitiveblame",
    "git",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, { buffer = event.buf, silent = true, desc = "Quit buffer" })
    end)
  end,
})

-- custom formatters for json files
autocmd("FileType", {
  group = augroup("formatters_json"),
  pattern = { "json" },
  callback = function(event)
    vim.keymap.set("n", "<leader>cq", function()
      local filepath = vim.fn.expand("%:p")
      -- stylua: ignore
      vim.cmd("!jq 'to_entries|sort|from_entries' " .. filepath .. " > " .. filepath .. ".tmp && mv -vi -f " .. filepath .. ".tmp " .. filepath)
    end, { buffer = event.buf, desc = "Sort JSON Keys" })
  end,
})

-- disable autoformat for yazi config files
autocmd("BufEnter", {
  group = augroup("disable_autoformat"),
  pattern = {
    "*/waybar/config*",
    "*/yazi/*.toml",
  },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- -- open dashboard when closing all buffers
-- -- https://github.com/LazyVim/LazyVim/discussions/3901#discussioncomment-10023866
-- autocmd("BufDelete", {
--   group = augroup("bufdelpost_autocmd"),
--   desc = "BufDeletePost User autocmd",
--   callback = function()
--     vim.schedule(function()
--       vim.api.nvim_exec_autocmds("User", {
--         pattern = "BufDeletePost",
--       })
--     end)
--   end,
-- })
-- autocmd("User", {
--   pattern = "BufDeletePost",
--   group = augroup("dashboard_on_empty"),
--   desc = "Open Dashboard when no available buffers",
--   callback = function(ev)
--     local deleted_name = vim.api.nvim_buf_get_name(ev.buf)
--     local deleted_ft = vim.api.nvim_get_option_value("filetype", { buf = ev.buf })
--     local deleted_bt = vim.api.nvim_get_option_value("buftype", { buf = ev.buf })
--     local dashboard_on_empty = deleted_name == "" and deleted_ft == "" and deleted_bt == ""
--     if dashboard_on_empty then
--       vim.cmd("Dashboard")
--     end
--   end,
-- })

-- -- organise imports for typescript files
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = augroup("organise_imports"),
--   pattern = "typescript",
--   callback = function()
--     ---@diagnostic disable-next-line: assign-type-mismatch
--     vim.lsp.buf.code_action({ apply = true, context = { only = { "source.addMissingImports.ts" }, diagnostics = {} } })
--     ---@diagnostic disable-next-line: assign-type-mismatch
--     vim.lsp.buf.code_action({ apply = true, context = { only = { "source.removeUnused.ts" }, diagnostics = {} } })
--   end,
-- })

-- -- format options
-- -- https://github.com/dpetka2001/dotfiles/blob/main/dot_config/nvim/lua/config/autocmds.lua
-- autocmd("FileType", {
--   pattern = { "*" },
--   callback = function()
--     -- vim.opt.formatoptions = vim.opt.formatoptions - "o"
--     if vim.bo["ft"] == "css" then
--       vim.opt_local.formatoptions:remove("r") -- don't enter comment leader on Enter in css files
--     end
--     vim.opt.formatoptions = vim.opt.formatoptions + {
--       o = false, -- Don't continue comments with o and O
--     }
--   end,
--   group = "mygroup",
--   desc = "Don't continue comments with o and O",
-- })
