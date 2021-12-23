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

-- treesitter
require("plugin.treesitter")

-- fzf
-- require("plugin.fzf")

-- telescope
require("plugin.telescope")


-- nvim-tree
require("plugin.nvim-tree")

-- vista
require("plugin.vista")



-- ============================
-- LSP Settings
-- ============================

require("plugin.nvim-cmp")

require("plugin.lspconfig")

