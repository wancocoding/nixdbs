-- vim:set ft=lua et sts=4 ts=4 sw=4 tw=78:






-- Load Plugin Manager
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

-- Lualine
require("plugin.lualine")
-- galaxyline
-- require("plugin.galaxyline")

-- treesitter
require("plugin.treesitter")

-- fzf
require("plugin.fzf")

-- telescope
require("plugin.telescope")


-- nvim-tree
require("plugin.nvim-tree")

-- vista
require("plugin.vista")

-- ============================
-- Git
-- ============================

-- gitsign
require("plugin.gitsign")

-- ============================
-- LSP Settings
-- ============================

require("plugin.nvim-cmp")

require("plugin.lspconfig")

-- formatting
require("plugin.formatter")

-- trouble
require("plugin.trouble")

-- ============================
-- Misc
-- ============================
-- hop
require("plugin.hop")

-- dashboard
require("plugin.dashboard")


