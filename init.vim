" vim: fdm=marker foldlevel=0 foldenable sw=2 ts=2 sts=2
"----------------------------------------------------------------------------------------
"     _   ____________ _    ________  ___   __________  _   __________________
"    / | / / ____/ __ \ |  / /  _/  |/  /  / ____/ __ \/ | / / ____/  _/ ____/
"   /  |/ / __/ / / / / | / // // /|_/ /  / /   / / / /  |/ / /_   / // / __
"  / /|  / /___/ /_/ /| |/ // // /  / /  / /___/ /_/ / /|  / __/ _/ // /_/ /
" /_/ |_/_____/\____/ |___/___/_/  /_/   \____/\____/_/ |_/_/   /___/\____/
"
"----------------------------------------------------------------------------------------

" general settings {{{

" Always support UTF-8
set encoding=utf-8 fileencoding=utf-8 fileencodings=utf-8

" I'll handle backups myself, thank you
set noswapfile nobackup nowritebackup

" More modern view
set cmdheight=2            " give more space for displaying messages
set noshowcmd              " don't show last command
set wildmode=longest,list  " get bash-like tab completions
set shortmess+=c           " don't pass messages to |ins-completion-menu|.

" searching
set incsearch
set nohlsearch             " highlight search results
set inccommand=nosplit     " THIS IS AMAZING! :O
set gdefault               " by default, swap out all instances in a line

set signcolumn=yes
set updatetime=520

set number relativenumber

" }}}
"
" vscode emulation {{{
"
" asvetliakov/vscode-neovim
"
if exists('g:vscode')
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
 command! GStatus            call VSCodeNotify('magit.status')
 command! GCommit            call VSCodeNotify('extension.conventionalCommits')
 command! BToggle            call VSCodeNotify('bookmarks.toggle')

 command! BToggle            call VSCodeNotify('bookmarks.toggle')
 command! BAnnotate          call VSCodeNotify('bookmarks.toggleLabeled')
 command! BList              call VSCodeNotify('bookmarks.listFromAllFiles')
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

" }}}

" load lua-based configs {{{
else

lua require('config')
autocmd BufWritePost plugins.lua PackerCompile

endif
" }}}

"----------------------------------------------------------------------------------------
