" vim:set et sts=4 sw=4 ts=4 tw=78 fdm=marker ft=vim:
"     ______                     ___                _    ___         
"    / ____/___  _________  ____/ (_)___  ____ _   | |  / (_)___ ___ 
"   / /   / __ \/ ___/ __ \/ __  / / __ \/ __ `/   | | / / / __ `__ \
"  / /___/ /_/ / /__/ /_/ / /_/ / / / / / /_/ /    | |/ / / / / / / /
"  \____/\____/\___/\____/\__,_/_/_/ /_/\__, /     |___/_/_/ /_/ /_/ 
"                                      /____/                        
"
" Maintainer:         Vincent Wancocoding  <https://cocoding.cc>
" NeoVim Version:                                          0.4.4
" Version:                                                 0.1.1
" Created:                                            2021-01-05
" Updated:                                            2021-01-05
" OS:                                                   Win10 64


"*****************************************************************************
"" NeoVim Settings for Language {{{
"*****************************************************************************

let g:python3_host_prog='d:\develop\apps\scoop\apps\python38\current\python.exe'
let g:ruby_host_prog='d:\develop\apps\scoop\apps\ruby\current\bin\ruby.exe'
let g:node_host_prog='d:\develop\apps\scoop\persist\nodejs-lts\bin\node_modules\neovim\bin\cli.js'

" }}}

"*****************************************************************************
"" Plug install packages {{{
"*****************************************************************************
" Required:
call plug#begin('~/AppData/Local/nvim/plugged')

" ======  themes ======
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'

" ====== Snippets Support ======
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

call plug#end()

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
endif

" shortmess, the default is filnxtToOIcS, see :h shortmess
set shm-=S

" Enable hidden buffers
set hidden

" display incomplete commands
set showcmd

" }}}

"*****************************************************************************
"" Appearance(Color , theme , StatusLine) {{{
"*****************************************************************************

syntax enable
syntax on
"
" Maximum width of text that is being inserted
set tw=79
" display a column line
set colorcolumn=80
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
set cursorline

" let g:gruvbox_contrast_dark="hard"
" colorscheme gruvbox
colorscheme molokai

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

" }}}

"*****************************************************************************
"" Abbreviations {{{
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
"" Mappings {{{
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
"" Netrw {{{
"*****************************************************************************

let g:netrw_banner = 0
" let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20

" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" UltiSnips {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" }}}

