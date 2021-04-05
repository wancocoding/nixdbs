-- vim:set ft=lua et sts=2 ts=2 sw=2 tw=78:
-- get the packer install path, stdpath of data is ~/.local/share/nvim
--   you can use :lua print(vim.fn.stdpath('data')) to checkout it
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

-- check packer installed or not

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
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
      clone_timeout = 300, -- 5 minutes, I have horrible internet
    },
  }
  packer.startup(function()
    -- packer
    use 'wbthomason/packer.nvim'
    -- LSP base
    use 'neovim/nvim-lspconfig'
    -- use 'nvim-lua/lsp-status.nvim'
    -- completion
    use 'nvim-lua/completion-nvim'
    -- start screen
    -- use 'glepnir/dashboard-nvim'
    -- fzf
	  use {'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
	  use {'junegunn/fzf.vim'}

    -- snippets
  use 'honza/vim-snippets'
  use 'SirVer/ultisnips'

    -- tag
    use 'liuchengxu/vista.vim'

    -- status line
    use {
      'glepnir/galaxyline.nvim',
        branch = 'main',
        -- your statusline
        config = function() require'plugin.statusline' end,
        -- some optional icons
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    -- colorschemes
    use 'glepnir/oceanic-material'
  end)
end

