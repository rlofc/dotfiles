local M = {
  "stevearc/oil.nvim",
  event = "VeryLazy",
}

function M.config()
  require("oil").setup({
    view_options = {
      show_hidden = true,
    },
  })
end

return M
