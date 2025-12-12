local M = {
  "catppuccin/nvim",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1101, -- make sure to load this before all the other start plugins
}

function M.config()
  require("catppuccin").setup({
    custom_highlights = function(_)
      return {
        Comment = { fg = "#414162" },
        LineNr = { fg = "#0e0e16" },
        CursorLine = { bg = "#101222" },
        Normal = { bg = "#1B1B29" },
      }
    end,
  })
end

return M
