set number
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set hlsearch
set incsearch
set write
set undofile

set encoding=utf-8
set fileencoding=utf-8
set nocp

set background=dark
set termguicolors

"set mouse=a "enable mouse

syntax on

call plug#begin('~/.vim/plugins')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'jiangmiao/auto-pairs'
Plug 'mbbill/undotree'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'

let g:airline_powerline_fonts = 1
let g:Powerline_symbols='unicode'

Plug 'scrooloose/syntastic'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_pylint_post_args =
        \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol} {msg_id}] {msg}"'
let g:syntastic_cpp_compiler_options = "-pedantic -Wall -Wextra -Wcast-align -Wcast-qual -Wctor-dtor-privacy -Wdisabled-optimization -Wformat=2 -Winit-self -Wlogical-op -Wmissing-declarations -Wmissing-include-dirs -Wnoexcept -Wold-style-cast -Woverloaded-virtual -Wredundant-decls -Wshadow -Wsign-conversion -Wsign-promo -Wstrict-null-sentinel -Wstrict-overflow=5 -Wswitch-default -Wundef -Wno-unused"

call plug#end()

map  <C-n> :NERDTreeToggle<CR>

map <C-d> :lclose<CR>
map <C-e> :Errors<CR>

nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

imap jk <Esc>

set colorcolumn=79

"for fix bug about cursor in nvim
set guicursor=

" turn off search highlight
nnoremap ,<space> :nohlsearch<CR>

"colors themes
let g:colors_name=""
"let g:colors_name="borland"

"undotree
nnoremap <F5> :UndotreeToggle<CR>

" Next lines for color theme as borland
" Vim color file
" Maintainer:   Yegappan Lakshmanan
" Last Change:  2001 Sep 9

" Color settings similar to that used in Borland IDE's.

if g:colors_name=="borland"
    set background=dark
    hi clear
    if exists("syntax_on")
        syntax reset
    endif

    hi Normal       term=NONE cterm=NONE ctermfg=Yellow ctermbg=DarkBlue
    hi Normal       gui=NONE guifg=Yellow guibg=DarkBlue
    hi NonText      term=NONE cterm=NONE ctermfg=White ctermbg=DarkBlue
    hi NonText      gui=NONE guifg=White guibg=DarkBlue

    hi Statement    term=NONE cterm=NONE ctermfg=White  ctermbg=DarkBlue
    hi Statement    gui=NONE guifg=White guibg=DarkBlue
    hi Special      term=NONE cterm=NONE ctermfg=Cyan ctermbg=DarkBlue
    hi Special      gui=NONE guifg=Cyan guibg=DarkBlue
    hi Constant     term=NONE cterm=NONE ctermfg=Magenta ctermbg=DarkBlue
    hi Constant     gui=NONE guifg=Magenta guibg=DarkBlue
    hi Comment      term=NONE cterm=NONE ctermfg=Gray ctermbg=DarkBlue
    hi Comment      gui=NONE guifg=Gray guibg=DarkBlue
    hi Preproc      term=NONE cterm=NONE ctermfg=Green ctermbg=DarkBlue
    hi Preproc      gui=NONE guifg=Green guibg=DarkBlue
    hi Type         term=NONE cterm=NONE ctermfg=White ctermbg=DarkBlue
    hi Type         gui=NONE guifg=White guibg=DarkBlue
    hi Identifier   term=NONE cterm=NONE ctermfg=White ctermbg=DarkBlue
    hi Identifier   gui=NONE guifg=White guibg=DarkBlue

    hi StatusLine   term=bold cterm=bold ctermfg=Black ctermbg=White
    hi StatusLine   gui=bold guifg=Black guibg=White

    hi StatusLineNC term=NONE cterm=NONE ctermfg=Black ctermbg=White
    hi StatusLineNC gui=NONE guifg=Black guibg=White

    hi Visual       term=NONE cterm=NONE ctermfg=Black ctermbg=DarkCyan
    hi Visual       gui=NONE guifg=Black guibg=DarkCyan

    hi Search       term=NONE cterm=NONE ctermbg=Gray
    hi Search       gui=NONE guibg=Gray

    hi VertSplit    term=NONE cterm=NONE ctermfg=Black ctermbg=White
    hi VertSplit    gui=NONE guifg=Black guibg=White

    hi Directory    term=NONE cterm=NONE ctermfg=Green ctermbg=DarkBlue
    hi Directory    gui=NONE guifg=Green guibg=DarkBlue

    hi WarningMsg   term=standout cterm=NONE ctermfg=Red ctermbg=DarkBlue
    hi WarningMsg   gui=standout guifg=Red guibg=DarkBlue

    hi Error        term=NONE cterm=NONE ctermfg=White ctermbg=Red
    hi Error        gui=NONE guifg=White guibg=Red

    hi Cursor       ctermfg=Black ctermbg=Yellow
    hi Cursor       guifg=Black guibg=Yellow
endif
