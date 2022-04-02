" vim:set et sts=4 sw=4 ts=4 tw=78 fdm=marker ft=vim:
"     ______                     ___                _    ___         
"    / ____/___  _________  ____/ (_)___  ____ _   | |  / (_)___ ___ 
"   / /   / __ \/ ___/ __ \/ __  / / __ \/ __ `/   | | / / / __ `__ \
"  / /___/ /_/ / /__/ /_/ / /_/ / / / / / /_/ /    | |/ / / / / / / /
"  \____/\____/\___/\____/\__,_/_/_/ /_/\__, /     |___/_/_/ /_/ /_/ 
"                                      /____/                        
"
" Maintainer:         Vincent Wancocoding  <https://cocoding.cc>
" Vim Version:                                             8.2.4
" Created:                                            2021-01-05
" Updated:                                            2022-04-02



"*****************************************************************************
"" Plugin Setup {{{
"*****************************************************************************
let vimplug_exists=expand('~/.vim/autoload/plug.vim')

if !filereadable(vimplug_exists)
    echo "Installing Vim-Plug..."
    echo ""
    let s:vim_plug_url='https://ghproxy.com/https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . s:vim_plug_url
    " autocmd VimEnter * PlugInstall
endif

call plug#begin(expand('~/.vim/plugged'))
"
" ====== themes ======
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'drewtempelmeyer/palenight.vim'


call plug#end()

function! PlugLoaded(name)
    if exists("g:plugs")
        if has_key(g:plugs, a:name)
            if g:plugs[a:name].dir[-1:] == '/'
                return (
                    \ isdirectory(g:plugs[a:name].dir) &&
                    \ stridx(&rth, g:plugs[a:name].dir[:-2]) >= 0)
            else
                return (
                    \ isdirectory(g:plugs[a:name].dir) &&
                    \ stridx(&rth, g:plugs[a:name]) >= 0)

            endif
        end
    endif
    return 0
endfunction

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

" set clipboard
set clipboard+=unnamed

" mouse
set mouse=a

" set leader
let mapleader = ","
let g:mapleader = ","

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


" comletion for nvim-com 
set completeopt=menu,menuone,noselect
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
" set colorcolumn=80

" Show tabs as CTRL-I is displayed, display $ after end of line
" set list
" listchar
" set listchars=tab:▸\ ,eol:¬,trail:·,precedes:←,extends:→

" show the cursor position all the time
set ruler

" set nu                                  " number line
let no_buffers_menu=1

" colorscheme
set background=dark
" set cursorline

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" === gruvbox ===
" let g:gruvbox_contrast_dark="hard"
" colorscheme gruvbox
" === molokai ===
if PlugLoaded('molokai')
    colorscheme molokai
endif
" === palenight ===
" colorscheme palenight

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






autocmd FileType coffee,html,css,xml,yaml,json set sw=2 ts=2
