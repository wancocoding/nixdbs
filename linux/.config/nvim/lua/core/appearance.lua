-- vim:set ft=lua et sts=4 ts=4 sw=4 tw=78:


-- ==============================
-- Appearance
-- ==============================

vim.o.background = "dark"

-- ====== oceanic material
-- colorscheme oceanic_material

-- ====== palenight
-- vim.cmd('colorscheme palenight')

-- ====== material oceanic
-- vim.cmd('colorscheme oceanic_material')

-- ====== material
-- material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker' | 'default-community' | 'palenight-community' | 'ocean-community' | 'lighter-community' | 'darker-community'
-- vim.g.material_theme_style = 'palenight'
-- vim.cmd('colorscheme material')

-- ====== onedark
-- vim.cmd('colorscheme onedark')

-- ====== Ayu
-- light / mirage / dark
vim.cmd([[let ayucolor="mirage"]])
vim.cmd('colorscheme ayu')

-- ====== gruvbox
-- vim.g.gruvbox_contrast_dark="hard"
-- vim.cmd('colorscheme gruvbox')


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
