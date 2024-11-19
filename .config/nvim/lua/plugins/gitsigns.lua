local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
}

-- 'signs.add.hl' is now deprecated, please define highlight 'GitSignsAdd'
-- 'signs.add.linehl' is now deprecated, please define highlight 'GitSignsAddLn'
-- 'signs.add.numhl' is now deprecated, please define highlight 'GitSignsAddNr'
-- 'signs.change.hl' is now deprecated, please define highlight 'GitSignsChange'
-- 'signs.change.linehl' is now deprecated, please define highlight 'GitSignsChangeLn'
-- 'signs.change.numhl' is now deprecated, please define highlight 'GitSignsChangeNr'
-- 'signs.changedelete.hl' is now deprecated, please define highlight 'GitSignsChangedelete'
-- 'signs.changedelete.linehl' is now deprecated, please define highlight 'GitSignsChangedeleteLn'
-- 'signs.changedelete.numhl' is now deprecated, please define highlight 'GitSignsChangedeleteNr'
-- 'signs.delete.hl' is now deprecated, please define highlight 'GitSignsDelete'
-- 'signs.delete.linehl' is now deprecated, please define highlight 'GitSignsDeleteLn'
-- 'signs.delete.numhl' is now deprecated, please define highlight 'GitSignsDeleteNr'
-- 'signs.topdelete.hl' is now deprecated, please define highlight 'GitSignsTopdelete'
-- 'signs.topdelete.linehl' is now deprecated, please define highlight 'GitSignsTopdeleteLn'
-- 'signs.topdelete.numhl' is now deprecated, please define highlight 'GitSignsTopdeleteNr'

--    add = { hl = "GitSignsAdd", text = "▌", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
--    change = { hl = "GitSignsChange", text = "┃", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
--    delete = { hl = "GitSignsDelete", text = "▨", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
--    topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
--    changedelete = { hl = "GitSignsChange", text = "┃", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },

M.opts = {
  signs = {
    add = { text = "▌" },
    change = { text = "┃" },
    delete = { text = "▨" },
    topdelete = { text = "契" },
    changedelete = { text = "┃" },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
  },
  -- sign_priority = 6,
  update_debounce = 1000,
  status_formatter = nil, -- Use default
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
}

return M