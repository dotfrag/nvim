---@class dotvim.util
---@field mason dotvim.util.mason
local M = {}

setmetatable(M, {
  __index = function(t, k)
    t[k] = require("dotvim.util." .. k)
    return t[k]
  end,
})

return M
