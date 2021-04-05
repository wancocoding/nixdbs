vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- set background=dark
-- colorscheme oceanic_material
vim.cmd('set background=dark')
vim.cmd('colorscheme oceanic_material')

-- LSP Settings
-- Set completeopt to have a better completion experience
vim.cmd('set completeopt=menuone,noinsert,noselect')
-- Avoid showing message extra message when using completion
vim.cmd('set shortmess+=c')
-- vim.g.completion_enable_snippet = 'UltiSnips'
-- vim.g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy', 'all' }

