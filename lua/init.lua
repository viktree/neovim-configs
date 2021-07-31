--  vim: fdm=marker foldlevel=0 foldenable sw=2 ts=2 sts=2
-------------------------------------------------------------------------------------------

require('lib')

local cmd = vim.cmd

local colorscheme = 'everforest'
local use_icons = false

-- general settings {{{

cmd([[
set mouse=a
let g:rainbow_active   = 1
]])

-- clipboards {{{

cmd([[
set clipboard+=unnamedplus " map nvim clipboard to system clipboard

" Sync with system clipboard files
if has('macunix') && executable("pbcopy")
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><cr>
endif
]])

-- }}}
-- keybindings {{{

cmd([[
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
]])

-- }}}

-- }}}

-- setup plugin manager {{{
if MissingPacker() then
    InstallPacker()
end

require('plugins')

--- }}}

-- version control {{{

local vcConfig = {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  numhl = false,
  linehl = false,
  current_line_blame = true,
  current_line_blame_delay = 1000,
  current_line_blame_position = 'eol',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  use_decoration_api = true,
  use_internal_diff = true,  -- If luajit is present
}
require('gitsigns').setup(vcConfig)
-- }}}

-- file management {{{

cmd([[
if executable('vifm')
  let g:vifm_replace_netrw = 1
  nnoremap <bs> :Vifm<cr>
endif
]])

-- }}}

-- colorscheme {{{

cmd([[

function SetColors(theme)
  highlight clear
  execute "colorscheme ".a:theme

  highlight clear Folded
  highlight clear SignColumn

  highlight def link LspReferenceText  CursorLine
  highlight def link LspReferenceWrite CursorLine
  highlight def link LspReferenceRead  CursorLine

  highlight Comment cterm=italic
  highlight ExtraWhitespace  ctermbg=gray

  highlight GitSignsAdd    ctermbg=NONE ctermfg=green
  highlight GitSignsChange ctermbg=NONE ctermfg=blue
  highlight GitSignsDelete ctermbg=NONE ctermfg=red

  highlight BookmarkSign ctermbg=NONE ctermfg=blue
  highlight BookmarkLine ctermbg=NONE ctermfg=blue

  highlight Folded         ctermbg=NONE ctermfg=gray
  highlight LineNr         ctermbg=NONE ctermfg=gray
  highlight Normal         ctermbg=NONE
  highlight NonText        ctermbg=NONE
  highlight EndOfBuffer    ctermbg=NONE

endfunction
]])

cmd("autocmd VimEnter * call SetColors('" .. colorscheme .. "')")

cmd("call SetColors('" .. colorscheme .. "')")

-- }}}

-- statusline {{{
local config = {
  options = {
    icons_enabled = use_icons,
    theme = colorscheme,
    component_separators = {'', ''}
  },
  sections = {
    lualine_a = {'mode', 'paste' },
    lualine_b = {'filename', 'readonly', 'modified'},
    lualine_c = { },
    lualine_x = {'branch', 'b:gitsigns_status' },
    lualine_y = {'location'},
    lualine_z = {'filetype'}
  },
}

require('lualine').setup(config)
-- }}}

-- termimal mode {{{

cmd([[

tnoremap jj <C-\><C-n>
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l

]])

-- }}}

-- leader mappings {{{
local wk = require("which-key")

local mappings = {
  ["<space>"] = "previous file",
  ["/"] = "search",
  p = "find-file",
  g = {
    name = "git",
    s = { "<cmd>Neogit<cr>", "status" },
    c = { "<cmd>Neogit commit<cr>", "status" },
  },
  b = {
    name = "bookmarks",
    t = "toggle"
  },
  t = {
    name = "toggle",
    b = "bookmark",
    f = "file",
    s = "spelling",
    l = {":set nu! rnu!", 'line-numbers'},
  },
  c = {
    name = "coc",
    p = "diagnostic previous",
    n = "diagnostic next",
    d = "definition",
    y = "type definition",
    i = "implementation",
    f = "fix current",
    r = "reference",
    c = "commands",
    o = "outline",
  },
  r = "rename",
  f = "fix",
  F = "telescope",
  q = "quit"
}

wk.register(mappings, { prefix = "<leader>" })

wk.setup {
  key_labels = {
    ["<space>"] = "SPC",
    ["<cr>"]    = "RET",
    ["<tab>"]   = "TAB",
  }
}

cmd([[
let g:mapleader = "\<Space>"
let g:maplocalleader = ','

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

nnoremap <leader>/ :%s/
vnoremap <leader>/ :s/
]])

-- }}}

-- old configs {{{

cmd([[
"
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
 "
]])

-- }}}

-------------------------------------------------------------------------------------------
