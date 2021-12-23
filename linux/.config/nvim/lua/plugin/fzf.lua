-- vim:set ft=lua et sts=4 ts=4 sw=4 tw=78:


vim.cmd([[
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -- ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0) ]])

-- fzf settings
vim.api.nvim_set_keymap('n', '<leader>o', ':Files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>p', ':Buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fm', ':Marks<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fp', ':Maps<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fw', ':Rg<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fh', ':History<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>vc', ':Colors<CR>', { noremap = true })

-- fzf complete
vim.api.nvim_set_keymap('i', '<C-x><C-k>', '<plug>(fzf-complete-word)', { noremap = false, silent = false})
vim.api.nvim_set_keymap('i', '<C-x><C-f>', '<plug>(fzf-complete-path)', { noremap = false, silent = false})
vim.api.nvim_set_keymap('i', '<C-x><C-l>', '<plug>(fzf-complete-line)', { noremap = false, silent = false})


