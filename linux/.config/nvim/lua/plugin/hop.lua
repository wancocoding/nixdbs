vim.api.nvim_set_keymap('n', '<leader>jw', "<cmd>lua require'hop'.hint_words()<cr>", {})
vim.api.nvim_set_keymap('n', '<leader>jl', "<cmd>lua require'hop'.hint_lines()<cr>", {})
vim.api.nvim_set_keymap('n', '<leader>jc', "<cmd>HopChar1<CR>", {})
vim.api.nvim_set_keymap('n', '<leader>jC', "<cmd>HopChar2<cr>", {})
vim.api.nvim_set_keymap('n', '<leader>jp', "<cmd>HopPattern<cr>", {})