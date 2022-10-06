let mapleader=','
let no_buffers_menu=1
let g:vim_markdown_folding_disabled = 1


if (has("termguicolors"))
  set termguicolors
endif

call plug#begin(expand('~/.vim/plugged'))
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
Plug 'janko-m/vim-test'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
call plug#end()

syntax on
filetype plugin indent on
colorscheme $VIM_THEME
set clipboard+=unnamedplus
set background=dark
set backspace=indent,eol,start
set conceallevel=2
set encoding=utf-8
set expandtab
set fileencoding=utf-8
set fileformats=unix,dos,mac
set gcr=a:blinkon0
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
set hidden
set hlsearch
set ignorecase
set incsearch
set mouse=a
set mousemodel=popup
set nobackup
set noerrorbells visualbell t_vb=
set nohlsearch
set noswapfile
set nowritebackup
set number
set ruler
set scrolloff=6
set shortmess+=c
set signcolumn=yes
set smartcase
set splitbelow
set t_Co=256
set title
set titlestring=%F
set ttyfast
set undodir=~/.vim/undo
set undofile
set updatetime=200
set visualbell t_vb=
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
set wildmode=list:longest,list:full
set relativenumber
set guicursor=i-ci:ver25
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set copyindent

if $COLORTERM == 'gnome-terminal'
  set term=gnome-256color
endif

if &term =~ '256color'
  set t_ut=
endif

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

source <sfile>:h/.airline-config.vim
source <sfile>:h/.go-config.vim
source <sfile>:h/.coc-config.vim

augroup BASE
    autocmd!
    au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
augroup END

"" Line movement
inoremap <S-Down> <Esc>:m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
nnoremap <S-Down> :m+<CR>
nnoremap <S-Up> :m-2<CR>

"" Vim test
nnoremap <leader>tt :TestNearest

"" Move to middle of line
nnoremap gm :call cursor(0, virtcol('$')/2)<CR>

"" Vertical window resize
noremap <silent> <S-Right> :vertical resize +15<CR>
noremap <silent><S-Left> :vertical resize -15<CR>

"" Copy/Past from clipboard
noremap <leader>y "+y<CR>
noremap <leader>p "+p<CR>
noremap <leader>Y "+y<CR>
noremap <leader>P "+p<CR>

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap < <gv
vnoremap > >gv


"" Tags
nnoremap <silent> <F4> :TagbarToggle<CR>

"" Switching windows
noremap <C-Down> <C-w>j
noremap <C-Up> <C-w>k
noremap <C-Right> <C-w>l
noremap <C-Left> <C-w>h

"" Split
noremap <leader>h :<C-u>split<CR>
noremap <leader>v :<C-u>vsplit<CR>

"" Git
noremap <leader>ga :Gwrite<CR>
noremap <leader>gc :Git commit<CR>
noremap <leader>gsh :Git push<CR>
noremap <leader>gll :Git pull<CR>
noremap <leader>gb :Git blame<CR>
noremap <leader>gd :Gvdiff<CR>
noremap <leader>gr :Git remove<CR>

"" Buffer nav
nnoremap <tab> :bn<CR>
nnoremap <s-tab> :bp<CR>
nnoremap <leader>c :bd!<CR>

"" Toggle relative numbers
nnoremap <leader>r :set relativenumber!<CR>

nnoremap <silent> <leader>vc :! code $(git rev-parse --show-toplevel) && code %<CR>
nnoremap <silent> <leader>ij :! idea %<CR>

nnoremap V v$

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fl <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').git_branches()<cr>

lua << EOF
require("mason").setup()
require("mason-lspconfig").setup()
require('telescope').load_extension('fzf')
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  debounce_text_changes = 150,
}

require('lspconfig').gopls.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
EOF
