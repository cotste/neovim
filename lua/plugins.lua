return require('packer').startup(function()

  use 'wbthomason/packer.nvim'
 
  use 'folke/tokyonight.nvim' 
 
  use 'xiyaowong/nvim-transparent'
  
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use {
    'nvim-treesitter/nvim-treesitter',
--    run = ':TSUpdate'
  }

  use 'nvim-telescope/telescope-project.nvim'

  use 'nvim-telescope/telescope-fzy-native.nvim'

  use 'neovim/nvim-lspconfig'
  
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'nvim-tree'.setup {} end
  }

  use 'tpope/vim-fugitive'

  use {
    'akinsho/bufferline.nvim', 
    requires = 'kyazdani42/nvim-web-devicons'
  }

  use 'karb94/neoscroll.nvim'

end)


