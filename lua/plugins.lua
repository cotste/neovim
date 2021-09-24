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
    run = ':TSUpdate'
  }

  use 'nvim-telescope/telescope-project.nvim'

end)


