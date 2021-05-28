" vim: fdm=marker foldlevel=0 foldenable sw=2 ts=2 sts=2
"----------------------------------------------------------------------------------------
" Title:		Neovim configuration
" Author:		Vikram Venkataramanan
" Description:  Should work out of the box on most mac/unix machines
"----------------------------------------------------------------------------------------

set clipboard+=unnamedplus

nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
xnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>


xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

xmap cm  <Plug>VSCodeCommentary
nmap cm  <Plug>VSCodeCommentary
omap cm  <Plug>VSCodeCommentary
nmap cml <Plug>VSCodeCommentaryLine

command! Rg                 call VSCodeNotify('extension.ripgrep')
command! Refactor           call VSCodeNotify('keyboard-quickfix.openQuickFix')
command! Fix                call VSCodeNotify('keyboard-quickfix.openQuickFix')
command! Reload             call VSCodeNotify('workbench.action.reloadWindow')
command! Print              call VSCodeNotify('print-it.PrintIt')
" command! Browse             call VSCodeNotify('file-browser.open')
command! GStatus            call VSCodeNotify('magit.status')
command! GCommit            call VSCodeNotify('extension.conventionalCommits')
command! BToggle            call VSCodeNotify('bookmarks.toggle')

command! BToggle            call VSCodeNotify('bookmarks.toggle')
command! BAnnotate          call VSCodeNotify('bookmarks.toggleLabeled')
command! BList              call VSCodeNotify('bookmarks.listFromAllFiles')
command! Unique             call VSCodeNotify('unique-lines.keepUnique')

command! Unique             call VSCodeNotify('unique-lines.keepUnique')
nmap <silent> <BS> :Find<CR>
nmap <silent> <Tab> :tabn<CR>
nmap <silent> <S-Tab> :tabp<CR>

" Redo with U instead of Ctrl+R
noremap U <C-R>

" Quick get that register!
nnoremap Q @q
vnoremap Q :normal @q

AlterCommand o[pen] Find

let mapleader = "\<SPACE>"

" THEME CHANGER
function! SetCursorLineNrColorInsert(mode)
    " Insert mode: blue
    if a:mode == "i"
        call VSCodeNotify('nvim-theme.insert')

    " Replace mode: red
    " elseif a:mode == "r"
    "     call VSCodeNotify('nvim-theme.replace')
    endif
endfunction


function! SetCursorLineNrColorVisual()
    set updatetime=0
    call VSCodeNotify('nvim-theme.visual')
endfunction

vnoremap <silent> <expr> <SID>SetCursorLineNrColorVisual SetCursorLineNrColorVisual()
nnoremap <silent> <script> v v<SID>SetCursorLineNrColorVisual
nnoremap <silent> <script> V V<SID>SetCursorLineNrColorVisual
nnoremap <silent> <script> <C-v> <C-v><SID>SetCursorLineNrColorVisual

function! SetCursorLineNrColorVisual()
    set updatetime=0
    call VSCodeNotify('nvim-theme.visual')
endfunction

vnoremap <silent> <expr> <SID>SetCursorLineNrColorVisual SetCursorLineNrColorVisual()
nnoremap <silent> <script> v v<SID>SetCursorLineNrColorVisual
nnoremap <silent> <script> V V<SID>SetCursorLineNrColorVisual
nnoremap <silent> <script> <C-v> <C-v><SID>SetCursorLineNrColorVisual


augroup CursorLineNrColorSwap
    autocmd!
    autocmd InsertEnter * call SetCursorLineNrColorInsert(v:insertmode)
    autocmd InsertLeave * call VSCodeNotify('nvim-theme.normal')
    autocmd CursorHold * call VSCodeNotify('nvim-theme.normal')
augroup END
