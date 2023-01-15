if &shell =~# 'fish$'
	set shell=sh
endif

nmap <C-P> :GFiles<CR>
" move among buffers with CTRL
nmap <C-K> :bnext<CR>
nmap <C-J> :bprev<CR>
nmap <C-Q> :bd<CR>
nnoremap <esc> :noh<return><esc> 
nnoremap c "_c
xnoremap <leader>d "_d
xnoremap <leader>p "_dP

call plug#begin()
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'edkolev/tmuxline.vim'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'powerline/powerline-fonts'
Plug 'dkarter/bullets.vim'
Plug 'mg979/vim-visual-multi'
Plug 'preservim/tagbar'
Plug 'ryanoasis/vim-devicons'
Plug 'prettier/vim-prettier'
Plug 'tpope/vim-liquid'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'ThePrimeagen/vim-be-good'
Plug 'junegunn/goyo.vim'
Plug 'mattn/emmet-vim'
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mxw/vim-jsx'
Plug 'yuezk/vim-js'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafOfTree/vim-matchtag'
Plug 'plasticboy/vim-markdown'
Plug 'roxma/vim-tmux-clipboard'
Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}
Plug 'dag/vim-fish'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'haya14busa/is.vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'alvan/vim-closetag'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'fladson/vim-kitty'
call plug#end()

set number
set relativenumber
set autoindent
set tabstop=2
set shiftwidth=2
set smarttab
set softtabstop=2
set mouse=a
set laststatus=2
set encoding=utf-8
set incsearch
set backspace=indent,eol,start
set hidden
set noshowmatch
set noshowmode
set ignorecase
set smartcase
set completeopt=menu,menuone
set nocursorcolumn
set cursorline
set updatetime=300
set pumheight=10
set conceallevel=2
set shortmess+=c
set lazyredraw
set clipboard^=unnamed
set clipboard^=unnamedplus
set t_Co=256
set splitright
set ww+=<,>,h,l " wrap cursor to next/prev line when going left and right
" Don't let Vim's "Found a swap file" message block input
set shortmess=A
" alvan/vim-closetag file extensions to enable
let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.liquid'

autocmd BufNewFile,BufRead *.js.liquid set filetype=javascript
autocmd BufNewFile,BufRead *.css.liquid set filetype=css
autocmd BufNewFile,BufRead *.scss.liquid set filetype=scss
autocmd BufNewFile,BufRead *.js.liquid set syntax=javascript
autocmd BufNewFile,BufRead *.css.liquid set syntax=css
autocmd BufNewFile,BufRead *.scss.liquid set syntax=scss

syntax enable
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

colorscheme dracula

let g:vim_json_conceal=0
let g:markdown_syntax_conceal=0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
set list lcs=tab:\|\ 

"filetype off
filetype plugin indent on

" auto-pairs
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'
au FileType liquid let b:AutoPairs = AutoPairsDefine({'{%' : '%}', '{{' : '}}'})

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tmuxline#enabled = 0
let g:tmuxline_preset = {
			\'a'    : '#S',
			\'win'  : '#I  #W',
			\'cwin' : '#I  #W',
			\'x'    : '%a',
			\'y'    : '%Y-%m-%d %H:%M',
			\'z'    : ' #h',
			\'options' : {'status-justify' : 'left', 'status-position' : 'bottom'}}

let g:tmuxline_theme = { 'y' : ['#F8F8F3','#6271A4'] }
let g:tmuxline_theme = {
    \   'a'    : [ 236, 103 ],
    \   'b'    : [ 253, 239 ],
    \   'c'    : [ 244, 236 ],
    \   'x'    : [ 244, 236 ],
    \   'y'    : [ 253, 239 ],
    \   'z'    : [ 236, 103 ],
    \   'win'  : [ 103, 236 ],
    \   'cwin' : [ 236, 103 ],
    \   'bg'   : [ 244, 236 ],
    \ }

lua << EOF
require'lspconfig'.theme_check.setup{}
EOF

" Remove search highlight
" nnoremap <leader><space> :nohlsearch<CR>
function! s:clear_highlight()
	let @/ = ""
	call go#guru#ClearSameIds()
endfunction
nnoremap <silent> <leader><space> :<C-u>call <SID>clear_highlight()<CR>

" Visual linewise up and down by default (and use gj gk to go quicker)
noremap <Up> gk
noremap <Down> gj
noremap j gj
noremap k gk

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when moving up and down
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

" Press * to search for the term under the cursor for a visual selection and
" then press a key below to replace all instances of it in the current file
nnoremap <leader>r :%s///g<Left><Left>
nnoremap <leader>rc :%s///gc<Left><Left><Left>

" Same like above, but for visally selected characters. Visually select, shift *
" then press a key below to replace all instances of it in the current file
xnoremap <leader>r :s///g<Left><Left>
xnoremap <leader>rc :s///gc<Left><Left><Left>

"autocmd FileType html,liquid,javascript,css autocmd BufWritePre <buffer> %s/\s\+$//e

source ~/.config/nvim/coc_config.vim

" exclude filenames from Rg 
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
