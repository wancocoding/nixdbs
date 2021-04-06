-- set option
--   vim.api.nvim_set_option('selection', 'exclusive')
--   or
--   vim.o.smarttab = false
-- set variables
-- vim.g.{name}: 全局变量
-- vim.b.{name}: 缓冲区变量
-- vim.w.{name}: 窗口变量
-- vim.t.{name}: 选项卡变量
-- vim.v.{name}: 预定义变量

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"

-- clipboard
vim.cmd("set clipboard+=unnamed")

-- Fix backspace indent
vim.o.backspace = "indent,eol,start"


-- do not keep a backup file, use versions instead
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false


--  undo and history
vim.o.history = 700
vim.o.undolevels = 700

-- tab settings
vim.o.smarttab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.shiftround = true

-- indent settings
vim.o.autoindent = true
vim.o.smartindent = true

-- auto read when file is changed from outside
vim.o.autoread = true
vim.cmd("set wildignore=*.o,*.class,*.pyc")
vim.cmd("set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite")

-- Searching
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- disable sound on errors
vim.o.errorbells = false
vim.o.visualbell = false

-- Time in milliseconds to wait for a mapped sequence to complete.
vim.o.tm = 500

-- command completion like zsh
vim.o.wildmenu = true
vim.o.wildmode = "full"

-- completion add dictionary
vim.cmd("set complete+=k")
vim.cmd("set dictionary+=/usr/share/dict/words")

-- hidden ,switch unsaved file witout warnning
vim.o.hidden = true

-- always enable statusline
vim.o.laststatus = 2

-- fold settings, use marker, you can use fdm=marker in you  modeline
-- vim.cmd("set foldmethod=marker")

-- show command in the last line of screen
vim.o.showcmd = true
