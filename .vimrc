let mapleader=','
let no_buffers_menu=1
let g:vim_markdown_folding_disabled = 1
let g:monokaipro_filter = "spectrum"

if (has("termguicolors"))
  set termguicolors
endif

call plug#begin(expand('~/.vim/plugged'))
Plug 'https://gitlab.com/__tpb/monokai-pro.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
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
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'artanikin/vim-synthwave84'
call plug#end()

syntax on
filetype plugin indent on
colorscheme $VIM_THEME


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

source <sfile>:h/.lsp-config.vim

lua << EOF
    require('telescope').load_extension('fzf')
EOF
