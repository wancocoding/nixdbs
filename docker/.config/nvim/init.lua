-- vim:set ft=lua et sts=4 ts=4 sw=4 tw=78:

require("plugins")
-- ===========================
-- Core Settings
-- ===========================
require("core.basic")
require("core.appearance")
require("core.abbreviations")
require("core.mapping")

-- ===========================
-- Plugin Settings
-- ===========================

-- LSP settings
require("plugin.lsp-config")
-- require('plugin.lspsaga')
-- completion-nvim
require("plugin.completion-nvim")
-- fzf
require("plugin.fzf")
-- nvim-tree
require("plugin.nvim-tree")
-- dashboard
require("plugin.dashboard")
-- hop
require("plugin.hop")
-- vim-which-key
require("plugin.vim-which-key")
-- zen
require("plugin.goyo")
-- git
require("plugin.gitsigns")
-- formatter
require("plugin.formatter")
