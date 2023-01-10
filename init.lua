local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]]
end

local function tree_sitter_install() pcall(require('nvim-treesitter.install').update { with_sync = true }) end

require('packer').startup(function(use)
    use 'janko-m/vim-test'
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'
    use 'tpope/vim-commentary'
    use 'lewis6991/gitsigns.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'mbbill/undotree'
    use 'j-hui/fidget.nvim'

    -- themes
    use "rebelot/kanagawa.nvim"
    use 'sainnhe/gruvbox-material'
    use { "catppuccin/nvim", as = "catppuccin" }


    -- lsp
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    -- treesitter
    use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons' }, tag = 'nightly' }
    use { 'nvim-treesitter/nvim-treesitter', run = tree_sitter_install }
    use { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' }

    -- telescope
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
    use { 'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

    -- go
    use { 'fatih/vim-go', run = ':GoUpdateBinaries' }

    if is_bootstrap then
        require('packer').sync()
    end
end)

if is_bootstrap then
    print '=================================='
    print '    Plugins are being installed'
    print '    Wait until Packer completes,'
    print '       then restart nvim'
    print '=================================='
    return
end

vim.opt.syntax = 'enable'
vim.opt.nu = true
vim.opt.splitbelow = true
vim.opt.wildmode = { 'list:longest', 'list:full' }
vim.opt.wildignore = vim.opt.wildignore + { '*.o', '*.obj', '*.dll', '*.exe', '.git', '*.db' }
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')
vim.opt.updatetime = 50
vim.opt.colorcolumn = '120'
vim.opt.clipboard = 'unnamedplus'
vim.opt.textwidth = 80

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
    group = packer_group,
    pattern = vim.fn.expand '$MYVIMRC',
})

require('telescope').setup()
require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer]' })

require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'go', 'lua', 'python', 'rust', 'typescript', 'help', 'json', 'yaml', 'javascript', 'html', 'css'
    },
    sync_install = false,
    auto_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            },
            selection_modes = {
                ['@parameter.outer'] = 'v', -- charwise
                ['@function.outer'] = 'V', -- linewise
                ['@class.outer'] = '<c-v>', -- blockwise
            }
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
        lsp_interop = {
            enable = true,
            peek_definition_code = {
                ["df"] = "@function.outer",
                ["dF"] = "@class.outer",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
    },
}

local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
    "gopls",
    "rust_analyzer",
    "pyright",
    "tsserver",
    "bashls",
    "vimls",
    "jsonls",
    "yamlls",
    "dockerls",
    "sumneko_lua",
    "cssls",
    "eslint",
})

lsp.set_preferences({
    suggest_lsp_servers = true,
    setup_servers_on_start = true,
    set_lsp_keymaps = true,
    configure_diagnostics = true,
    cmp_capabilities = true,
    manage_nvim_cmp = true,
    call_servers = 'local',
    sign_icons = {
        error = '✘',
        warn = '▲',
        hint = '⚑',
        info = ''
    }
})

lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

lsp.configure('eslint', {
    filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
    init_options = {
        nodePath = vim.fn.exepath 'node',
        packageManager = 'yarn',
        yarn = {
            enable = true,
            path = vim.fn.exepath 'yarn',
        },
    },
})

lsp.on_attach(function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        local opts = { buffer = bufnr, remap = false, desc = desc }

        vim.keymap.set('n', keys, func, opts)
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    nmap('<leader>f', function() vim.lsp.buf.format { async = true } end, '[f]ormat with LSP')
    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', builtin.lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
        '[W]orkspace [L]ist Folders')
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_) vim.lsp.buf.format() end,
        { desc = 'Format current buffer with LSP' })
end)


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.setup()

require('gitsigns').setup()
require('fidget').setup()
require("nvim-tree").setup()
require('nvim-web-devicons').setup()
require('lualine').setup()

vim.cmd [[
    colorscheme gruvbox-material
    highlight CopilotSuggestion guifg=#2fb380 ctermfg=8
]]

vim.diagnostic.config({
    virtual_text = true,
})

-- close buffer
vim.keymap.set('n', '<leader>c', ':bd!<cr>')

-- testing mappings
vim.keymap.set('n', '<leader>tt', ':TestNearest<cr>')

-- move lines up and down
vim.keymap.set('v', '{', ':m \'>+1<cr>gv=gv')
vim.keymap.set('v', '}', ':m \'<-2<cr>gv=gv')
-- move between splits
vim.keymap.set('n', '<c-right>', ':bn<cr>')
vim.keymap.set('n', '<c-left>', ':bp<cr>')

-- toggle mappings
vim.keymap.set('n', '<F5>', ':UndotreeToggle<cr>')
vim.keymap.set('n', '<F6>', ':NvimTreeToggle<cr>')
vim.keymap.set('n', '<F7>', ':NvimTreeFocus<cr>')

-- find file in parent directory
vim.keymap.set('n', '<F7>', ':NvimTreeFindFile<cr>')

-- eslint fix
vim.keymap.set('n', '<leader>fa', ':EslintFixAll<cr>')

-- clipboard integration
vim.keymap.set({ 'n', 'v' }, '<leader>y', '\'+y<CR>', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>p', '\'+p<CR>', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '\'+y<CR>', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>P', '\'+p<CR>', { noremap = true })

-- git mappings
vim.keymap.set('n', '<leader>ga', ':Gwrite<cr>')
vim.keymap.set('n', '<leader>gaa', ':Git add .<cr>')
vim.keymap.set('n', '<leader>gc', ':Git commit<cr>')
vim.keymap.set('n', '<leader>gsh', ':Git push<cr>')
vim.keymap.set('n', '<leader>gll', ':Git pull<cr>')
vim.keymap.set('n', '<leader>gb', ':Git blame<cr>')
vim.keymap.set('n', '<leader>gd', ':Gvdiff<cr>')
vim.keymap.set('n', '<leader>gr', ':Git remove<cr>')

-- diagnostics mappings
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.keymap.set({'v', 'n'}, '<leader>r',  ':%s///g<left><left><left>')
