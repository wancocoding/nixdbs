-- vim:set ft=lua et sts=4 ts=4 sw=4 tw=78:

require('plugins')
-- base settings
require('core.basic')
require('core.appearance')

-- ===========================
-- Plugin Settings
-- ===========================

-- LSP settings
require('plugin.lsp-config')
-- completion-nvim
require('plugin.completion-nvim')
-- fzf
require('plugin.fzf')
-- nvim-tree
require('plugin.nvim-tree')
