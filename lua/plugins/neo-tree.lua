return {
  -- https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/plugins/neo-tree.lua
  -- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Tips#navigation-with-hjkl
  "nvim-neo-tree/neo-tree.nvim",
  init = function() end,
  opts = {
    commands = {
      parent_or_close = function(state)
        local node = state.tree:get_node()
        if node:has_children() and node:is_expanded() then
          state.commands.toggle_node(state)
        else
          require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
        end
      end,
      expand_or_open = function(state)
        local node = state.tree:get_node()
        if node:has_children() then
          if not node:is_expanded() then
            state.commands.toggle_node(state)
          else
            require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
          end
        else
          state.commands.open(state)
        end
      end,
      copy_selector = function(state)
        local node = state.tree:get_node()
        local filepath = node:get_id()
        local filename = node.name
        local modify = vim.fn.fnamemodify

        local vals = {
          ["BASENAME"] = modify(filename, ":r"),
          ["EXTENSION"] = modify(filename, ":e"),
          ["FILENAME"] = filename,
          ["PATH (CWD)"] = modify(filepath, ":."),
          ["PATH (HOME)"] = modify(filepath, ":~"),
          ["PATH"] = filepath,
          ["URI"] = vim.uri_from_fname(filepath),
        }

        local options = vim.tbl_filter(function(val)
          return vals[val] ~= ""
        end, vim.tbl_keys(vals))
        if vim.tbl_isempty(options) then
          LazyVim.warn("No values to copy")
          return
        end
        table.sort(options)
        vim.ui.select(options, {
          prompt = "Choose to copy to clipboard:",
          format_item = function(item)
            return ("%s: %s"):format(item, vals[item])
          end,
        }, function(choice)
          local result = vals[choice]
          if result then
            LazyVim.info("Copied: `%s`")
            vim.fn.setreg("+", result)
          end
        end)
      end,
    },
    window = {
      mappings = {
        L = "focus_preview",
        Y = "copy_selector",
        -- h = "parent_or_close",
        -- l = "expand_or_open",
      },
    },
  },
}
