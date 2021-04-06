
-- ==============================
-- Appearance
-- ==============================
-- set background=dark
-- colorscheme oceanic_material
vim.o.background = "dark"
vim.cmd('colorscheme oceanic_material')

vim.cmd('syntax enable')
vim.cmd('syntax on')
vim.o.tw = 79

-- vim.cmd('set list')
vim.o.list = true
-- vim.cmd("set listchars=eol:¬,tab:▸\\ ,trail:·,precedes:←,extends:→")
vim.o.listchars = "eol:¬,tab:▸ ,trail:·,precedes:←,extends:→"
-- listchars      = { eol = "↲", tab= "» " }

vim.o.termguicolors = true
vim.o.ruler = true
vim.o.cursorline = true


