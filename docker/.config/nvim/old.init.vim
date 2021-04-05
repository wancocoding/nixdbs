" vim:set ft=vim et sts=4 ts=4 sw=4 fdm=marker tw=78:
"     ______                     ___                _    ___         
"    / ____/___  _________  ____/ (_)___  ____ _   | |  / (_)___ ___ 
"   / /   / __ \/ ___/ __ \/ __  / / __ \/ __ `/   | | / / / __ `__ \
"  / /___/ /_/ / /__/ /_/ / /_/ / / / / / /_/ /    | |/ / / / / / / /
"  \____/\____/\___/\____/\__,_/_/_/ /_/\__, /     |___/_/_/ /_/ /_/ 
"                                      /____/                        
"
" Maintainer:           Vincent Wancocoding  <https://cocoding.cc>
" Email:                ergal@163.com
" NeoVim Version:       0.5
" Version:              0.1.2
" Created:              2021-03-26
" Updated:              2021-03-31
" OS:                   Ubuntu 20.04 LTS in Docker

"*****************************************************************************
" NeoVim api Setup {{{
"*****************************************************************************
let g:python3_host_prog='/home/linuxbrew/.linuxbrew/bin/python3'
let g:ruby_host_prog='/home/linuxbrew/.linuxbrew/bin/ruby'
let g:node_host_prog='/home/linuxbrew/.linuxbrew/lib/node_modules/neovim/bin/cli.js'

" }}}


"*****************************************************************************
"" Basic Setup {{{
"*****************************************************************************

" Required:
filetype plugin indent on

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,chinese,latin-1,gbk,gb18030,gk2312
set ttyfast

" path
" set path+=**

" set clipboard
set clipboard+=unnamed

" set leader
let mapleader = " "
let g:mapleader = " "

" Fix backspace indent
set backspace=indent,eol,start          " allow backspacing over everything in insert mode  ,set bs=2  have the same effect

" Use modeline overrides
set modeline
set modelines=5

" do not keep a backup file, use versions instead
set nobackup
set nowritebackup
set noswapfile

" undo and history
set history=700
set undolevels=700

" tab settings
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround

" indent settings
set autoindent
set smartindent

" auto read when file is changed from outside
set autoread
set wildignore=*.o,*.class,*.pyc
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" disable sound on errors
if has("gui_running")
    " Disable visualbell
    set noerrorbells visualbell t_vb=
    if has('autocmd')
        autocmd GUIEnter * set visualbell t_vb=
    endif
endif
set noerrorbells
set novisualbell
set t_vb=
set tm=1000

" command completion like zsh
set wildmenu
set wildmode=full

" set dictionary
set complete+=k
if has('win32')
  set dictionary+=c:\Users\oherg\vimfiles\dictionary\words.txt
else
  set dictionary+=/usr/share/dict/words
  set dictionary+=~/.local/share/dict/words
endif

" shortmess, the default is filnxtToOIcS, see :h shortmess
set shm-=S

" Enable hidden buffers
set hidden

" display incomplete commands
set showcmd

" session management
let g:session_directory = "~/.config/nvim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1


" }}}


"*****************************************************************************
"" Vim-Plug core {{{
"*****************************************************************************
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

" }}}


"*****************************************************************************
"" Plug install packages {{{
"*****************************************************************************

" ============  theme
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
Plug 'drewtempelmeyer/palenight.vim'

" ============  status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" ============ Explorer
" Plug 'preservim/nerdtree'
" Plug 'ryanoasis/vim-devicons'
" defx
" Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'


" ============ Fuzzy Finder
" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" ============  Language Support
" View and search LSP symbols, tags in Vim/NeoVim, replace tagbar
Plug 'liuchengxu/vista.vim'

" ============  Snippets Support
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

" ============  Git Plugin
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" ============  Misc 
Plug 'mhinz/vim-startify'
" Comment Plugin
Plug 'tpope/vim-commentary'
" align tools
Plug 'godlygeek/tabular' 
" parentheses, brackets, quotes, XML tags
Plug 'tpope/vim-surround'

"" Include user's extra bundle
if filereadable(expand("~/.config/nvim/local_bundles.vim"))
  source ~/.config/nvim/local_bundles.vim
endif

" Neovim LSP support 0.5
" if has('nvim-0.5')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
" endif

call plug#end()

" }}}


"*****************************************************************************
" Appearance(Color , theme , StatusLine) {{{
"*****************************************************************************

syntax enable
syntax on
"
" Maximum width of text that is being inserted
set tw=79
" display a column line
set colorcolumn=+1
" Show tabs as CTRL-I is displayed, display $ after end of line
set list
" listchar
set listchars=tab:▸\ ,eol:¬,trail:·,precedes:←,extends:→

" show the cursor position all the time
set ruler

" set nu                                  " number line
let no_buffers_menu=1

" colorscheme
set background=dark
colorscheme palenight
set cursorline
" let g:gruvbox_contrast_dark="hard"
" colorscheme gruvbox

if has("gui_running")
	" hide menu and toolbar
	set guioptions-=m
	set guioptions-=T
	" fix cursor on linux gvim
	set guioptions-=l
	set guioptions-=L
	set guioptions-=r
	set guioptions-=R

	" font
	set guifont=Fira\ Code\ weight=453\ 10
endif

if (has('termguicolors'))
  set termguicolors
endif

" }}}


"*****************************************************************************
" Abbreviations {{{
"*****************************************************************************

" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" }}}


"*****************************************************************************
" Mappings {{{
"*****************************************************************************
"" Split
" noremap <Leader>h :<C-u>split<CR>
" noremap <Leader>v :<C-u>vsplit<CR>

"" Git
" noremap <Leader>ga :Gwrite<CR>
" noremap <Leader>gc :Gcommit<CR>
" noremap <Leader>gsh :Gpush<CR>
" noremap <Leader>gll :Gpull<CR>
" noremap <Leader>gs :Gstatus<CR>
" noremap <Leader>gb :Gblame<CR>
" noremap <Leader>gd :Gvdiff<CR>
" noremap <Leader>gr :Gremove<CR>

" session management
" nnoremap <leader>so :OpenSession<Space>
" nnoremap <leader>ss :SaveSession<Space>
" nnoremap <leader>sd :DeleteSession<CR>
" nnoremap <leader>sc :CloseSession<CR>

"" Tabs
" nnoremap <Tab> gt
" nnoremap <S-Tab> gT
" nnoremap <silent> <S-t> :tabnew<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>:pwd<CR>

"" Clean search (highlight)
nnoremap <silent> <leader>nh :noh<CR>

" Better copy & paste
:set pastetoggle=<F5>

"" Disable arrowkeys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" center search results
nnoremap n nzvzz
nnoremap N Nzvzz
nnoremap * *zvzz
nnoremap # #zvzz




" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>


" Use <leader>Esc to leave terminal mode
tnoremap <leader><Esc> <C-\><C-n>

" tab settings
noremap <A-1> 1gt
noremap <A-2> 2gt
noremap <A-3> 3gt
noremap <A-4> 4gt
noremap <A-5> 5gt
noremap <A-6> 6gt
noremap <A-7> 7gt
noremap <A-8> 8gt
noremap <A-9> :tablast<cr>
noremap <A-0> :tabfirst<cr>

" windows resize
:nnoremap <silent> <Up> :resize -1<CR>
:nnoremap <silent> <Down> :resize +1<CR>
:nnoremap <silent> <left> :vertical resize -1<CR>
:nnoremap <silent> <right> :vertical resize +1<CR>

" }}}


"*****************************************************************************
" Netrw {{{
"*****************************************************************************

let g:netrw_banner = 0
" let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20

" }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline theme
" let g:airline_theme='gruvbox'

" let g:airline_theme = 'powerlineish'
let g:airline_theme = 'palenight'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1


" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

" fix the command mode in the status line now show in vim"
if !has('nvim')
  au CmdLineEnter * redraws
endif

" }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vista settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

nmap <F8> :Vista!!<CR>

" }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NerdTree {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " custom ignore
" let g:NERDTreeIgnore=['\.class$', '\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']

" let g:NERDTreeChDirMode=2
" let g:NERDTreeShowBookmarks=1
" let g:nerdtree_tabs_focus_on_files=1
" let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
" " show line number
" let NERDTreeShowLineNumbers=0
" " show hidden file
" let NERDTreeShowHidden=0
" " set width
" let NERDTreeWinSize=35

" nnoremap <silent> <F2> :NERDTreeFind<CR>
" nnoremap <silent> <F3> :NERDTreeToggle<CR>

" " auto open nerdtree when open a dir
" " autocmd StdinReadPre * let s:std_in=1
" " autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" defx {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" call defx#custom#option('_', {
"       \ 'winwidth': 40,
"       \ 'split': 'vertical',
"       \ 'direction': 'topleft',
"       \ 'show_ignored_files': 0,
"       \ 'columns': 'icons:indent:filename:type',
"       \ 'buffer_name': '',
"       \ 'toggle': 1,
"       \ 'resume': 1
"       \ })

" nnoremap <silent> <F3> :Defx <cr>
" autocmd FileType defx call s:defx_my_settings()

" function! s:defx_my_settings() abort
"     " Define mappings
"     nnoremap <silent><buffer><expr> <CR>
"     \ defx#do_action('open')
"     nnoremap <silent><buffer><expr> c
"     \ defx#do_action('copy')
"     nnoremap <silent><buffer><expr> m
"     \ defx#do_action('move')
"     nnoremap <silent><buffer><expr> p
"     \ defx#do_action('paste')
"     nnoremap <silent><buffer><expr> l
"     \ defx#do_action('open')
"     nnoremap <silent><buffer><expr> E
"     \ defx#do_action('open', 'vsplit')
"     nnoremap <silent><buffer><expr> P
"     \ defx#do_action('preview')
"     nnoremap <silent><buffer><expr> o
"     \ defx#do_action('open_tree', 'toggle')
"     nnoremap <silent><buffer><expr> K
"     \ defx#do_action('new_directory')
"     nnoremap <silent><buffer><expr> N
"     \ defx#do_action('new_file')
"     nnoremap <silent><buffer><expr> M
"     \ defx#do_action('new_multiple_files')
"     nnoremap <silent><buffer><expr> C
"     \ defx#do_action('toggle_columns',
"     \                'mark:indent:icon:filename:type:size:time')
"     nnoremap <silent><buffer><expr> S
"     \ defx#do_action('toggle_sort', 'time')
"     nnoremap <silent><buffer><expr> d
"     \ defx#do_action('remove')
"     nnoremap <silent><buffer><expr> r
"     \ defx#do_action('rename')
"     nnoremap <silent><buffer><expr> !
"     \ defx#do_action('execute_command')
"     nnoremap <silent><buffer><expr> x
"     \ defx#do_action('execute_system')
"     nnoremap <silent><buffer><expr> yy
"     \ defx#do_action('yank_path')
"     nnoremap <silent><buffer><expr> .
"     \ defx#do_action('toggle_ignored_files')
"     nnoremap <silent><buffer><expr> ;
"     \ defx#do_action('repeat')
"     nnoremap <silent><buffer><expr> h
"     \ defx#do_action('cd', ['..'])
"     nnoremap <silent><buffer><expr> ~
"     \ defx#do_action('cd')
"     nnoremap <silent><buffer><expr> q
"     \ defx#do_action('quit')
"     nnoremap <silent><buffer><expr> <Space>
"     \ defx#do_action('toggle_select') . 'j'
"     nnoremap <silent><buffer><expr> *
"     \ defx#do_action('toggle_select_all')
"     nnoremap <silent><buffer><expr> j
"     \ line('.') == line('$') ? 'gg' : 'j'
"     nnoremap <silent><buffer><expr> k
"     \ line('.') == 1 ? 'G' : 'k'
"     nnoremap <silent><buffer><expr> <C-l>
"     \ defx#do_action('redraw')
"     nnoremap <silent><buffer><expr> <C-g>
"     \ defx#do_action('print')
"     nnoremap <silent><buffer><expr> cd
"     \ defx#do_action('change_vim_cwd')
" endfunction

" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim-tree.lua {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:nvim_tree_side = 'left' "left by default
let g:nvim_tree_width = 40 "30 by default
let g:nvim_tree_ignore = [ '.cache' ] "empty by default
let g:nvim_tree_gitignore = 2 "0 by default
let g:nvim_tree_auto_open = 1 "0 by default, opens the tree when typing `vim $DIR` or `vim`
let g:nvim_tree_auto_close = 1 "0 by default, closes the tree when it's the last window
let g:nvim_tree_auto_ignore_ft = ['startify', 'dashboard'] "empty by default, don't auto open tree on specific filetypes.
let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
let g:nvim_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_hide_dotfiles = 1 "0 by default, this option hides files and folders starting with a dot `.`
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_tab_open = 1 "0 by default, will open the tree when entering a new tab and the tree was previously open
let g:nvim_tree_width_allow_resize  = 1 "0 by default, will not resize the tree when opening a file
let g:nvim_tree_disable_netrw = 1 "1 by default, disables netrw
let g:nvim_tree_hijack_netrw = 1 "1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
let g:nvim_tree_add_trailing = 0 "0 by default, append a trailing slash to folder names
let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★"
    \   },
    \ 'folder': {
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   }
    \ }

nnoremap <silent> <F3> :NvimTreeToggle<CR>
" nnoremap <leader>r :NvimTreeRefresh<CR>
" nnoremap <leader>n :NvimTreeFindFile<CR>


" NvimTreeOpen and NvimTreeClose are also available if you need them

set termguicolors " this variable must be enabled for colors to be applied properly

" a list of groups can be found at `:help nvim_tree_highlight`
" highlight NvimTreeFolderIcon guibg=blue

" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" startify {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" session
if has('win32')
  let g:startify_session_dir = '~\vimfiles/startify_session'
else
  let g:startify_session_dir = '~/.config/nvim/startify_session'
endif

" auto update session
let g:startify_session_persistence = 1

let g:startify_lists = [
         \ { 'type': 'files',     'header': ['   Files']            },
         \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
         \ { 'type': 'sessions',  'header': ['   Sessions']       },
         \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
         \ ]

if has('win32')
  let g:startify_bookmarks = [
    \ { 'i': '~\_vimrc' },
    \ { 'z': '~\.zshrc' },
    \ { 'd': 'd:\develop\workspace'},
    \ { 'n': 'f:\Dropbox\Dropbox\docs\md\notes' },
    \ ]
else
  let g:startify_bookmarks = [
    \ { 'i': '~/.vimrc' },
    \ { 'z': '~/.zshrc' },
    \ { 'd': '~/develop/workspace'},
    \ { 'n': '~/.config/nvim/init.vim' },
    \ ]
endif

" }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number 
    \ --no-heading --color=always --smart-case " .
    \ <q-args>, 1, <bang>0)
nnoremap <Leader>o :Files<CR>
nnoremap <Leader>p :Buffers<CR>
nnoremap <Leader>h :History<CR>

" Mapping selecting mappings
" nmap <leader><tab> <plug>(fzf-maps-n)
" xmap <leader><tab> <plug>(fzf-maps-x)
" omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" use tmux window
" if exists('$TMUX')
"   let g:fzf_layout = { 'tmux': '-p90%,60%' }
" else
"   let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" endif

" }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnips {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neovim 0.5 LSP {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('nvim-0.5')
" " completion settings
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
luafile ~/.config/nvim/lua/lsp-config.lua
endif
" }}}
