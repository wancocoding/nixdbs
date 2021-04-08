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

-- 这里是在dashboard里选择之后的命令,并不是快捷键,快捷键要单独定义
vim.g.dashboard_custom_section = {
    a = {description = {'  Find File                             SPC o  '}, command = 'Files'},
    b = {description = {'  Recently Used Files                   SPC p  '}, command = 'Buffers'},
    c = {description = {'  Load Last Session                     SPC s l'}, command = 'SessionLoad'},
    d = {description = {'  Find Word                             SPC f w'}, command = 'Rg'},
    e = {description = {'  New File                              SPC c n'}, command = 'DashboardNewFile'},
    f = {description = {'  Marks                                 SPC f m'}, command = 'Marks'},
    g = {description = {'  History                               SPC f h'}, command = 'History'},
    h = {description = {'גּ  Maps                                  SPC f p'}, command = 'Maps'},
    i = {description = {'  Settings                              SPC e s'}, command = ':e ~/.config/nvim/init.lua'},
    j = {description = {'  Colorschemes                          SPC v c'}, command = 'Colors'},
}
vim.api.nvim_set_keymap('n', '<leader>ss', ':<C-u>SessionSave<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>sl', ':<C-u>SessionLoad<CR>', { noremap = true })

-- vim.api.nvim_set_keymap('n', '<leader>p', ':DashboardFindHistory<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>o', ':DashboardFindFile<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>vc', ':DashboardChangeColorscheme<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>sa', ':DashboardFindWord<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>mm', ':DashboardJumpMark<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>cn', ':DashboardNewFile<CR>', { noremap = true, silent = true })


vim.api.nvim_set_keymap('n', '<leader>;', ':Dashboard<CR>', { noremap = true, silent = true })
