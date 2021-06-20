" vim: fdm=marker foldlevel=0 foldenable sw=2 ts=2 sts=2
"----------------------------------------------------------------------------------------
" general {{{

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
if exists('g:vscode')
" vscode {{{
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
    autocmd CursorHold  * call VSCodeNotify('nvim-theme.normal')
augroup END

" }}}
else
" setup vim-plug {{{
let g:plug_home = stdpath('data') . '/plugged'
call plug#begin(plug_home)
call plug#end()
" }}}
lua require('plugins')
lua require('statusline')
lua require('versionControl')
autocmd BufWritePost plugins.lua PackerCompile
set mouse=a
"
" clipboards {{{
set clipboard+=unnamedplus " map nvim clipboard to system clipboard

" Sync with system clipboard files
if has('macunix') && executable("pbcopy")
    vmap <C-x> :!pbcopy<CR>
    vmap <C-c> :w !pbcopy<CR><cr>
endif
" }}}
" tabs {{{
"
" Set 'tabstop' and 'shiftwidth' to whatever you prefer and use 'expandtab'.
" This way you will always insert spaces. The formatting will never be
" messed up when 'tabstop' is changed.
set expandtab autoindent smartindent

function! SetTabSize(size)
    execute "setlocal tabstop=".a:size
    execute "setlocal shiftwidth=".a:size
endfunction

let g:indentLine_char = '│'

" }}}
" keybindings {{{

" Quickly exit insert mode
ino jj <esc>
cno jj <c-c>

nnoremap ; :
vnoremap ; :

" Easier moving of code blocks
vnoremap <Tab>   >><Esc>gv
vnoremap <S-Tab> <<<Esc>gv

" Quick get that register!
nnoremap Q @q
vnoremap Q :normal @q

" Redo with U instead of Ctrl+R
noremap U <C-R>

" Splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Buffers
nnoremap <S-h> :bprevious<CR>
nnoremap <S-l> :bnext<CR>

" }}}
" bookmarks {{{
let g:bookmark_auto_close = 1
let g:bookmark_sign = '♥'
let g:bookmark_annotation_sign = '☰'


" Shortcuts for frequently accessed files
command! Vimrc e $MYVIMRC
command! Plugins e $XDG_CONFIG_HOME/nvim/lua/plugins.lua
command! Leader e $XDG_CONFIG_HOME/nvim/lua/leaderMappings.lua
command! PU PlugUpdate | PlugUpgrade
command! Reload source $MYVIMRC

if !empty(glob('/Volumes/vikram/planner/app.txt'))
    command! J e /Volumes/vikram/planner/app.txt
endif

if executable('zsh')
    command! Shell e $ZDOTDIR/.zshrc
    command! Env   e $ZDOTDIR/.zshenv
elseif executable('bash')
    command! Shell e $HOME/.bashrc
    command! Env   e $HOME/.profile
endif

if executable('brew')
    command! Brew  e $HOMEBREW_BUNDLE_FILE
endif

if !empty(glob('$XDG_CONFIG_HOME/yadm/bootstrap'))
    command! Yadm  e $XDG_CONFIG_HOME/yadm/bootstrap
elseif !empty(glob('.yadm/bootstrap'))
    command! Yadm  e .yadm/bootstrap
endif

"}}}
" remember position {{{
augroup remember_position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
" }}}
" golang {{{

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
endfunction

let golang_linters = ['gofmt', 'govet']
let golang_key_map = {
\ '\' : ['TestLast', '+rerun_test'],
\ 't' : ['TestNearest', '+test'],
\ 'c' : ['Tags', '+c-tags'],
\ 'i' : ['GoInfo', '+info'],
\ 'l' : ['GoLint', '+lint'],
\ 'r' : ['GoRun', '+run'],
\ 'b' : '+build',
\ 'd' : '+goto_definition',
\ }

augroup golang_settings
autocmd!
autocmd Filetype go nnoremap <buffer> <localleader>b :<C-u>call <SID>build_go_files()<CR>
autocmd Filetype go nnoremap <buffer> <localleader>d :sp <CR>:exe "GoDef"<CR>
augroup END
" }}}
" file associations {{{
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
let g:strip_only_modified_lines=1
let g:better_whitespace_operator='_s'
let g:better_whitespace_filetypes_blacklist=['diff', 'gitcommit', 'unite', 'qf', 'help']



augroup file_associations
  autocmd!
  autocmd BufRead,BufNewFile *.md       setlocal filetype=markdown   syntax =markdown
  autocmd BufRead,BufNewFile *.markdown setlocal filetype=markdown   syntax =markdown

  autocmd BufRead,BufNewFile *.ts       setlocal filetype=typescript syntax =typescript

  autocmd BufRead,BufNewFile *.pgf      setlocal filetype=tex        syntax =tex
  autocmd BufRead,BufNewFile *.tikz     setlocal filetype=tex        syntax =tex
  autocmd BufRead,BufNewFile *.pdf_tex  setlocal filetype=tex        syntax =tex
  autocmd BufRead,BufNewFile .latexmkrc setlocal filetype=perl       syntax =perl

  autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
  autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
augroup END

augroup filetype_settings
  autocmd!
  autocmd Filetype c call SetTabSize(4)

  autocmd Filetype cpp call SetTabSize(4)

  autocmd Filetype go call SetTabSize(4)

  autocmd Filetype make call SetTabSize(8)

  autocmd Filetype markdown setlocal spell nofoldenable nonumber norelativenumber

  autocmd Filetype python call SetTabSize(4)
  autocmd FileType python setlocal textwidth=79 colorcolumn=81

  autocmd Filetype typescript call SetTabSize(2)

  autocmd Filetype vim call SetTabSize(2)
augroup END
" }}}
" typescript {{{
let g:yats_host_keyword = 1

augroup filetype_typescript
    autocmd!
    " autocmd BufWritePre,TextChanged,InsertLeave *.ts,*.tsx PrettierAsync
augroup END

" }}}
" ale {{{

let g:ale_disable_lsp = 1
let g:ale_set_highlights = 0

let g:ale_sign_error = 'x'
let g:ale_sign_warning = 'w'

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:typescript_linters = ['eslint', 'standard', 'tsserver', 'typecheck']

let g:ale_linters = {}
let g:ale_linters['go'] = golang_linters
let g:ale_linters['typescript'] = typescript_linters

" }}}
" coc {{{

let g:coc_global_extensions = [
    \ 'coc-css',
    \ 'coc-go',
    \ 'coc-json',
    \ 'coc-rls',
    \ 'coc-sh',
    \ 'coc-snippets',
    \ 'coc-snippets',
    \ 'coc-tsserver',
    \ 'coc-ultisnips',
    \ 'coc-vimlsp',
    \ 'coc-yaml',
    \ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif


inoremap <silent><expr> <TAB>
    \ pumvisible() ? coc#_select_confirm() :
    \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" imap <C-e> <Plug>(coc-snippets-expand)
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

nmap <leader>cp <Plug>(coc-diagnostic-prev)
nmap <leader>cn <Plug>(coc-diagnostic-next)
nmap <leader>cd <Plug>(coc-definition)
nmap <leader>cy <Plug>(coc-type-definition)
nmap <leader>ci <Plug>(coc-implementation)
nmap <leader>cr <Plug>(coc-references)
nmap <leader>cf <Plug>(coc-fix-current)
nmap <leader>r  <Plug>(coc-rename)
nmap <leader>do <Plug>(coc-codeaction)
nnoremap <silent><nowait> <leader>cc  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <leader>co  :<C-u>CocList outline<cr>

command! -nargs=0 Outline :CocList outline

" Map function and class text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if &filetype == 'vim'
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')


" }}}
" file management {{{
if executable("vifm")
  let g:vifm_replace_netrw = 1
  nnoremap <bs> :Vifm<cr>
endif

" }}}
" colorscheme {{{

let g:rainbow_active   = 1

function SetColors(theme)
    highlight clear
    execute "colorscheme ".a:theme

    highlight clear ALEErrorSign
    highlight clear ALEWarningSign
    highlight clear Folded
    highlight clear SignColumn

    highlight def link LspReferenceText  CursorLine
    highlight def link LspReferenceWrite CursorLine
    highlight def link LspReferenceRead  CursorLine

    highlight Comment cterm=italic
    highlight ExtraWhitespace  ctermbg=gray

    highlight ALEErrorSign   ctermbg=NONE ctermfg=red
    highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
    highlight Folded         ctermbg=NONE ctermfg=gray
    highlight LineNr         ctermbg=NONE ctermfg=gray
    highlight Normal         ctermbg=NONE
    highlight NonText        ctermbg=NONE
    highlight EndOfBuffer    ctermbg=NONE

    highlight GitSignsAdd    ctermbg=NONE  ctermfg=green
    highlight GitSignsChange ctermbg=NONE  ctermfg=blue
    highlight GitSignsDelete ctermbg=NONE  ctermfg=red

    highlight BookmarkSign ctermbg=NONE ctermfg=blue
    highlight BookmarkLine ctermbg=NONE ctermfg=blue
endfunction

"}}}
" leader mappings {{{

let mapleader      = "\<SPACE>"
let maplocalleader = ","

let g:magit_default_fold_level = 0

noremap <leader>gs :MagitOnly<CR>

if isdirectory(".git")
    nmap <leader>p :Telescope git_files theme=get_dropdown<CR>
else
    nmap <leader>p :Telescope find_files theme=get_dropdown<CR>
endif

nnoremap <leader>Ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>Fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>Fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>Fh <cmd>lua require('telescope.builtin').help_tags()<cr>

nmap <leader>bt :BookmarkToggle<CR>
nmap <leader>tb :BookmarkToggle<CR>
nmap <leader>ts :set spell!<CR>
nmap <leader>st :set spell!<CR>
nmap <leader>sa :set spell!<CR>

nmap <leader>q :bd<CR>

nmap <leader>tl :set nu! rnu!<CR>

nnoremap <leader><space> :b#<CR>
nnoremap <leader>tf :b#<CR>

nnoremap <silent><nowait> <leader>f  :<C-u>CocAction<cr>

nnoremap <leader>/ :%s/
vnoremap <leader>/ :s/

" }}}
"
lua require('leaderMappings')
lua require('tabbar')
call SetColors('everforest')
endif
