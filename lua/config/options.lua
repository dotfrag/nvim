local opt = vim.opt

-- Set window title
opt.title = true

-- Ignore whitespace in diff mode
opt.diffopt:append("iwhite")

-- Lines of context
opt.scrolloff = 8
