"This is free and unencumbered software released into the public domain.
"
"Anyone is free to copy, modify, publish, use, compile, sell, or
"distribute this software, either in source code form or as a compiled
"binary, for any purpose, commercial or non-commercial, and by any
"means.

"In jurisdictions that recognize copyright laws, the author or authors
"of this software dedicate any and all copyright interest in the
"software to the public domain. We make this dedication for the benefit
"of the public at large and to the detriment of our heirs and
"successors. We intend this dedication to be an overt act of
"relinquishment in perpetuity of all present and future rights to this
"software under copyright law.

"THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
"EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
"OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
"ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
"OTHER DEALINGS IN THE SOFTWARE.
"
"For more information, please refer to <https://unlicense.org>
"

set number
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set hlsearch
set incsearch
set write
set nocompatible

set encoding=utf-8
set fileencoding=utf-8
set nocp
set undofile

set background=dark
set termguicolors
set t_Co=256
set t_AB=^[[48;5;%dm
set t_AF=^[[38;5;%dm
set cursorline
set mouse=

syntax on

" Russian spell check
map <F2> :syntax spell toplevel<CR>:syntax on<CR>:setlocal spell spelllang=ru_yo,en_us<CR>
map <F3> :set nospell<CR>

call plug#begin('~/.config/nvim/plugins')

" functional plugins
Plug 'https://git.sr.ht/~sircmpwn/hare.vim'
Plug 'mhinz/vim-signify'
set updatetime=100
autocmd VimEnter * :SignifyDisable " Startup disable vim-signify
nnoremap <F7> :SignifyToggle<CR>
Plug 'jghauser/mkdir.nvim'
Plug 'sudormrfbin/cheatsheet.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Graphic plugins
Plug 'vim-airline/vim-airline'
Plug 'bfrg/vim-cpp-modern'
Plug 'dikiaap/minimalist'
Plug 'riderius/vim-plugin-ruscmd'
Plug 'yggdroot/indentline'
Plug 'tpope/vim-commentary'
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
Plug 'ntpeters/vim-better-whitespace'
Plug 'sotte/presenting.vim'
Plug 'jamessan/vim-gnupg'
let g:GPGDefaultRecipients = ["9D671DC2087EBDFFA9DF07B898A6AC90A406F6E5"]

" lsp plugins
Plug 'neovim/nvim-lspconfig' " Collection of configurations for built-in LSP client
Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip' " Snippets plugin
Plug 'windwp/nvim-autopairs' "Autopair plugin
Plug 'lervag/vimtex' " Latex

" formats plugins
Plug 'RIDERIUS/vim-cpplint'
autocmd FileType cpp nmap <buffer> <C-e> :call Cpplint()<CR>
Plug 'preservim/tagbar'
nmap <F6> :TagbarToggle<CR>

" Competitive programming
Plug 'https://git.sr.ht/~p00f/cphelper.nvim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'https://git.sr.ht/~willdurand/srht.vim'
call plug#end()

nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

set colorcolumn=80

"colors themes
colorscheme minimalist
let g:airline_theme='minimalist'
let g:airline_powerline_fonts = 1
let g:airline_highlighting_cache = 1 " :AirlineRefresh will however clear the cache

" highlight for nasm
autocmd BufNew,BufRead *.asm set ft=nasm

" Startup disable vim-signify
autocmd VimEnter * :SignifyDisable

" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1
" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1
let g:indentLine_char_list = ['|']
map <F4> :Autoformat<CR>
let g:formatters_python = ['autopep8']
let g:formatters_cpp = ['clangformat']
let g:formatdef_my_clangformat = '"-style=Google"'
let g:cpplint_cmd_options = '"--counting=detailed"'

" Texlab
let g:tex_flavor='pdflatex'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_syntax_conceal_disable = 1

" For gdb in nvim
packadd termdebug
let g:termdebug_wide=1
tnoremap <Esc> <C-\><C-n>

" Competitive programming
let g:cph#dir = '/home/riderius/src/competitive'
let g:cph#cpp#compile_command = 'g++ -g solution.cpp -o cpp.out'
let g:cph#c#compile_command = 'gcc -g solution.c -o c.out'

lua << EOF
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'pylsp', 'texlab', 'cmake', 'rust_analyzer' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

require'lspconfig'.clangd.setup{
    cmd = {"clangd", "--completion-style=detailed"},
}

require'lspconfig'.rust_analyzer.setup{
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = true;
      }
    }
  }
}

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- nvim-autopairs setup
require('nvim-autopairs').setup{}
local disable_filetype = { "TelescopePrompt" }
local disable_in_macro = false  -- disable when recording or executing a macro
local disable_in_visualblock = false -- disable when insert after visual block mode
local ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", "")
local enable_moveright = true
local enable_afterquote = true  -- add bracket pairs after quote
local enable_check_bracket_line = true  --- check bracket in same line
local enable_bracket_in_quote = true --
local check_ts = false
local map_cr = true
local map_bs = true  -- map the <BS> key
local map_c_h = false  -- Map the <C-h> key to delete a pair
local map_c_w = false -- map <c-w> to delete a pair if possible
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

-- -- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
-- cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"
EOF
