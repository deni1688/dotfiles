let mapleader=','

let no_buffers_menu=1
let g:ale_disable_lsp = 1
let g:vim_markdown_folding_disabled = 1
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '┆'
let g:indentLine_faster = 1
let g:UltiSnipsEditSplit="vertical"

call plug#begin(expand('~/.vim/plugged'))
Plug 'mhartington/oceanic-next'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'mxw/vim-jsx'
Plug 'NLKNguyen/papercolor-theme'
Plug 'Raimondi/delimitMate'
Plug 'simnalamburt/vim-mundo'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'arzg/vim-colors-xcode'
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
Plug 'honza/vim-snippets'
Plug 'janko-m/vim-test'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'preservim/tagbar'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif
call plug#end()

syntax on
filetype plugin indent on
colorscheme $VIM_THEME
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
set smartindent
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
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line

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
source <sfile>:h/.ale-config.vim
source <sfile>:h/.coc-config.vim
source <sfile>:h/.nerdtree-config.vim

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

"" FZF
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <C-l> :BLines<CR>
nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> <C-f> :Rg<CR>

"" Tags
nnoremap <silent> <F4> :TagbarToggle<CR>
nnoremap <silent> <F5> :MundoToggle<CR>

"" Switching windows
noremap <C-Down> <C-w>j
noremap <C-Up> <C-w>k
noremap <C-Right> <C-w>l
noremap <C-Left> <C-w>h

"" Terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>

"" Split
noremap <leader>h :<C-u>split<CR>
noremap <leader>v :<C-u>vsplit<CR>

"" Git
noremap <leader>ga :Gwrite<CR>
noremap <leader>gc :Git commit<CR>
noremap <leader>gsh :Git push<CR>
noremap <leader>gll :Git pull<CR>
noremap <leader>gs :Git<CR>
noremap <leader>gb :Gblame<CR>
noremap <leader>gd :Gvdiff<CR>
noremap <leader>gr :Gremove<CR>

"" Buffer nav
nnoremap <tab> :bn<CR>
nnoremap <s-tab> :bp<CR>
nnoremap <leader>c :bd<CR>

"" Saving faster
nnoremap <silent> <leader>w <Esc>:w <CR>
"" Toggle relative numbers
nnoremap <leader>r :set relativenumber!<CR>

"" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fl <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <silent> <leader> <Esc>o
