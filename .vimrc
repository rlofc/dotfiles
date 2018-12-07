" -----------------------------------------------------------------------------
" BASIC STUFF
" ~~~~~~~~~~~
set nocompatible  " be iMproved
set hidden        " will allow unsaved background buffers and remember marks/undo
syntax on

" -----------------------------------------------------------------------------
" INDENTING
" ~~~~~~~~~
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set ai
set si

" -----------------------------------------------------------------------------
" SEARCHING
" ~~~~~~~~~
set hlsearch      " highlight search
set incsearch     " Incremental search, search as you type
set ignorecase    " Ignore case when searching 
set smartcase     " Ignore case when searching lowercase

" -----------------------------------------------------------------------------
" WRAPPING
" ~~~~~~~~
set nowrap
set linebreak  " Wrap at word

" -----------------------------------------------------------------------------
" INVISIBLES
" ~~~~~~~~~~
set listchars=trail:.,tab:>-,eol:$
set nolist

" -----------------------------------------------------------------------------
" HISTORY
" ~~~~~~~
set history=10000

" -----------------------------------------------------------------------------
" VUNDLE
" ~~~~~~
filetype off " required by vundle!
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"Bundle 'gmarik/vundle'
Plugin 'gmarik/Vundle.vim'
" -----------------------------------------------------------------------------
" STATUS LINE
" ~~~~~~~~~~~
Plugin 'bling/vim-airline'
set showcmd
set ruler " Show ruler
set laststatus=2
set encoding=utf-8
let g:airline_powerline_fonts = 1

" -----------------------------------------------------------------------------
" GUTTER 
" ~~~~~~
set number
set numberwidth=4
Plugin 'airblade/vim-gitgutter'

" -----------------------------------------------------------------------------
" CTRL-P
" ~~~~~~
Plugin 'kien/ctrlp.vim'
set wildignore+=*/tmp/*,*.so,*.a,*.swp,*.zip,*/etc/*,*/bin/*,*/dist/*,*/build/*
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\.git/'

" -----------------------------------------------------------------------------
" EASYMOTION
" ~~~~~~~~~~
Plugin 'Lokaltog/vim-easymotion'
let g:EasyMotion_leader_key = '<Space><Space>'

" -----------------------------------------------------------------------------
" ULTISNIPS
" ~~~~~~~~~

" -----------------------------------------------------------------------------
" VIM-COMMENTARY
" ~~~~~~~~~~~~~~
Plugin 'tpope/vim-commentary'

" -----------------------------------------------------------------------------
" GIT FUGITIVE
" ~~~~~~~~~~~~
Plugin 'tpope/vim-fugitive'
Plugin 'Raimondi/delimitMate'
" -----------------------------------------------------------------------------
" SUPERTAB
" ~~~~~~~~~~~~
"Plugin 'ervandew/supertab'

Plugin 'vim-scripts/ifdef-highlighting'

" -----------------------------------------------------------------------------
" VIM-CLANG-FORMAT - much easier than manual formatting
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plugin 'rhysd/vim-clang-format'
let g:clang_format#style_options = {
            \ "ColumnLimit":                80,
            \ "BreakBeforeBraces": "Linux",
            \ "AccessModifierOffset":                -4,
            \ "AllowShortIfStatementsOnASingleLine": "true",
            \ "AlwaysBreakTemplateDeclarations":     "true",
            \ "SpacesInParentheses":                 "false",
            \ "AllowShortFunctionsOnASingleLine":    "false",
            \ "AllowShortBlocksOnASingleLine":       "true",
            \ "IndentFunctionDeclarationAfterType":  "true",
            \ "Cpp11BracedListStyle":                "false",
            \ "ContinuationIndentWidth" : 4,
            \ "AlwaysBreakBeforeMultilineStrings":   "false",
            \ "AllowAllParametersOfDeclarationOnNextLine": "false",
            \ "ExperimentalAutoDetectBinPacking":    "true",
            \ "BinPackParameters":                   "true",
            \ "Standard":                            "C++11"}

autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

" -----------------------------------------------------------------------------
" VIM-EASY-ALIGN - very flexible text aligner
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plugin 'junegunn/vim-easy-align'
vmap <Enter> <Plug>(EasyAlign)

" -----------------------------------------------------------------------------
" VORG - to manage my to do lists and projects
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plugin 'rlofc/vorg'
Plugin 'terryma/vim-multiple-cursors'


" -----------------------------------------------------------------------------
" AVOID OLD BAD HABBITS
" ~~~~~~~~~~~~~~~~~~~~~
map <Left>  <Nop>
map <Right> <Nop>
map <Up>    <Nop>
map <Down>  <Nop>

" -----------------------------------------------------------------------------
" GROW NEW BAD HABBITS
" ~~~~~~~~~~~~~~~~~~~~
imap jj <Esc> " Professor VIM says '87% of users prefer jj over esc', jj abrams disagrees
imap <C-w> <ESC><C-w> " Allow window operations while in insert-mode


inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>
imap <C-Space> _
noremap <SPACE>gg G
noremap <SPACE><SPACE> b~e
noremap <SPACE>j }
noremap <SPACE>k {
noremap <c-j> }
noremap <c-k> {
noremap - A
imap ;; <C-o>A;
nnoremap ; :
noremap ;; A;
" -----------------------------------------------------------------------------
" UPDATE CTAGS 
" ~~~~~~~~~~~~
" au BufWritePost *.c,*.cpp,*.h silent! !ctags --c++-kinds=+p 
    " \ --fields=+iaS --extra=+q --language-force=C++ -R . &

" au BufWritePost *.c,*.cpp,*.h silent! !ctags 
"     \ --fields=+iaS --extra=+q --language-force=C -R . &
" -----------------------------------------------------------------------------
" Remember last cursor position in opened file
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

" -----------------------------------------------------------------------------
" COLOR THEME
" ~~~~~~~~~~~
colorscheme darker-dreams
set cursorline

Plugin 'octol/vim-cpp-enhanced-highlight'
" Plugin 'tpope/vim-surround'

Plugin 'guns/xterm-color-table.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-lua-ftplugin'
Plugin 'raymond-w-ko/vim-lua-indent'
Plugin 'justinmk/vim-syntax-extra'
Plugin 'rking/ag.vim'

Bundle 'ervandew/supertab'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tikhomirov/vim-glsl'
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt.git'
Plugin 'google/vim-glaive'
Plugin 'vim-syntastic/syntastic'
"Plugin 'vim-scripts/Pago'
Plugin 'zazaian/pago'
Plugin 'bazelbuild/vim-bazel'
" if you use Vundle, load plugins:
 
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

set iskeyword-=_
call vundle#end()            " required
filetype plugin indent on     " required after vundle bundles
runtime! ftplugin/man.vim

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
syntax on
inoremap <NUL> _
nnoremap <F3> :set hlsearch!<CR>
highlight ColorColumn ctermbg=232
let &colorcolumn=join(range(81,999),",")

syn match luaCustomFunction "\(\<function\>\)\@<=\s\+\S\+\s*(\@="
hi luaFunction ctermfg=229
hi luaCustomFunction ctermfg=yellow

set winwidth=85
" map <Tab> <C-W>w 
"
"au BufWritePost *.c silent !~/gen_output.sh <afile>
"au BufEnter *.c silent !~/gen_output_f.sh <afile>

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    set iskeyword-=_
    return 0
  else
    set iskeyword+=_
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=50
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction
filetype plugin indent on     " required after vundle bundles
let g:ycm_extra_conf_globlist = [ '/home/folder/' ]
let g:syntastic_check_on_open = 1
let g:syntastic_lua_checkers = ["luac", "luacheck"]
let g:syntastic_lua_luacheck_args = "--no-unused-args" 

hi SyntasticErrorSign ctermbg=88
