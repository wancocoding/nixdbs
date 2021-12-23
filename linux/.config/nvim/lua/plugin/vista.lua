-- vim:set ft=lua et sts=2 ts=2 sw=2 tw=78:

vim.api.nvim_set_keymap(
  "n",
  "<leader>lv",
  "<cmd>Vista!!<CR>",
  {noremap = false, silent = true}
)

