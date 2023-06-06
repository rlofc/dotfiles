local M = {
  'karb94/neoscroll.nvim',
  --  event = "VeryLazy",
}

function M.config()
  require('neoscroll').setup {
    mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
      '<C-y>', '<C-e>', 'zt', 'zz', 'zb', '<PageUp>', '<PageDown>' },
  }

  vim.cmd [[
    map <PageUp> <C-b>
    map <PageDown> <C-f>
  ]]
end

return M
