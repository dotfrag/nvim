local map = vim.keymap.set
local del = vim.keymap.del

-- Quit
del("n", "<leader>qq")
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit" })

-- Session
map("n", "<leader>S", function()
  require("persistence").select()
end, { desc = "Select Session" })

-- Lazygit
-- stylua: ignore start
map("n", "<A-g>", function() LazyVim.lazygit({ size = { width = 1, height = 1 }, cwd = LazyVim.root.git() }) end, { desc = "Lazygit (Root Dir)" })
map("n", "<leader>gg", function() LazyVim.lazygit({ size = { width = 1, height = 1 }, cwd = LazyVim.root.git() }) end, { desc = "Lazygit (Root Dir)" })
map("n", "<leader>gG", function() LazyVim.lazygit({ size = { width = 1, height = 1 } }) end, { desc = "Lazygit (cwd)" })
-- stylua: ignore end

-- Buffers
map("n", "<leader>d", LazyVim.ui.bufremove, { desc = "Delete Buffer" })
map("n", "<leader>D", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })
map("n", "<leader>ba", function()
  vim.cmd("BufferLineCloseOthers")
  LazyVim.ui.bufremove()
end, { desc = "Delete All Buffers" })

-- Save without formatting
map("n", "<leader>W", "<cmd>noautocmd w<cr>", { desc = "Save Without Formatting" })

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
map("n", "<leader>rm", function()
  local tabstop = vim.bo.tabstop
  local shiftwidth = vim.bo.shiftwidth
  local textwidth = vim.bo.textwidth
  local expandtab = vim.bo.expandtab and "" or "no"
  local modeline = string.format("vim: set ts=%d sw=%d tw=%d %set :", tabstop, shiftwidth, textwidth, expandtab)
  local commentstring = vim.bo.commentstring
  modeline = commentstring:gsub("%%s", modeline)
  vim.api.nvim_buf_set_lines(0, -1, -1, false, { modeline })
  vim.api.nvim_feedkeys("Gzz", "n", false)
end, { desc = "Append Modeline", noremap = true, silent = true })

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
