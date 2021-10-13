
-- 
local set = vim.opt
local cmd = vim.cmd
local o = vim.o
local map = vim.api.nvim_set_keymap

-- All the plugins
require('plugins')

-- Mappings
map('n', '<Space>', '', {})
vim.g.mapleader = ' '

options = { noremap = true }

map( 'n', '<leader><esc>', ':nohlsearch<cr>', options)
map( 'n', '<C-n>', ':NvimTreeToggle<cr>', options)
map( 'n', '<leader>gg', ':Git<cr>', options)
--map( 'n', '<leader>tt', ':TransparentToggle<cr>', options)

-- Fugitive bindings
map( 'n', '<leader>ga', ':Gwrite<cr>', options)
map( 'n', '<leader>gp', ':Git push<cr>', options)
map( 'n', '<leader>gc', ':Git commit<cr>', options)

-- Telescope bindings
map( 'n', '<leader>p', ':Telescope project<cr>', options)
map( 'n', '<leader>b', ':Telescope buffers<cr>', options)
map( 'n', '<leader>f', ':Telescope find_files<cr>', options)

-- Lsp Saga
map('n', '<leader>to', ':Lspsaga open_floaterm<CR>', options)
map('t', '<leader>tc', '<C-\\><C-n>:Lspsaga close_floaterm<CR>', options)
map('n', '<leader>ca', ':Lspsaga code_actions<CR>', options)

-- lsp provider to find the cursor word definition and reference
map('n', 'gh', ':Lspsaga lsp_finder<CR>', options)

-- Some basic options
set.clipboard = 'unnamedplus'
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true
set.number = true
o.termguicolors = true

-- Colorschemes
vim.g.tokyonight_style = "storm"
cmd[[colorscheme tokyonight]]

-- Telescope options
require('telescope').setup {
  extensions = {
    project = {
      base_dirs = {
	      {'~/winhome/repos/expd', max_depth = 4},
        {'~/.config', max_depth = 2},
      },
      hidden_files = true
    }
  }
}

require('telescope').load_extension('project')
require('telescope').load_extension('fzy_native')

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

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
local servers = { 'pyright', 'terraformls', 'yamlls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

require'bufferline'.setup({
  -- ...
})

require('neoscroll').setup {}

require'nvim-tree'.setup {
  view = {
    width = 40,
  },
  update_focused_file = {
    enabled = true,
    update_cwd = true
  }
}

require('lualine').setup {
  options = {theme = 'tokyonight'}
}

require('gitsigns').setup {}

local saga = require 'lspsaga'

-- add your config value here
-- default value
-- use_saga_diagnostic_sign = true
-- error_sign = '',
-- warn_sign = '',
-- hint_sign = '',
-- infor_sign = '',
-- dianostic_header_icon = '   ',
-- code_action_icon = ' ',
-- code_action_prompt = {
--   enable = true,
--   sign = true,
--   sign_priority = 20,
--   virtual_text = true,
-- },
-- finder_definition_icon = '  ',
-- finder_reference_icon = '  ',
-- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
-- finder_action_keys = {
--   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
-- },
-- code_action_keys = {
--   quit = 'q',exec = '<CR>'
-- },
-- rename_action_keys = {
--   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
-- },
-- definition_preview_icon = '  '
-- "single" "double" "round" "plus"
-- border_style = "single"
-- rename_prompt_prefix = '➤',
-- if you don't use nvim-lspconfig you must pass your server name and
-- the related filetypes into this table
-- like server_filetype_map = {metals = {'sbt', 'scala'}}
-- server_filetype_map = {}

--saga.init_lsp_saga {
--  your custom option here
--}

-- or --use default config
saga.init_lsp_saga()

