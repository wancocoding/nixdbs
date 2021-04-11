
-- ==============================
-- Appearance
-- ==============================
-- set background=dark
-- colorscheme oceanic_material
vim.o.background = "dark"
-- ====== palenight
-- vim.cmd('colorscheme palenight')

-- ====== material oceanic
-- vim.cmd('colorscheme oceanic_material')

-- ====== material
-- material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker' | 'default-community' | 'palenight-community' | 'ocean-community' | 'lighter-community' | 'darker-community'
-- vim.g.material_theme_style = 'palenight'
-- vim.cmd('colorscheme material')

-- ====== onedark
vim.cmd('colorscheme onedark')


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


