let g:ale_disable_lsp = 1
let g:vim_bootstrap_langs = "go,html,javascript,python,rust,typescript,markdown"
let g:vim_bootstrap_editor = "vim"
let g:markdown_enable_folding = 1

call plug#begin(expand('~/.vim/plugged'))
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'Raimondi/delimitMate'
Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
Plug 'majutsushi/tagbar'
Plug 'mhartington/oceanic-next'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'gabrielelana/vim-markdown'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'francoiscabrol/ranger.vim'
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif
call plug#end()

nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>
noremap <S-Right> :vertical resize +15<CR>
noremap <S-Left> :vertical resize -15<CR>
noremap <leader>s :update<CR>
nnoremap gm :call cursor(0, virtcol('$')/2)<CR>

" Terminal settings
let mapleader=','

syntax on
colorscheme OceanicNext
set guicursor=i:ver25-iCursor
set termwinsize=10x0
set splitbelow
set backspace=indent,eol,start
set bg=dark
set cmdheight=2
set encoding=utf-8
set expandtab
set fileencoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
set gcr=a:blinkon0
set gfn=Monospace\ 10
set guioptions=egmrti
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set modeline
set modelines=10
set mousemodel=popup
set nobackup
set noswapfile
set nowritebackup
set number
set ruler
set scrolloff=3
set shiftwidth=4
set shortmess+=c
set signcolumn=yes
set smartcase
set smartindent
set softtabstop=0
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
set t_Co=256
set tabstop=4
set title
set titleold="Terminal"
set titlestring=%F
set ttyfast
set updatetime=300


if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

filetype plugin indent on

let no_buffers_menu=1
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '┆'
let g:indentLine_faster = 1

if $COLORTERM == 'gnome-terminal'
  set term=gnome-256color
endif

if &term =~ '256color'
  set t_ut=
endif

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" terminal emulation
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

"" buffer nav
nnoremap <tab> :bn<CR>
nnoremap <s-tab> :bp<CR>
noremap <leader>c :bd<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Opens an edit command with the path of the currently edited file filled in
noremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

"" fzf.vim
set wildmode=list:longest,list:full
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"


set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__

cnoremap <c-p> <c-r>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>ft :Rg<CR>
nnoremap <expr> <leader>fs ':Rg '.expand('<cword>').'<cr>'

"Recovery commands from history through FZF
nmap <leader>y :History:<CR>

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

"" Close buffer

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

source <sfile>:h/.nerdtree-config.vim
source <sfile>:h/.airline-config.vim
source <sfile>:h/.go-config.vim
source <sfile>:h/.coc-config.vim
source <sfile>:h/.ale-config.vim
