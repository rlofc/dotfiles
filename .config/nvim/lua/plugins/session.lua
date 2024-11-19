local M = {
  'rmagatti/auto-session',
  event = "VimEnter",
}

function M.config()
  require('auto-session').setup {
    post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
      require("lualine").refresh()     -- refresh lualine so the new session name is displayed in the status bar
    end,
  }
end

return M
