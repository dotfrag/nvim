local map = vim.keymap.set
local del = vim.keymap.del

-- Quit
del("n", "<leader>qq")
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit" })

-- Buffers
map("n", "<leader>d", LazyVim.ui.bufremove, { desc = "Delete Buffer" })
map("n", "<leader>ba", function()
  vim.cmd("BufferLineCloseOthers")
  LazyVim.ui.bufremove()
end, { desc = "Delete All Buffers" })

-- Save without formatting
map("n", "<leader>W", "<cmd>noautocmd w<cr>", { desc = "Save Without Formatting" })

-- Navigate command-line history
map("c", "<C-j>", "<Down>", { desc = "Next Command" })
map("c", "<C-k>", "<Up>", { desc = "Previous Command" })

-- Regex
map("n", "<leader>ra", "/[^\\x00-\\x7F]<cr>", { desc = "Find Non-ASCII Characters" })
map("n", "<leader>rb", "<cmd>s/ /\\r/g<cr>|<cmd>noh<cr>", { desc = "Break Line" })
map("n", "<leader>rc", "<cmd>:%s/[[:cntrl:]]//<cr>``", { desc = "Remove Control Symbols" })
map("n", "<leader>rp", "<cmd>:%s/[^[:print:]]//<cr>``", { desc = "Remove Non-Printable Characters" })
map("n", "<leader>rt", "<cmd>:%s/\\s\\+$//<cr>``", { desc = "Remove Trailing Whitespace" })
map("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace Word" })

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
