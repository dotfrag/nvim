---@class dotvim.util
---@field fzf dotvim.util.fzf
---@field mason dotvim.util.mason
local M = {}

setmetatable(M, {
  __index = function(t, k)
    t[k] = require("dotvim.util." .. k)
    return t[k]
  end,
})

---@param long_format? boolean
function M.modeline(long_format)
  local tabstop = vim.bo.tabstop
  local shiftwidth = vim.bo.shiftwidth
  local textwidth = vim.bo.textwidth
  local expandtab = vim.bo.expandtab and "" or "no"

  local modeline
  if long_format then
    modeline = string.format("vim: set ts=%d sw=%d tw=%d %set :", tabstop, shiftwidth, textwidth, expandtab)
  else
    modeline = string.format("vim: ts=%d sw=%d tw=%d %set", tabstop, shiftwidth, textwidth, expandtab)
  end

  local commentstring = require("ts-comments.comments").get(vim.bo.filetype) or vim.bo.commentstring
  modeline = commentstring:gsub("%%s", modeline)

  vim.api.nvim_buf_set_lines(0, -1, -1, false, { "", modeline })
  vim.api.nvim_feedkeys("Gzz", "n", false)
end

return M
