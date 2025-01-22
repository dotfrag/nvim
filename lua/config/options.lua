local opt = vim.opt

-- Set window title
opt.title = true

-- Ignore whitespace in diff mode
opt.diffopt:append("iwhite")

-- Lines of context
opt.scrolloff = 8

-- -- Clipboard
-- if vim.env.SSH_TTY then
--   opt.clipboard:append("unnamedplus")
--   local function paste()
--     return vim.split(vim.fn.getreg(""), "\n")
--   end
--   vim.g.clipboard = {
--     name = "OSC 52",
--     copy = {
--       ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
--       ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
--     },
--     paste = {
--       ["+"] = paste,
--       ["*"] = paste,
--     },
--   }
-- end

-- Neovide options
if vim.g.neovide then
  vim.g.neovide_hide_mouse_when_typing = true
end
