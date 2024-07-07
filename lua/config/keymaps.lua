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

-- Regex
map("n", "<leader>ra", "/[^\\x00-\\x7F]<cr>", { desc = "Find Non-ASCII Characters" })
map("n", "<leader>rb", "<cmd>s/ /\\r/g<cr>|<cmd>noh<cr>", { desc = "Break Line" })
map("n", "<leader>rc", "<cmd>:%s/[[:cntrl:]]//<cr>``", { desc = "Remove Control Symbols" })
map("n", "<leader>rp", "<cmd>:%s/[^[:print:]]//<cr>``", { desc = "Remove Non-Printable Characters" })
map("n", "<leader>rt", "<cmd>:%s/\\s\\+$//<cr>``", { desc = "Remove Trailing Whitespace" })
map("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace Word" })
