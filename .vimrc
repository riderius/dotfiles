set number
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set hlsearch
set incsearch
set write

set encoding=utf-8
set fileencoding=utf-8
set nocp
set undofile

set background=dark
" set termguicolors

"set mouse=a "enable mouse

syntax on

call plug#begin('~/.vim/plugins')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'riderius/vim-plugin-ruscmd'
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

" turn off search highlight
nnoremap ,<space> :nohlsearch<CR>

"undotree
nnoremap <F5> :UndotreeToggle<CR>
