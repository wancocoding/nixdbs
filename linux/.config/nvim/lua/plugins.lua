-- vim:set ft=lua et sts=2 ts=2 sw=2 tw=78:

-- get the packer install path, stdpath of data is ~/.local/share/nvim
-- you can use :lua print(vim.fn.stdpath('data')) to checkout it

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end



-- Run PackerCompile Automatic
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])


return require('packer').startup(function(use)

  -- packer
  use "wbthomason/packer.nvim"

  -- ===================
  -- UI appearances
  -- ===================
  -- icon
  use "kyazdani42/nvim-web-devicons"
  use "ryanoasis/vim-devicons"


  -- ===================
  -- fuzzy
  -- ===================


  -- fzf
  -- use {"junegunn/fzf", dir = "~/.fzf", run = "./install --all"}
  -- use {"junegunn/fzf.vim"}

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}
  }
  use "nvim-telescope/telescope-media-files.nvim"

  -- ===================
  -- Status Line
  -- ===================
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }



  -- ===================
  -- Nvim-tree
  -- ===================
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    }
  }

-- ===================
  -- tagbar
  -- ===================
  use "liuchengxu/vista.vim"

  -- ===================
  -- colorschemes
  -- ===================
  use 'joshdick/onedark.vim'
  use 'morhetz/gruvbox'
  use {'kaicataldo/material.vim', branch='main'}
  use "glepnir/oceanic-material"
  use 'drewtempelmeyer/palenight.vim'
  use 'ayu-theme/ayu-vim'

  -- ===================
  -- Language Support
  -- ===================
  -- Treesitter
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}

    -- LSP base
    use "neovim/nvim-lspconfig"


    -- completion
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    -- dict
    use 'uga-rosa/cmp-dictionary'

    -- For vsnip users.
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    -- formatting
    use "mhartington/formatter.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
