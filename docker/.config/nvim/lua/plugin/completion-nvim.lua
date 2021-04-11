vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {expr = true})

-- Set completeopt to have a better completion experience
vim.cmd('set completeopt=menuone,noinsert,noselect')
-- Avoid showing message extra message when using completion
vim.cmd('set shortmess+=c')

-- possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip', 'snippets.nvim'
vim.g.completion_enable_snippet = 'UltiSnips'
-- Matching Strategy
vim.g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy', 'all' }
vim.g.completion_matching_ignore_case = 1
vim.g.completion_matching_smart_case = 1
-- Trigger keyword length
vim.g.completion_trigger_keyword_length = 1
-- trigger on delete
vim.g.completion_trigger_on_delete = 1
-- enable auto signature
vim.g.completion_enable_auto_signature = 1
