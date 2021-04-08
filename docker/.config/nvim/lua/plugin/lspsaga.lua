local saga = require 'lspsaga'

-- add your config value here
-- default value
-- use_saga_diagnostic_sign = true
-- error_sign = '',
-- warn_sign = '',
-- hint_sign = '',
-- infor_sign = '',
-- dianostic_header_icon = '   ',
-- code_action_icon = ' ',
-- code_action_prompt = {
--   enable = true,
--   sign = true,
--   sign_priority = 20,
--   virtual_text = true,
-- },
-- finder_definition_icon = '  ',
-- finder_reference_icon = '  ',
-- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
-- finder_action_keys = {
--   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
-- },
-- code_action_keys = {
--   quit = 'q',exec = '<CR>'
-- },
-- rename_action_keys = {
--   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
-- },
-- definition_preview_icon = '  '
-- 1: thin border | 2: rounded border | 3: thick border | 4: ascii border
-- border_style = 1
-- rename_prompt_prefix = '➤',
-- if you don't use nvim-lspconfig you must pass your server name and
-- the related filetypes into this table
-- like server_filetype_map = {metals = {'sbt', 'scala'}}
-- server_filetype_map = {}

-- saga.init_lsp_saga {
-- }

--use default config
saga.init_lsp_saga()


-- key mappings

vim.api.nvim_set_keymap('n', '<leader>lI', ':LspInfo<CR>', { noremap = true , silent = true })
vim.api.nvim_set_keymap('n', '<leader>ll', ':Lspsaga lsp_finder<CR>', { noremap = true , silent = true })
vim.api.nvim_set_keymap('n', '<leader>la', ':Lspsaga code_action<CR>', { noremap = true , silent = true })
vim.api.nvim_set_keymap('n', '<leader>lA', ':Lspsaga range_code_action<CR>', { noremap = true , silent = true })
---- vim.api.nvim_buf_set_keymap(0, 'n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', { noremap = true , silent = true })
---- vim.api.nvim_buf_set_keymap(0, 'v', '<leader>lf', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', { noremap = true , silent = true })
