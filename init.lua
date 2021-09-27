
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
map( 'n', '<leader>tt', ':TransparentToggle<cr>', options)
map( 'n', '<leader>pp', ':Telescope project<cr>', options)
map( 'n', '<leader>ga', ':Gwrite<cr>', options)
map( 'n', '<leader>gp', ':Gpush<cr>', options)
map( 'n', '<leader>gc', ':Git commit<cr>', options)


-- Some basic options
set.clipboard = 'unnamedplus'
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true
o.termguicolors = true

-- Colorschemes

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

require'lspconfig'.pyright.setup {}
require'lspconfig'.terraformls.setup {}
require'lspconfig'.yamlls.setup {}
 
require('bufferline').setup({
  -- ...
})

require('neoscroll').setup()
