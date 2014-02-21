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
set history=100000

" -----------------------------------------------------------------------------
" VUNDLE
" ~~~~~~
filetype off " required by vundle!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" -----------------------------------------------------------------------------
" STATUS LINE
" ~~~~~~~~~~~
Bundle 'bling/vim-airline'
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
Bundle 'airblade/vim-gitgutter'

" -----------------------------------------------------------------------------
" CTRL-P
" ~~~~~~
Bundle 'kien/ctrlp.vim'
set wildignore+=*/tmp/*,*.so,*.a,*.swp,*.zip,*/etc/*,*/bin/*,*/dist/*,*/build/*
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\.git/'

" -----------------------------------------------------------------------------
" EASYMOTION
" ~~~~~~~~~~
Bundle 'Lokaltog/vim-easymotion'
let g:EasyMotion_leader_key = '<Space><Space>'

" -----------------------------------------------------------------------------
" ULTISNIPS
" ~~~~~~~~~
Bundle 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" -----------------------------------------------------------------------------
" VIM-COMMENTARY
" ~~~~~~~~~~~~~~
Bundle 'tpope/vim-commentary'

" -----------------------------------------------------------------------------
" GIT FUGITIVE
" ~~~~~~~~~~~~
Bundle 'tpope/vim-fugitive'

" -----------------------------------------------------------------------------
" SUPERTAB
" ~~~~~~~~~~~~
Bundle 'ervandew/supertab'
Bundle 'derekwyatt/vim-protodef'

" -----------------------------------------------------------------------------
" STD_C
" ~~~~~
Bundle 'vim-scripts/std_c.zip'
let c_C11            = 1
let c_warn_8bitchars = 1
let c_warn_multichar = 1
let c_warn_digraph   = 1
let c_warn_trigraph  = 1
let c_no_octal       = 1

" -----------------------------------------------------------------------------
" VIM-FSWITCH - companion file switcher
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Bundle 'derekwyatt/vim-fswitch'

" -----------------------------------------------------------------------------
" CLANG_COMPLETE
" ~~~~~~~~~~~~~~
Bundle 'Rip-Rip/clang_complete'
let g:clang_snippets        = 1
let g:clang_snippets_engine = 'ultisnips'
let g:clang_close_preview   = 1
let g:clang_auto_select     = 1
set completeopt=menu,menuone

filetype plugin indent on     " required after vundle bundles

" -----------------------------------------------------------------------------
" VIM-CLANG-FORMAT - much easier than manual formatting
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Bundle 'rhysd/vim-clang-format'
let g:clang_format#style_options = {
            \ "AccessModifierOffset":                -4,
            \ "AllowShortIfStatementsOnASingleLine": "true",
            \ "AlwaysBreakTemplateDeclarations":     "true",
            \ "SpacesInParentheses":                 "true",
            \ "IndentFunctionDeclarationAfterType":  "true",
            \ "Standard":                            "C++11"}

autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

" -----------------------------------------------------------------------------
" VIM-EASY-ALIGN - very flexible text aligner
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Bundle 'junegunn/vim-easy-align'

" -----------------------------------------------------------------------------
" VIM-MARKDOWN - when I use vim for plain text editing
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Bundle 'plasticboy/vim-markdown'
autocmd BufNewFile,BufRead *.md,*.markdown,*.txt 
            \set foldcolumn=2 
            \| highlight! link FoldColumn Normal 
            \| set textwidth=60 
            \| set nonumber 
            \| set spell

" -----------------------------------------------------------------------------
" VORG - to manage my to do lists and projects
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Bundle 'rlofc/vorg'

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
imap ` _
imap `` ()<left>
imap ``` ();<left><left>
noremap <SPACE>gg G
noremap <SPACE><SPACE> b~e
noremap <SPACE>j }
noremap <SPACE>k {
noremap <c-j> }
noremap <c-k> {
noremap - A
imap ;; <C-o>A;<CR>
nnoremap ; :

" -----------------------------------------------------------------------------
" UPDATE CTAGS 
" ~~~~~~~~~~~~
au BufWritePost *.c,*.cpp,*.h silent! !ctags --c++-kinds=+p 
    \ --fields=+iaS --extra=+q --language-force=C++ -R . &

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
colorscheme dark-dreams
set cursorline

map <SPACE>q ;%s/virtual//g \| %s/;/\r{\r}\r/g \|  g/^[a-z]*[ ]/s/[ ]/ ClassName::/
