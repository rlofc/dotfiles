local M = {
  'stevearc/overseer.nvim',
  event = "VeryLazy",
}

function M.config()
  require('overseer').setup {
    task_win = {
      -- How much space to leave around the floating window
      padding = 2,
      height = 0.5,
      border = "rounded",
      -- Set any window options here (e.g. winhighlight)
      win_opts = {
        winblend = 20,
      },
    },
  }
end

return M
