local M = {
  'navarasu/onedark.nvim',
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1100, -- make sure to load this before all the other start plugins
}

M.name = "onedark"
function M.config()
  require('onedark').setup {
    style = 'deep',
    highlights = {
      Normal = {
        bg = "#10121A"
      },
      EndOfBuffer = {
        bg = "#10121A"
      },
      NormalFloat = {
        bg = "#10121A"
      },
      FloatBorder = {
        bg = "#10121A"
      },
      SignColumn = {
        bg = "#10121A"
      },
      CursorLine = {
        bg = "#080910"
      },
      VertSplit = {
        fg = "#080910"
      },
      LineNr = {
        fg = "#080910"
      },
    }
  }

  -- pcall(vim.cmd.colorscheme, "tokyonight-night")
  -- local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)
  -- if not status_ok then
  --   return
  -- end
end

return M
