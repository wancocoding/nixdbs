-- vim:set ft=lua et sts=2 ts=2 sw=2 tw=78:

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



-- ==========================
-- provider setting
-- ==========================
-- disable ruby and python2 provider
vim.g.loaded_ruby_provider = 0
-- let g:ruby_host_prog='d:\develop\apps\scoop\apps\ruby\current\bin\ruby.exe'
vim.g.loaded_python_provider = 0

-- python3 provider
vim.g.python3_host_prog='/home/vincent/.pyenv/versions/nvim0.6/bin/python3'

-- nodejs provider
-- let g:node_host_prog='c:\Users\oherg\AppData\Roaming\npm\node_modules\neovim\bin\cli.js'

-- Perl provider
vim.g.loaded_perl_provider = 0
-- vim.g.perl_host_prog = '/path/to/perl'



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
