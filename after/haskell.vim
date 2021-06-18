let g:haskell_indent_do    = 3
let g:haskell_indent_if    = 3
let g:haskell_indent_in    = 1
let g:haskell_indent_let   = 4
let g:haskell_indent_case  = 2
let g:haskell_indent_where = 6

let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" Background process and window management
nnoremap <silent> <localleader>is :InteroStart<CR>
nnoremap <silent> <localleader>ik :InteroKill<CR>

" Open intero/GHCi split horizontally
nnoremap <silent> <localleader>io :InteroOpen<CR>
" Open intero/GHCi split vertically
nnoremap <silent> <localleader>iov :InteroOpen<CR><C-W>H
nnoremap <silent> <localleader>ih :InteroHide<CR>

" Reloading (pick one)
" Automatically reload on save
au BufWritePost *.hs InteroReload
" Manually save and reload
nnoremap <silent> <localleader>wr :w \| :InteroReload<CR>

" Load individual modules
nnoremap <silent> <localleader>il :InteroLoadCurrentModule<CR>
nnoremap <silent> <localleader>if :InteroLoadCurrentFile<CR>

" Type-related information
" Heads up! These next two differ from the rest.
map <silent> <localleader>t <Plug>InteroGenericType
map <silent> <localleader>T <Plug>InteroType
nnoremap <silent> <localleader>it :InteroTypeInsert<CR>

" Navigation
nnoremap <silent> <localleader>jd :InteroGoToDef<CR>

" Managing targets
" Prompts you to enter targets (no silent):
nnoremap <localleader>ist :InteroSetTargets<SPACE>

" Intero starts automatically. Set this if you'd like to prevent that.
let g:intero_start_immediately = 0

" Enable type information on hover (when holding cursor at point for ~1 second).
let g:intero_type_on_hover = 1

" Change the intero window size; default is 10.
let g:intero_window_size = 15

" Sets the intero window to split vertically; default is horizontal
let g:intero_vertical_split = 1

" OPTIONAL: Make the update time shorter, so the type info will trigger faster.
set updatetime=1000

setlocal commentstring=--\
