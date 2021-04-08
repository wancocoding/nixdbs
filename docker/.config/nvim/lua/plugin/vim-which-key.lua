vim.api.nvim_set_keymap('n', '<leader>', [[:<c-u>WhichKey '<Space>'<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>', [[:<c-u>WhichKeyVisual '<Space>'<CR>]], { noremap = true, silent = true })

vim.g.which_key_timeout = 500

vim.g.which_key_display_names = {['<CR>'] = '↵', ['<TAB>'] = '⇆', [" "] = 'SPC'}

vim.g.which_key_sep = '→'

local which_key_map = { name = "Leader" }

which_key_map['o'] = 'find file'
which_key_map['p'] = 'find buffer'

which_key_map[';'] = { ':Dashboard', 'Start Screen' }
which_key_map['.'] = 'Change Workroot'
which_key_map['H'] = { ':let @/ = ""', 'clear highlight' }
-- which_key_map['w'] = {
-- 	name = '+windows',
-- 	["w"] = { '<C-W>w', 'other-window' },
-- }

which_key_map['t'] = {
	name = '+Tab/Terminal',
  ["n"] = { 'tabnew', 'new tab' },
	["c"] = { 'tabclose', 'close tab' },
	["o"] = { 'tabonly', 'only tab' },
	["f"] = { 'tabfirst', 'first tab' },
	["l"] = { 'tablast', 'last tab' },
	["`"] = { ':FloatermNew --wintype=normal --height=6', 'Terminal' },
}


 which_key_map['l'] = {
	name = '+LSP',
 	["a"] = 'code action',
 	["A"] = 'range code action',
 	["f"] = 'format code',
 	["l"] = 'lsp finder',
 	["I"] = 'LspInfo',
 }

 which_key_map['w'] = {
	name = '+Workspace',
 	["a"] = 'add ws folder',
 	["r"] = 'remove ws folder',
 	["l"] = 'list ws folders',
 }

 which_key_map['s'] = {
	name = '+Session/Search',
 	["s"] = 'save session',
 	["l"] = 'load session',
 }

 which_key_map['v'] = {
	name = '+View/Color',
 	["c"] = 'colorschemes',
 }

 which_key_map['f'] = {
	name = '+FuzzyFinder',
 	["w"] = 'find word',
 	["m"] = 'find mark',
 	["h"] = 'find history',
 	["p"] = 'find maps',
 }

vim.g.which_key_map = which_key_map
vim.fn["which_key#register"]("<Space>", "g:which_key_map")
