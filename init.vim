
" encodings
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" no more swap files
set noswapfile
set nobackup
set nowritebackup

set cmdheight=2              " Give more space for displaying messages
set noshowcmd                " don't show last command
set wildmode=longest,list    " get bash-like tab completions

set clipboard+=unnamedplus   " map nvim clipboard to system clipboard
set ffs=unix,dos,mac         " Unix as standard file type
set updatetime=100           " faster, faster, faster!
set autoread                 " automatically reload file when underlying files change
set mouse=a                  " sometimes helpful
set secure                   " disallows :autocmd, shell + write commands in local .vimrc
set showmatch                " Show matching brackets

set shortmess+=c             " don't pass messages to |ins-completion-menu|.

" searching
set nohlsearch               " highlight search results
set inccommand=nosplit       " THIS IS AMAZING! :O
set gdefault                 " by default, swap out all instances in a line

let mapleader = "\<SPACE>"
set encoding=utf-8
set fileencodings=utf-8

if exists('g:vscode')
	xmap gc  <Plug>VSCodeCommentary
	nmap gc  <Plug>VSCodeCommentary
	omap gc  <Plug>VSCodeCommentary
	nmap gcc <Plug>VSCodeCommentaryLine

	nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
	xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
	nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
	xnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
	nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
	xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
	nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
	xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>

	nnoremap ; :
	vnoremap ; :

	xmap cm  <Plug>VSCodeCommentary
	nmap cm  <Plug>VSCodeCommentary
	omap cm  <Plug>VSCodeCommentary
	nmap cml <Plug>VSCodeCommentaryLine

	command! Rg call VSCodeNotify('extension.ripgrep')
	command! Fix call VSCodeNotify('keyboard-quickfix.openQuickFix')
	command! Reload call VSCodeNotify('workbench.action.reloadWindow')
	command! Qwindow call VSCodeNotify('workbench.action.closeWindow')
	command! GStatus call VSCodeNotify('magit.status')
	command! GCommit call VSCodeNotify('extension.conventionalCommits')
	command! Sidebar call VSCodeNotify('multiCommand.toggleSidebar')

	nmap <silent> <BS> :Find<CR>
	nmap <silent> <Tab> :tabn<CR>
	nmap <silent> <S-Tab> :tabp<CR>

	" Redo with U instead of Ctrl+R
	noremap U <C-R

	" Quick get that register!
	nnoremap Q @q
	vnoremap Q :normal @q

	AlterCommand o[pen] Find

	" let mapleader = "\<SPACE>"
	nnoremap <space> :call VSCodeNotify('whichkey.show')<cr>
else
	lua require('plugins')
	lua require('init')
endif
