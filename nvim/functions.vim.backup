autocmd BufNewFile,BufRead *.js.liquid set filetype=javascript
autocmd BufNewFile,BufRead *.css.liquid set filetype=css
autocmd BufNewFile,BufRead *.scss.liquid set filetype=scss
autocmd BufNewFile,BufRead *.js.liquid set syntax=javascript
autocmd BufNewFile,BufRead *.css.liquid set syntax=css
autocmd BufNewFile,BufRead *.scss.liquid set syntax=scss

" remove trailing spaces on these file types
autocmd FileType css,javascript,html,liquid,json autocmd BufWritePre <buffer> %s/\s\+$//e
