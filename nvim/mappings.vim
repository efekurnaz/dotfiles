" nnoremap normal mode
" inoremap insert mode
" vnoremap visual mode
" leader is \

" press spacebar to type : in command mode
nnoremap <space> :

" Find filename in git files
nmap <C-P> :GFiles<CR>

" Find text in git files
nmap <C-E> :Rg<CR>

" move among buffers with CTRL
nmap <C-K> :bnext<CR>
nmap <C-J> :bprev<CR>
" close buffer
nmap <C-Q> :bd<CR>

" remove search highlighting on escape
nnoremap <esc> :noh<return><esc> 
nnoremap c "_c
xnoremap <leader>d "_d
xnoremap <leader>p "_dP
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
