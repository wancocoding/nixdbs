"     ______                     ___                _    ___         
"    / ____/___  _________  ____/ (_)___  ____ _   | |  / (_)___ ___ 
"   / /   / __ \/ ___/ __ \/ __  / / __ \/ __ `/   | | / / / __ `__ \
"  / /___/ /_/ / /__/ /_/ / /_/ / / / / / /_/ /    | |/ / / / / / / /
"  \____/\____/\___/\____/\__,_/_/_/ /_/\__, /     |___/_/_/ /_/ /_/ 
"                                      /____/                        
"
" Maintainer:		Cocoding  <https://cocoding.cc>
" NeoVim Version:	0.4.4
" Version:			0.1
" Created:			2020-10-01
" Updated:			2020-10-05
"
"
" Section:
"		* Init Vim-plug
"		* Plugins
"		* Basic Settings
"		* Appearance(Color , theme , StatusLine)¬
"		* Abbreviations
"		* Commands
"		* Functions
"		* Mappings
"		* PlugSetting NERDTree
"		* PlugSetting airline
"		* PlugSetting tagbar
"		* PlugSetting startify
"		* PlugSetting vim-go
"		* PlugSetting UltiSnips
"
"
"
"
"
"
"*****************************************************************************
"" Vim-Plug core
"*****************************************************************************

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif

let g:vim_bootstrap_langs = "go"
let g:vim_bootstrap_editor = "nvim"				" nvim or vim
let g:vim_bootstrap_theme = "molokai"
let g:vim_bootstrap_frams = ""

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


"*****************************************************************************
"" Plug install packages
"*****************************************************************************
" ============  navigation
Plug 'preservim/nerdtree'

" ============  theme
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'

" ============  status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" ============  Language Support
Plug 'majutsushi/tagbar'
" Plug 'dense-analysis/ale'    " Asynchronous Lint Engine

" ============  Snippets Support
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

" ============  Git Plugin
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'


" ============  Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }


" ============  Misc 
" align tools
Plug 'godlygeek/tabular'   
" Start Screen for vim
Plug 'mhinz/vim-startify'
" Comment Plugin
Plug 'tpope/vim-commentary'


"" Include user's extra bundle
" if filereadable(expand("~/.vimrc.local.bundles"))
"   source ~/.vimrc.local.bundles
" endif

call plug#end()

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"

" Required:
filetype plugin indent on

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

" With a map leader it's possible to do extra key combinations
let mapleader = " "
let g:mapleader = " "

"" Fix backspace indent
set backspace=indent,eol,start          " allow backspacing over everything in insert mode  ,set bs=2  have the same effect

" tab settings
set smarttab                            " insert tabs on the start of a line according to context
set tabstop=4                           " Number of spaces that a <Tab> in the file counts for
set softtabstop=4                       " Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>
set shiftwidth=4                        " Number of spaces to use for each step of (auto)indent
set shiftround

set autoindent                          " auto indentation
set smartindent                         " auto indent for c program

set autoread                            " auto read when file is changed from outside
set wildignore=*.o,*.class,*.pyc        " ignore these files while expanding wild chars
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

" set clipboard for system
set clipboard=unnamed

"" Enable hidden buffers
set hidden

set showcmd                             " display incomplete commands

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=1000

" shell setting
if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" session management
let g:session_directory = "~/.config/nvim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

" do not keep a backup file, use versions instead
set nobackup
set nowritebackup
set noswapfile

set history=700                         " keep 700 lines of command line history
set undolevels=700                      " undo level


"" Use modeline overrides
set modeline
set modelines=10

"" Set the title
set title
set titleold="Terminal"
set titlestring=%F


"*****************************************************************************
"" Appearance(Color , theme , StatusLine)
"*****************************************************************************

syntax enable
syntax on

set ruler                               " show the cursor position all the time

set nu                                  " number line
" set t_Co=256                            " number of colors
if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=7
  endif
else
  let g:CSApprox_loaded = 1

  " IndentLine
  let g:indentLine_enabled = 1
  let g:indentLine_concealcursor = 0
  let g:indentLine_char = '┆'
  let g:indentLine_faster = 1

  
  if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
  else
    if $TERM == 'xterm'
		" Enable true color 启用终端24位色
		if exists('+termguicolors')
			let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
			let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
			set termguicolors
		else
			set term=xterm-256color
		endif
    endif
  endif
endif

" set tw=79                             " Maximum width of text that is being inserted
set colorcolumn=80                      " display a column line

set list                                " Show tabs as CTRL-I is displayed, display $ after end of line
set listchars=tab:▸\ ,eol:¬             " listchar

let no_buffers_menu=1

set background=dark
set cursorline
let g:gruvbox_contrast_dark="hard"
colorscheme gruvbox

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
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


"*****************************************************************************
"" Commands
"*****************************************************************************
" remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e

"*****************************************************************************
"" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

"*****************************************************************************
"" Mappings
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
nnoremap <leader>. :lcd %:p:h<CR>

"" Clean search (highlight)
nnoremap <silent> <leader>nh :noh<CR>

" Better copy & paste
:set pastetoggle=<F5>



"*****************************************************************************
"" Nerdtree
"*****************************************************************************
" custom ignore
let g:NERDTreeIgnore=['\.class$', '\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']

let g:NERDTreeChDirMode=2
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
" 显示行号
let NERDTreeShowLineNumbers=0
" 是否显示隐藏文件
let NERDTreeShowHidden=0
" 设置宽度
let NERDTreeWinSize=35

nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>

" 当打开目录的时候自动打开NERDTree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline theme
" let g:airline_theme='gruvbox'

let g:airline_theme = 'powerlineish'
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tagbar settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


nmap <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" startify
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " session
 let g:startify_session_dir = '~/.config/nvim/startify_session'
 " auto update session
 let g:startify_session_persistence = 1

 let g:startify_lists = [
           \ { 'type': 'files',     'header': ['   Files']            },
           \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
           \ { 'type': 'sessions',  'header': ['   Sessions']       },
           \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
           \ ]

 let g:startify_bookmarks = [
             \ { 'n': '~/Dropbox/docs/md/notes' },
             \ { 'i': '~/.config/nvim/init.vim' },
             \ { 'z': '~/.zshrc' },
             \ { 'd': '~/develop'},
             \ ]


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Golang config (vim-go & coc-go)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
" shortcuts for golang
augroup vim-go
	au!
	autocmd FileType go nmap <leader>b  <Plug>(go-build)
	autocmd FileType go nmap <leader>r  <Plug>(go-run)
	autocmd BufWritePre *.go :call CocAction('organizeImport')
augroup END


" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnips
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add support for markdown files in tagbar.
" see https://github.com/jszakmeister/markdown2ctags
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '~/.config/nvim/scripts/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes --sro=»',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '»',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" statusline bar 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 颜色参考 http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
" function! HasPaste()
"     if &paste
"          return '[PASTE]'
"     else
"         return ''
"     endif
" endfunction
" 
" function! CurDir()
"     let curdir = substitute(getcwd(), $HOME, "~", "")
"     return curdir
" endfunction



" set laststatus=2                        " 始终显示状态栏
" 
" hi StatusLine ctermbg=236 ctermfg=250   cterm=NONE
" 
" set statusline=                         " start
" set statusline+=%1*%{HasPaste()}         " paste
" set statusline+=%3*\[%{mode()}\]        " mode
" set statusline+=%*
" set statusline+=\
" set statusline+=%y                            " filetype
" set statusline+=\                             " blank space
" set statusline+=%m%r%h                        " modified flag [+] [RO] [help]
" set statusline+=\                             " blank space
" set statusline+=\[%<%-10.60(%F%)\]%w
" 
" set statusline+=%=                            " right-align from now on
" 
" " set statusline+=%3*
" set statusline+=\[%{getcwd()}\]                   " show current work dir
" set statusline+=\[%{&fileformat}/%{&encoding}]             " os and filetype
" set statusline+=\[
" set statusline+=%v                            " column number
" set statusline+=\,                            " colon separator
" set statusline+=%l                            " row number
" set statusline+=\]
" set statusline+=\                             " blank space
" set statusline+=%p%%                          " percent
" set statusline+=\-                            " slash separator
" set statusline+=%L                            " total number of rows
" set statusline+=%*
" set statusline+=\                             " blank space
" set statusline+=%{winnr()}                    " buffer number
" 
" " set statusline=\ \ (%f) \ \ \ %m
" " set statusline=\ %1*%{HasPaste()}%*%<%-15.25(%f%)
" " set statusline=\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \
" " set statusline+=\ \ \ [%{&ff}/%Y]
" " set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\
" " set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L
" 
" 
" 
" 
" hi User1 ctermbg=196 ctermfg=015        " 粘贴模式的颜色
" hi User2 ctermbg=236 ctermfg=255
" hi User3 ctermbg=010 ctermfg=255
" hi User4 ctermfg=008
" hi User5 ctermfg=008
" hi User7 ctermfg=008
" hi User8 ctermfg=008
" hi User9 ctermfg=007
" 
" " 另一个方案
" " set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]














