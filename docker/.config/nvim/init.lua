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
-- lspsaga
require('plugin.lspsaga')
-- completion-nvim
require("plugin.completion-nvim")
-- telescope
require("plugin.telescope")
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
-- vista
require("plugin.vista")
-- barbar
-- require("plugin.barbar")
