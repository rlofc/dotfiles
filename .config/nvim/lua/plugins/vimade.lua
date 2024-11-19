local M = {
  "TaDaa/vimade",
  event = "VimEnter",
}

function M.config()
  vim.cmd [[
    let g:vimade.fadelevel = 0.3
    let g:vimade.enablesigns = 1
    let g:vimade.enabletreesitter = 1
  ]]
end

return M
