-- vim:set ft=lua et sts=2 ts=2 sw=2 tw=78:
-- get the packer install path, stdpath of data is ~/.local/share/nvim
--   you can use :lua print(vim.fn.stdpath('data')) to checkout it
local install_path =
  vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- check packer installed or not

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd(
    "!git clone https://hub.fastgit.org/wbthomason/packer.nvim " ..
      install_path
  )
  vim.cmd [[packadd packer.nvim]]
end

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

-- auto compile plugins.lua
vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

local ok, packer = pcall(require, "packer")

if ok then
  local use = packer.use
  packer.init {
    git = {
      clone_timeout = 300 -- 5 minutes, I have horrible internet
    }
  }
  packer.startup(
    function()
      -- packer
      use "wbthomason/packer.nvim"
      -- ===================
      -- Language Support
      -- ===================
      -- LSP base
      use "neovim/nvim-lspconfig"
      use "glepnir/lspsaga.nvim"
      -- use 'nvim-lua/lsp-status.nvim'
      -- completion
      use "nvim-lua/completion-nvim"

      -- snippets
      use "honza/vim-snippets"
      use "SirVer/ultisnips"

      -- code format
      use "mhartington/formatter.nvim"

      -- Treesitter
      use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}

      -- ===================
      -- Golang
      -- ===================
      use "fatih/vim-go"
      -- ===================
      -- start screen
      -- ===================
      use "glepnir/dashboard-nvim"

      -- ===================
      -- fuzzy finder
      -- ===================
      -- fzf
      use {"junegunn/fzf", dir = "~/.fzf", run = "./install --all"}
      use {"junegunn/fzf.vim"}
      -- Telescope
      use {
        "nvim-telescope/telescope.nvim",
        requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}
      }
      use "nvim-telescope/telescope-media-files.nvim"

      -- ===================
      -- file explorer
      -- ===================
      use "kyazdani42/nvim-web-devicons"
      use "kyazdani42/nvim-tree.lua"

      -- ===================
      -- git plugin
      -- ===================
      use "tpope/vim-fugitive"
      -- use 'airblade/vim-gitgutter'
      use {
        "lewis6991/gitsigns.nvim",
        requires = {
          "nvim-lua/plenary.nvim"
        }
      }
      use "f-person/git-blame.nvim"

      -- ===================
      -- tagbar
      -- ===================
      use "liuchengxu/vista.vim"
      -- ===================
      -- terminal
      -- ===================
      use "voldikss/vim-floaterm"

      -- ===================
      -- Misc
      -- ===================
      -- surround
      use "tpope/vim-surround"
      -- auto align
      use "junegunn/vim-easy-align"
      -- comment tools
      use "tpope/vim-commentary"
      -- easy motion like
      use {
        "phaazon/hop.nvim",
        as = "hop",
        config = function()
          -- you can configure Hop the way you like here; see :h hop-config
          require "hop".setup {keys = "etovxqpdygfblzhckisuran"}
        end
      }

      -- key mapping helper
      use "liuchengxu/vim-which-key"

      -- zen writing
      use "junegunn/limelight.vim"
      use "junegunn/goyo.vim"

      -- ===================
      -- UI appearances
      -- ===================
      -- icon
      -- use "kyazdani42/nvim-web-devicons"
      use "ryanoasis/vim-devicons"
      -- status line
      use {
        "glepnir/galaxyline.nvim",
        branch = "main",
        -- your statusline
        config = function()
          require "plugin.statusline"
        end,
        -- some optional icons
        requires = {"kyazdani42/nvim-web-devicons", opt = true}
      }
      -- buffer line
      use "romgrk/barbar.nvim"
      -- colorschemes
      use 'joshdick/onedark.vim'
      use {'kaicataldo/material.vim', branch='main'}
      use "glepnir/oceanic-material"
      use 'drewtempelmeyer/palenight.vim'
    end
  )
end
