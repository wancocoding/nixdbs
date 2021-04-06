vim.api.nvim_set_keymap('n', '<leader>', [[:<c-u>WhichKey '<Space>'<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>', [[:<c-u>WhichKeyVisual '<Space>'<CR>]], { noremap = true, silent = true })

vim.g.which_key_timeout = 500

vim.g.which_key_display_names = {['<CR>'] = '↵', ['<TAB>'] = '⇆', [" "] = 'SPC'}

vim.g.which_key_sep = '→'

local which_key_map = { name = "Leader" }

which_key_map[';'] = { ':Dashboard', 'Start Screen' }
which_key_map['.'] = 'Change Workroot'
which_key_map['H'] = { ':let @/ = ""', 'clear highlight' }
-- which_key_map['w'] = {
-- 	name = '+windows',
-- 	["w"] = { '<C-W>w', 'other-window' },
-- }

which_key_map['t'] = {
	name = '+tab/others',
	["n"] = { 'tabnew', 'new tab' },
	["c"] = { 'tabclose', 'close tab' },
	["o"] = { 'tabonly', 'only tab' },
	["f"] = { 'tabfirst', 'first tab' },
	["l"] = { 'tablast', 'last tab' },
	["`"] = { ':FloatermNew --wintype=normal --height=6', 'Terminal' },
}


-- which_key_map['w'] = {
-- 	name = '+windows',
-- 	["w"] = { '<C-W>w', 'other-window' },
-- }

vim.g.which_key_map = which_key_map
vim.fn["which_key#register"]("<Space>", "g:which_key_map")
