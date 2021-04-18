let g:ale_disable_lsp = 1

call plug#begin(expand('~/.vim/plugged'))
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'Raimondi/delimitMate'
Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
Plug 'gabrielelana/vim-markdown'
Plug 'majutsushi/tagbar'
Plug 'mhartington/oceanic-next'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
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
set termwinsize=10x0
set splitbelow
"*****************************************************************************
" Basic Setup
"*****************************************************************************"
let mapleader=','

autocmd VimEnter * set signcolumn="4"

syntax on
colorscheme OceanicNext
set backspace=indent,eol,start
set encoding=utf-8
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
set noswapfile
set number
set ruler
set scrolloff=3
set tabstop=4
set shiftwidth=4
set smartcase
set expandtab
set softtabstop=0
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
set t_Co=256
set title
set titleold="Terminal"
set titlestring=%F
set ttyfast

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif
filetype plugin indent on

" session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

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

" session management
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

"" Tabs
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>tn :tabnew<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Opens an edit command with the path of the currently edited file filled in
noremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

"" fzf.vim
set wildmode=list:longest,list:full
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" " ripgrep
" if executable('rg')
"   let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
"   set grepprg=rg\ --vimgrep
"   command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
" endif

set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
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
"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

"" Close buffer
noremap <leader>c :bd<CR>

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

function! s:update_fzf_colors()
  let rules =
  \ { 'fg':      [['Normal',       'fg']],
    \ 'bg':      [['Normal',       'bg']],
    \ 'hl':      [['Comment',      'fg']],
    \ 'fg+':     [['CursorColumn', 'fg'], ['Normal', 'fg']],
    \ 'bg+':     [['CursorColumn', 'bg']],
    \ 'hl+':     [['Statement',    'fg']],
    \ 'info':    [['PreProc',      'fg']],
    \ 'prompt':  [['Conditional',  'fg']],
    \ 'pointer': [['Exception',    'fg']],
    \ 'marker':  [['Keyword',      'fg']],
    \ 'spinner': [['Label',        'fg']],
    \ 'header':  [['Comment',      'fg']] }
  let cols = []
  for [name, pairs] in items(rules)
    for pair in pairs
      let code = synIDattr(synIDtrans(hlID(pair[0])), pair[1])
      if !empty(name) && code > 0
        call add(cols, name.':'.code)
        break
      endif
    endfor
  endfor
  let s:orig_fzf_default_opts = get(s:, 'orig_fzf_default_opts', $FZF_DEFAULT_OPTS)
  let $FZF_DEFAULT_OPTS = s:orig_fzf_default_opts .
        \ empty(cols) ? '' : (' --color='.join(cols, ','))
endfunction

augroup _fzf
  autocmd!
  autocmd ColorScheme * call <sid>update_fzf_colors()
augroup END
