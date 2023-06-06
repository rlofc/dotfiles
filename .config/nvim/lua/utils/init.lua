local M = {}

M.servers = {
  "lua_ls",
  "cssls",
  "html",
  "tsserver",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
  "clangd"
}

-- Reload all user config lua modules
M.reload_config = function()
  -- Handle impatient.nvim automatically.
  local luacache = (_G.__luacache or {}).cache

  for name, _ in pairs(package.loaded) do
    if name:match("^eden.") then
      package.loaded[name] = nil

      if luacache then
        luacache[name] = nil
      end
    end
  end

  dofile(vim.env.MYVIMRC)
end

return M
