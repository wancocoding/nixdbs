vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {expr = true})

-- Set completeopt to have a better completion experience
vim.cmd('set completeopt=menuone,noinsert,noselect')
-- Avoid showing message extra message when using completion
vim.cmd('set shortmess+=c')
vim.g.completion_enable_snippet = 'UltiSnips'
vim.g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy', 'all' }
