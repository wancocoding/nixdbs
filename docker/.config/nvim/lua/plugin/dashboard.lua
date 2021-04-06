vim.g.dashboard_custom_header = {
' ██████╗ ██████╗  ██████╗ ██████╗ ███╗   ██╗██╗   ██╗██╗███╗   ███╗',
'██╔════╝██╔═══██╗██╔════╝██╔═══██╗████╗  ██║██║   ██║██║████╗ ████║',
'██║     ██║   ██║██║     ██║   ██║██╔██╗ ██║██║   ██║██║██╔████╔██║',
'██║     ██║   ██║██║     ██║   ██║██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║',
'╚██████╗╚██████╔╝╚██████╗╚██████╔╝██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║',
' ╚═════╝ ╚═════╝  ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝',
[[  ,---,---,---,---,---,---,---,---,---,---,---,---,---,-------,]],
[[  |1/2| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 | + | ' | <-    |]],
[[  |---'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-----|]],
[[  | ->| | Q | W | E | R | T | Y | U | I | O | P | ] | ^ |     |]],
[[  |-----',--',--',--',--',--',--',--',--',--',--',--',--'|    |]],
[[  | Caps | A | S | D | F | G | H | J | K | L | \ | [ | * |    |]],
[[  |----,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'---'----|]],
[[  |    | < | Z | X | C | V | B | N | M | , | . | - |          |]],
[[  |----'-,-',--'--,'---'---'---'---'---'---'-,-'---',--,------|]],
[[  | ctrl |  | alt |                          |altgr |  | ctrl |]],
[[  '------'  '-----'--------------------------'------'  '------']],
}
vim.g.dashboard_default_executive = 'fzf'
vim.g.dashboard_custom_footer = {'Vincent Woncocoding @cocoding.cc'}

vim.g.dashboard_custom_section = {
    a = {description = {'  Find File                             SPC f f'}, command = 'Files'},
    b = {description = {'  Recently Used Files                   SPC f h'}, command = 'History'},
    c = {description = {'  Load Last Session                     SPC s l'}, command = 'SessionLoad'},
    d = {description = {'  Find Word                             SPC f a'}, command = 'Rg'},
    e = {description = {'  New File                              SPC c n'}, command = 'DashboardNewFile'},
    f = {description = {'  Marks                                 SPC f b'}, command = 'Marks'},
    g = {description = {'  Settings                              SPC e s'}, command = ':e ~/.config/nvim/init.lua'},
    h = {description = {'  Colorschemes                          SPC t c'}, command = 'Colors'},
}
vim.api.nvim_set_keymap('n', '<leader>ss', ':<C-u>SessionSave<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>sl', ':<C-u>SessionLoad<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>fh', ':DashboardFindHistory<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', ':DashboardFindFile<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tc', ':DashboardChangeColorscheme<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fa', ':DashboardFindWord<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':DashboardJumpMark<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cn', ':DashboardNewFile<CR>', { noremap = true, silent = true })


vim.api.nvim_set_keymap('n', '<leader>;', ':Dashboard<CR>', { noremap = true, silent = true })
