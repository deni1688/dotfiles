vim.g.mapleader = ","
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "120"


vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("x", "<leader>p", [["_dP]])

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'tpope/vim-sensible'
Plug 'https://gitlab.com/__tpb/monokai-pro.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'VonHeikemen/lsp-zero.nvim'
Plug ('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })
Plug ('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

vim.call('plug#end')

vim.cmd [[
    syntax on
    filetype plugin indent on
    colorscheme monokaipro

    source ~/.config/nvim/.airline-config.vim

    if exists("*fugitive#statusline")
        set statusline=%(fugitive#statusline())
    endif

    "" Telescope
    nnoremap <leader>ff <cmd>Telescope find_files<cr>
    nnoremap <leader>fg <cmd>Telescope live_grep<cr>
    nnoremap <leader>fb <cmd>Telescope buffers<cr>
    nnoremap <leader>fh <cmd>Telescope help_tags<cr>
    nnoremap <leader>fl <cmd>Telescope current_buffer_fuzzy_find<cr>
    nnoremap <leader>fc <cmd>lua require('telescope.builtin').git_commits()<cr>
    nnoremap <leader>fr <cmd>lua require('telescope.builtin').git_branches()<cr>

    "" Line movement
    inoremap <S-Down> <Esc>:m+<CR>
    inoremap <S-Up> <Esc>:m-2<CR>
    nnoremap <S-Down> :m+<CR>
    nnoremap <S-Up> :m-2<CR>

    "" Vim test
    nnoremap <leader>tt :TestNearest

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

    nnoremap V v$
]]


require('telescope').load_extension('fzf')

-- LSP Config
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.ensure_installed({
  'tsserver',
  'eslint',
  'sumneko_lua',
  'rust_analyzer',
  'gopls',
  'vls'
})
lsp.setup()

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
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

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


require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['gopls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['sumneko_lua'].setup{
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags
}

require('lspconfig').vls.setup{}


vim.cmd([[
    au BufNewFile,BufRead *.v set filetype=vlang
    au BufNewFile,BufRead *.md set filetype=markdown
]])

require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = { "lua", "rust", "go", "javascript", "typescript", "python" },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
