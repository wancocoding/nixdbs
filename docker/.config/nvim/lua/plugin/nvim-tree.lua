-- vim:set ft=lua et sts=4 ts=4 sw=4 tw=78:
vim.g.nvim_tree_site = 'left'
vim.g.nvim_tree_width = 40
vim.g.nvim_tree_ignore = { '.cache' }
vim.g.nvim_tree_gitignore = 2
vim.g.nvim_tree_auto_open = 0
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_auto_ignore_ft = { 'startify', 'dashboard' }
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_hide_dotfiles = 0
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_root_folder_modifier = '=~'
vim.g.nvim_tree_tab_open = 1
vim.g.nvim_tree_width_allow_resize  = 1
vim.g.nvim_tree_disable_netrw = 1
vim.g.nvim_tree_hijack_netrw = 1
vim.g.nvim_tree_add_trailing = 0
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_show_icons = { git = 1, folders = 1, files = 1 }
vim.g.nvim_tree_icons = {
  default= '.',
  symlink= '',
  git= {
    unstaged= "✗",
    staged= "✓",
    unmerged= "",
    renamed= "➜",
    untracked= "★"
  },
  folder= {
    default= "",
    open= "",
    empty= "",
    empty_open= "",
    symlink= "",
    symlink_open= "",
  }
}

vim.api.nvim_set_keymap(
    "n",
    "<F3>",
    ":NvimTreeToggle<CR>",
    {
        noremap = true,
        silent = true
    }
)
