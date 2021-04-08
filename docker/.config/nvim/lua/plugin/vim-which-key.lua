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
 	["n"] = 'rename',
 	["r"] = 'reference',
 	["q"] = 'diagnostics in qf',
 	["e"] = 'show line diagnostics',
 	["f"] = 'format code',
 	["d"] = 'type definition',
 	["I"] = {':LspInfo', "Lsp Info"},
 }

 which_key_map['w'] = {
	name = '+LspWS',
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
 	["g"] = 'Goyo',
 	["o"] = 'Limelight',
 }

 which_key_map['f'] = {
	name = '+FuzzyFinder',
 	["w"] = 'find word',
 	["m"] = 'find mark',
 	["h"] = 'find history',
 	["p"] = 'find maps',
 }

 -- easy jump in buffer with hop
 which_key_map['j'] = {
	name = '+JumpWithHop',
 	["w"] = 'hint words',
 	["l"] = 'hint lines',
 	["c"] = 'hop char1',
 	["C"] = 'hop char2',
 	["p"] = 'hop pattern',
 }

 which_key_map['g'] = {
	name = '+Git',
	-- gitsigns
 	["s"] = 'stage hunk',
 	["r"] = 'reset hunk',
 	["R"] = 'reset buffer',
 	["p"] = 'preview hunk',
 	["b"] = 'blame line',
 	["u"] = 'undo stage hunk',
	-- fugitive
 	["d"] = {':Git diff', 'git diff'},
 	["B"] = {':GBrowse', 'git browse'},
 	["S"] = {':Gstatus', 'git status'},
 	["l"] = {':Git log', 'git log'},
	-- git-blame
 	[","] = {':GitBlameToggle', 'toggle git-blame'},
 }
vim.g.which_key_map = which_key_map
vim.fn["which_key#register"]("<Space>", "g:which_key_map")


-- local which_key_map_left_square_bracket = { name = "[" }

-- which_key_map_left_square_bracket['c'] = 'previous hunk'

-- vim.g.which_key_map_left_square_bracket = which_key_map_left_square_bracket
-- vim.fn["which_key#register"]("[", "g:which_key_map_left_square_bracket")

