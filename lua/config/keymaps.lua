---@diagnostic disable: missing-fields

local map = vim.keymap.set
local del = vim.keymap.del

-- Unset LazyVim mappings
del("n", "<leader>dph")
del("n", "<leader>dpp")
del("n", "<leader>qq")

-- Quit
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit" })

-- Save file
-- https://github.com/LazyVim/LazyVim/discussions/4600#discussioncomment-10974159
map({ "i", "x", "n", "s" }, "<C-s>", "<esc><cmd>w<cr>", { desc = "Save File" })

-- Save without formatting
map("n", "<leader>W", "<cmd>noautocmd w<cr>", { desc = "Save Without Formatting" })

-- stylua: ignore start

-- Session
map("n", "<leader>S", function() require("persistence").select() end, { desc = "Select Session" })

-- Terminal
map("n", "<c-/>", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })

-- Lazygit
map("n", "<A-g>", function() Snacks.lazygit({ win = { width = 0, height = 0 }, cwd = LazyVim.root.git() }) end, { desc = "Lazygit (Root Dir)" })
map("n", "<leader>gg", function() Snacks.lazygit({ win = { width = 0, height = 0 }, cwd = LazyVim.root.git() }) end, { desc = "Lazygit (Root Dir)" })
map("n", "<leader>gG", function() Snacks.lazygit({ win = { width = 0, height = 0 } }) end, { desc = "Lazygit (cwd)" })

-- Buffers
map("n", "<leader>d", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
map("n", "<leader>D", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })
map("n", "<leader>ba", function() Snacks.bufdelete.all() end, { desc = "Delete All Buffers" })

-- stylua: ignore end

-- Navigate command-line history
map("c", "<C-j>", "<Down>", { desc = "Next Command" })
map("c", "<C-k>", "<Up>", { desc = "Previous Command" })

-- Center view in insert mode
map("i", "zz", "<C-o>zz")

-- Insert text in insert mode
map("i", "II", "<C-o>I")

-- Append text in insert mode
map("i", "AA", "<C-o>A")

-- Regex
map("n", "<leader>ra", "/[^\\x00-\\x7F]<cr>", { desc = "Find Non-ASCII Characters" })
map("n", "<leader>rb", "<cmd>s/ /\\r/g<cr>|<cmd>noh<cr>", { desc = "Break Line" })
map("n", "<leader>rc", "<cmd>%s/[[:cntrl:]]//<cr>``", { desc = "Remove Control Symbols" })
map("n", "<leader>re", "<cmd>g/^$/d<cr>", { desc = "Delete Empty Lines" })
-- map("n", "<leader>rE", "<cmd>%!cat -s<cr>", { desc = "Delete Multiple Empty Lines" })
map("n", "<leader>rE", [[:%s!\n\n\n\+!\r\r!g<cr>]], { desc = "Delete Multiple Empty Lines" })
map("n", "<leader>rp", "<cmd>%s/[^[:print:]]//<cr>``", { desc = "Remove Non-Printable Characters" })
map("n", "<leader>rt", "<cmd>%s/\\s\\+$//<cr>``", { desc = "Remove Trailing Whitespace" })
map("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace Word" })
-- stylua: ignore start
map("n", "<leader>rm", function() DotVim.modeline() end, { desc = "Append Modeline", noremap = true, silent = true })
map("n", "<leader>rM", function() DotVim.modeline(true) end, { desc = "Append Modeline (Long Format)", noremap = true, silent = true })
-- stylua: ignore end

-- Neovide copy/paste
-- https://github.com/neovide/neovide/issues/1282#issuecomment-1980984696
if vim.g.neovide then
  map("v", "<CS-c>", '"+y') -- Copy
  map("n", "<CS-v>", '"+P') -- Paste normal mode
  map("v", "<CS-v>", '"+P') -- Paste visual mode
  map("c", "<CS-v>", "<C-R>+") -- Paste command mode
  map("i", "<CS-v>", "<C-R>+") -- Paste insert mode
  map("t", "<CS-v>", '<C-\\><C-o>"+p') -- Paste terminal mode
end
