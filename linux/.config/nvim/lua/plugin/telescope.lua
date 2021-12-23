-- vim:set ft=lua et sts=2 ts=2 sw=2 tw=78:

local actions = require("telescope.actions")
require("telescope").load_extension("media_files")
require("telescope").setup {
  defaults = {
    vimgrep_arguments = {
      "rg",
      -- "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case"
    },
    prompt_position = "bottom",
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_defaults = {
      horizontal = {
        mirror = false
      },
      vertical = {
        mirror = false
      }
    },
    file_sorter = require "telescope.sorters".get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require "telescope.sorters".get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
    color_devicons = true,
    use_less = true,
    set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
    file_previewer = require "telescope.previewers".vim_buffer_cat.new,
    grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new,
    qflist_previewer = require "telescope.previewers".vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require "telescope.previewers".buffer_previewer_maker,
    mappings = {
      i = {
        -- To disable a keymap, put [map] = false
        -- So, to not map "<C-n>", just put
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<c-x>"] = false,
        -- Otherwise, just set the mapping to the function that you want it to be.
        ["<C-i>"] = actions.select_horizontal,
        -- Add up multiple actions
        ["<CR>"] = actions.select_default + actions.center
        -- You can perform as many actions in a row as you like
        -- ["<CR>"] = actions.select_default + actions.center +
        --   my_cool_custom_action
      },
      n = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        -- ["<C-i>"] = my_cool_custom_action
      }
    },
    extensions = {
      media_files = {
        -- filetypes whitelist
        -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
        filetypes = {"png", "webp", "jpg", "jpeg"},
        find_cmd = "rg" -- find command (defaults to `fd`)
      }
    }
  }
}






-- key binding

vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fb", ":Telescope buffers<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fh", ":Telescope help_tags<cr>", { noremap = true })


vim.api.nvim_set_keymap(
  "n",
  "<leader>lo",
  ":Telescope lsp_document_symbols<CR>",
  {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>lS",
  ":Telescope lsp_workspace_symbols<CR>",
  {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>lQ",
  ":Telescope quickfix<CR>",
  {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>le",
  -- ":Telescope lsp_document_diagnostics<CR>",
  ":Telescope diagnostics bufnr=0<CR>",
  {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>lE",
  ":Telescope lsp_workspace_diagnostics<CR>",
  {noremap = true, silent = true}
)

