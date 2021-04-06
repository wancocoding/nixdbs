vim.o.pastetoggle = '<F5>'
vim.api.nvim_set_keymap('n', '<leader>.', [[:lcd %:p:h<CR>:pwd<CR>]], { noremap = true })

-- Disable arrowkeys
vim.api.nvim_set_keymap('n', '<Up>', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Down>', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Left>', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Right>', '<Nop>', { noremap = true })

-- center search result
vim.api.nvim_set_keymap('n', 'n', 'nzvzz', { noremap = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzvzz', { noremap = true })
vim.api.nvim_set_keymap('n', '*', '*zvzz', { noremap = true })
vim.api.nvim_set_keymap('n', '#', '#zvzz', { noremap = true })

-- window resize
vim.api.nvim_set_keymap('n', '<C-Up>', ':resize -1<CR>', { noremap = true, silent =true })
vim.api.nvim_set_keymap('n', '<C-Down>', ':resize +1<CR>', { noremap = true, silent =true })
vim.api.nvim_set_keymap('n', '<C-Left>', ':vertical resize -1<CR>', { noremap = true, silent =true })
vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize +1<CR>', { noremap = true, silent =true })

-- leave terminal
vim.api.nvim_set_keymap('t', '<leader><Esc>', [[<C-\><c-n>]], { noremap = true })

-- better indenting
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true, silent = true})


