"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""               
"               
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║     
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"               
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  

" set fish as shell
if &shell =~# 'fish$'
  set shell=sh
endif

" INDENTION OPTIONS
set autoindent                    " new lines inherit the indentation of previous lines
set tabstop=2                     " indent using two spaces
set shiftwidth=2                  " when shifting, indent using two spaces
set smarttab                      " insert 'tabstop' number of spaces when the 'tab' key is pressed
set expandtab                     " converts tabs to spaces
filetype indent on                " enable indentation rules that are file-type specific
set shiftround                    " when shifting lines, round the indentation to the nearest multiple of 'shiftwidth'
let g:html_indent_script1 = 'inc' " indent content inside script tags in html
let g:html_indent_style1 = 'inc'  " indent content inside style tags in html

" SEARCH OPTIONS
set incsearch  " incremental search that shows partial matches
set ignorecase " ignore case when searching
set smartcase  " automatically switch search to case-sensitive when search query contains an uppercase letter.

" PERFORMANCE OPTIONS 
set lazyredraw     " don't update the screen during macro and script execution
set updatetime=300 " default milisecond for swapfile write on idle

" TEXT RENDERING OPTIONS
set display+=lastline " always try to show a paragraph's last line
set encoding=utf-8    " use an encoding that supports unicode
set linebreak         " avoid wrapping a line in the middle of a word
set scrolloff=1       " the number of screen lines to keep above and below the cursor
set sidescrolloff=5   " the number of screen columns to keep to the left and right of the cursor
syntax enable         " enable syntax highlighting
set wrap              " enable line set wrap
set showbreak=>\ \ \  " note trailing space at end of next line
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait100-blinkoff100-blinkon100-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175 " blink cursor on insert and command mode

" USER INTERFACE OPTIONS
set laststatus=2             " always display the status bar
set ruler                    " always show cursor position
set wildmenu                 " display command line's tab complete options as a menu
set wildmode=list:longest    " make wildmenu behave like similar to bash completion
set tabpagemax=50            " maximum number of tab pages that can be opened from the command line
set cursorline               " highlight the line currently under cursor
set nocursorcolumn           " don't highlight the column the cursor is in
set number                   " show line numbers on the sidebar
set relativenumber           " show line number on the current line an drelative numbers on all other lines
set visualbell               " flash the screen instead of beeps
set mouse=a                  " enable mouse for scrolling and resizing
set title                    " set the window's title, reflecting the file currently being edited
set noshowmode               " disable vim mode being displayed on the last line, we are using powerline for this
set completeopt=menu,menuone " show popup menu even when theres one match, hide preview of completion
set pumheight=10             " maximum number of items to show in popup menu
set shortmess+=c             " don't give ins-completion-menu messages
set shortmess+=A             " don't let Vim's 'Found a swap file' message block input
set splitright               " split new window to the right of the current window
set termguicolors            " enable 24-bit RGB color in the terminal ui
set iskeyword-=_             " treat _ as a word boundary
let &t_8f =                  " \<Esc>[38;2;%lu;%lu;%lum"  " fix termgui colors
let &t_8b =                  " \<Esc>[48;2;%lu;%lu;%lum"  " fix termgui colors
set t_Co=16                  " allow color schemes to do bright colors without forcing bold
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+ " make some characters more readable
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx " ignore files we'll never edit with vim

" CODE FOLDING OPTIONS
set foldmethod=indent " fold based on indention levels
set foldnestmax=3     " only fold up to three nested levels
set nofoldenable      " disable folding by default

" MISC OPTIONS
set autoread                   " autoread/load the files changed externally
set backspace=indent,eol,start " allow backspacing over indentation, line breaks and insertion start
set hidden                     " hide files in the background instead of closing them
set noswapfile                 " disable swap files
set noshowmatch                " do not jump to the matching bracket
set clipboard^=unnamed         " use clipboard register * for yank, delete, change and put
set clipboard^=unnamedplus     " use clipboard register + for all expect yank
set ww+=<,>,h,l                " wrap cursor to next/prev line when going left and right


source ~/.config/nvim/plugins.vim   " this script contains plugin specific settings
source ~/.config/nvim/mappings.vim  " this script contains mappings
source ~/.config/nvim/functions.vim " this script contains helper functions

hi Search cterm=NONE ctermbg=blue 

autocmd bufwritepost ~/.config/kitty/kitty.conf :silent !kill -SIGUSR1 $(pgrep kitty)
