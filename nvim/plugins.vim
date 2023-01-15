call plug#begin()
Plug 'dracula/vim', { 'as': 'dracula' }
"Plug 'edkolev/tmuxline.vim'
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

colorscheme dracula

" === ALVAN/VIM-CLOSETAG
let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.liquid'

" === JIANGMIAO/AUTO-PAIRS
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'
au FileType liquid let b:AutoPairs = AutoPairsDefine({'{%' : '%}', '{{' : '}}'})

" === JUNEGUNN/FZF
" exclude filenames from Rg 
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" === VIM-AIRLINE/VIM-AIRLINE
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

" tmuxline
let g:airline#extensions#tmuxline#enabled = 0
" let g:tmuxline_preset = {
" 			\'a'    : '#S',
" 			\'win'  : '#I  #W',
" 			\'cwin' : '#I  #W',
" 			\'x'    : '%a',
" 			\'y'    : '%Y-%m-%d %H:%M',
" 			\'z'    : ' #h',
" 			\'options' : {'status-justify' : 'left', 'status-position' : 'bottom'}}

" let g:tmuxline_theme = { 'y' : ['#F8F8F3','#6271A4'] }
" let g:tmuxline_theme = {
"     \   'a'    : [ 236, 103 ],
"     \   'b'    : [ 253, 239 ],
"     \   'c'    : [ 244, 236 ],
"     \   'x'    : [ 244, 236 ],
"     \   'y'    : [ 253, 239 ],
"     \   'z'    : [ 236, 103 ],
"     \   'win'  : [ 103, 236 ],
"     \   'cwin' : [ 236, 103 ],
"     \   'bg'   : [ 244, 236 ],
"     \ }

let g:vim_json_conceal=0
let g:markdown_syntax_conceal=0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
set list lcs=tab:\|\ 

lua << EOF
require'lspconfig'.theme_check.setup{}
EOF

"autocmd FileType html,liquid,javascript,css autocmd BufWritePre <buffer> %s/\s\+$//e

source ~/.config/nvim/coc_config.vim
