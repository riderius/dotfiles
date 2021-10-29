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

set background=dark
set termguicolors

"set mouse=a "enable mouse

syntax on

call plug#begin('~/.vim/plugins')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'jiangmiao/auto-pairs'

Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'

let g:airline_powerline_fonts = 1
let g:Powerline_symbols='unicode'

"Plug 'scrooloose/syntastic'

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"let g:syntastic_python_checkers = ['pylint']
"let g:syntastic_python_pylint_post_args =
"        \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol} {msg_id}] {msg}"'
"let g:syntastic_cpp_compiler_options = "-pedantic -Wall -Wextra -Wcast-align -Wcast-qual -Wctor-dtor-privacy -Wdisabled-optimization -Wformat=2 -Winit-self -Wlogical-op -Wmissing-declarations -Wmissing-include-dirs -Wnoexcept -Wold-style-cast -Woverloaded-virtual -Wredundant-decls -Wshadow -Wsign-conversion -Wsign-promo -Wstrict-null-sentinel -Wstrict-overflow=5 -Wswitch-default -Wundef -Wno-unused"

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

Plug 'lervag/vimtex'

Plug 'mbbill/undotree'

call plug#end()

"let g:vimtex_compiler_progname = 'nvr'

map  <C-n> :NERDTreeToggle<CR>

"map <C-d> :lclose<CR>
"map <C-e> :Errors<CR>

" off up down left right
"noremap <Up> <nop>
"noremap <Down> <nop>
"noremap <Left> <nop>
"noremap <Right> <nop>

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

"ctrl + s
map <C-s> :w<CR>
"colors themes
let g:colors_name=""
"let g:colors_name="borland"

"undotree
nnoremap <F5> :UndotreeToggle<CR>

lua << EOF
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  completion = {
    autocomplete = false
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
EOF


lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'ccls', 'pylsp', 'texlab' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

nvim_lsp.ccls.setup {
  init_options = {
    cache = {
      directory = "/tmp/.ccls-cache";
    };
  }
}
EOF

" Delete buffer while keeping window layout (don't close buffer's windows).
" Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
if v:version < 700 || exists('loaded_bclose') || &cp
  finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
  let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
function! s:Bclose(bang, buffer)
  if empty(a:buffer)
    let btarget = bufnr('%')
  elseif a:buffer =~ '^\d\+$'
    let btarget = bufnr(str2nr(a:buffer))
  else
    let btarget = bufnr(a:buffer)
  endif
  if btarget < 0
    call s:Warn('No matching buffer for '.a:buffer)
    return
  endif
  if empty(a:bang) && getbufvar(btarget, '&modified')
    call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
    return
  endif
  " Numbers of windows that view target buffer which we will delete.
  let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
  if !g:bclose_multiple && len(wnums) > 1
    call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
    return
  endif
  let wcurrent = winnr()
  for w in wnums
    execute w.'wincmd w'
    let prevbuf = bufnr('#')
    if prevbuf > 0 && buflisted(prevbuf) && prevbuf != btarget
      buffer #
    else
      bprevious
    endif
    if btarget == bufnr('%')
      " Numbers of listed buffers which are not the target to be deleted.
      let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
      " Listed, not target, and not displayed.
      let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
      " Take the first buffer, if any (could be more intelligent).
      let bjump = (bhidden + blisted + [-1])[0]
      if bjump > 0
        execute 'buffer '.bjump
      else
        execute 'enew'.a:bang
      endif
    endif
  endfor
  execute 'bdelete'.a:bang.' '.btarget
  execute wcurrent.'wincmd w'
endfunction
command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose(<q-bang>, <q-args>)
nnoremap <silent> <Leader>bd :Bclose<CR>


map gn :bn<cr>
map gp :bp<cr>
map gw :Bclose<cr>

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