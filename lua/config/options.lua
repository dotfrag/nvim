local opt = vim.opt

-- Set window title
opt.title = true

-- Ignore whitespace in diff mode
opt.diffopt:append("iwhite")

-- Use ruff instead of ruff-lsp
vim.g.lazyvim_python_ruff = "ruff"
