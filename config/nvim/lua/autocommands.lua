vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "vimwiki" },
  callback = function()
    require('cmp').setup.buffer { enabled = false }
    vim.cmd [[
      set foldlevel=3
      autocmd InsertCharPre * if search('\v(%^|[.!?]\_s)\_s*%#', 'bcnw') != 0 | let v:char = toupper(v:char) | endif
    ]]
  end,
})

-- Automatically close tab/vim when nvim-tree is the last window in the tab
-- vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    require('gitsigns').refresh()
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.java" },
  callback = function()
    vim.lsp.codelens.refresh()
  end,

})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd "hi link illuminatedWord LspReferenceText"
    vim.cmd [[
      sign define DiagnosticSignError text=  texthl=DiagnosticSignError linehl= numhl=
      sign define DiagnosticSignWarn text=  texthl=DiagnosticSignWarn linehl= numhl=
      sign define DiagnosticSignInfo text=  texthl=DiagnosticSignInfo linehl= numhl=
      sign define DiagnosticSignHint text=  texthl= linehl=DiagnosticSignHint numhl=
    ]]
    vim.cmd [[
      let wiki_1 = {}
      let wiki_1.path = '~/vimwiki/'
      let wiki_1.path_html = '~/vimwiki_html/'
      let wiki_2 = {}
      let wiki_2.path = '~/private/'
      let wiki_2.path_html = '~/private_html/'
      let wiki_2.syntax = 'markdown'
      let wiki_2.ext = 'md'
      let wiki_3 = {}
      "let wiki_3.syntax = 'markdown'
      "let wiki_3.ext = '.md'
      let wiki_3.path = '~/vmsite/'
      let wiki_3.path_html = '~/vmsite_html/'
      let g:vimwiki_list = [wiki_1, wiki_2, wiki_3]
      let g:vimwiki_folding = 'expr'
      let g:vimwiki_autowriteall=1
      let g:vimwiki_auto_header=1
      nnoremap <leader><Tab> za
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    local line_count = vim.api.nvim_buf_line_count(0)
    if line_count >= 5000 then
      vim.cmd "IlluminatePauseBuf"
    end
  end,
})
