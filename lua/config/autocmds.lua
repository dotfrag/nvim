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
