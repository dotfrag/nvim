-- Thanks:
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
-- https://github.com/AstroNvim/astrocore/blob/main/lua/astrocore/mason.lua

local M = {}

M.debounce = true
M.debounce_hours = 1
M.debounce_file = vim.fn.stdpath("state") .. "/mason-update-debounce"
M.start_delay = 1

M.read_last_timestamp = function()
  local f = io.open(M.debounce_file)
  if f ~= nil then
    local last = f:read()
    f:close()
    return last
  end
  return nil
end

M.write_new_timestamp = function()
  local f = assert(io.open(M.debounce_file, "w+"))
  f:write(os.time())
  f:close()
end

M.can_run = function()
  local last = M.read_last_timestamp()
  if last == nil then
    M.write_new_timestamp()
    return true
  end
  if (os.time() - last) > M.debounce_hours * 3600 then
    M.write_new_timestamp()
    return true
  end
  return false
end

M.notify = function(m, level)
  level = level or "INFO"
  vim.notify(m, vim.log.levels[level])
end

M.update_packages = function()
  local ok, registry = pcall(require, "mason-registry")
  if not ok then
    vim.api.nvim_err_writeln("Unable to access mason registry")
    return
  end

  M.notify("Checking for package updates...")
  registry.update(vim.schedule_wrap(function(success, registries)
    if success then
      local installed_pkgs = registry.get_installed_packages()
      local running = #installed_pkgs
      local no_pkgs = running == 0

      if no_pkgs then
        M.notify("No updates available")
      else
        local updated = false
        for _, pkg in ipairs(installed_pkgs) do
          pkg:check_new_version(function(update_available, version)
            if update_available then
              updated = true
              M.notify(("Updating `%s` to %s"):format(pkg.name, version.latest_version))
              pkg:install():on("closed", function()
                running = running - 1
                if running == 0 then
                  M.notify("Update Complete")
                end
              end)
            else
              running = running - 1
              if running == 0 then
                if updated then
                  M.notify("Update Complete")
                else
                  M.notify("No updates available")
                end
              end
            end
          end)
        end
      end
    else
      M.notify(("Failed to update registries: %s"):format(registries), "ERROR")
    end
  end))
end

M.update = function()
  if M.debounce and not M.can_run() then
    return
  end

  -- LazyVim.on_load("mason.nvim", function()
  vim.defer_fn(M.update_packages, M.start_delay * 1000)
  -- end)
end

return M
