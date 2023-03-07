--  vim: fdm=marker foldlevel=0 foldenable sw=2 ts=2 sts=2
-------------------------------------------------------------------------------------------
-- Neovim Configuration
-------------------------------------------------------------------------------------------

local vim = vim

vim.cmd [[set termguicolors]]
vim.cmd [[set inccommand=split]]

-- general autocmd {{{

-- line numbers {{{

vim.wo.number = true
vim.wo.relativenumber = true

local number_toggle = vim.api.nvim_create_augroup('numbertoggle', { clear = true })

vim.api.nvim_create_autocmd({'InsertLeave'}, {
	pattern = '*',
	group = number_toggle,
	command = 'setlocal relativenumber'
})
vim.api.nvim_create_autocmd({'InsertEnter'}, {
	pattern = '*',
	group = number_toggle,
	command = 'setlocal norelativenumber'
})

-- }}}

-- cursor {{{
local cursorGrp = vim.api.nvim_create_augroup('CursorLine', { clear = true })
vim.api.nvim_create_autocmd(
{ 'InsertLeave', "WinEnter" },
{ pattern = '*', command = "set cursorline", group = cursorGrp }
)
vim.api.nvim_create_autocmd(
{ 'InsertEnter', "WinLeave" },
{ pattern = '*', command = "set nocursorline", group = cursorGrp }
)
-- }}}

-- file associations {{{

vim.cmd([[
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
autocmd filetype markdown setlocal nonumber norelativenumber
]])

-- }}}

-- }}}

-- keybindings {{{
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.cmd[[
ino jj <esc>
cno jj <c-c>

nnoremap f :lua vim.lsp.buf.code_action()<cr>
]]

-- leader mappings {{{

local wk = require("which-key")

local mappings = {
    ["<space>"] = "previous file",
    ["/"] = "replace",
    ["."] = {"<cmd>Neoformat<cr>", "format"},
    p = "find-file",
		d = {
			name = 'duck',
			d = 'hatch',
			k = 'cook'
		},
    g = {
        name = "git",
        s = {"<cmd>Neogit<cr>", "status"},
        c = {"<cmd>Neogit commit<cr>", "commit"}
    },
    r = {
      name = "ren ame/grep",
      g = {"<cmd>!rg<cr>", "grep"},
    },
    s = "telescope command_palette",
    q = "quit"
}

wk.register(mappings, {prefix = "<leader>"})

wk.setup {
    key_labels = {
        ["<space>"] = "SPC",
        ["<cr>"] = "RET",
        ["<tab>"] = "TAB"
    }
}

vim.cmd([[
if isdirectory(".git")
  nmap <leader>p :Telescope git_files theme=get_dropdown<CR>
else
  nmap <leader>p :Telescope find_files theme=get_dropdown<CR>
endif
nnoremap <leader><space> :b#<CR>
nnoremap <leader>/ :%s/
vnoremap <leader>/ :s/
]])

-- }}}

-- telescope {{{

require('telescope').setup({
  extensions = {
    command_palette = {
      {"File",
        { "entire selection (C-a)", ':call feedkeys("GVgg")' },
        { "save current file (C-s)", ':w' },
        { "save all files (C-A-s)", ':wa' },
        { "quit (C-q)", ':qa' },
        { "file browser (C-i)", ":lua require'telescope'.extensions.file_browser.file_browser()", 1 },
        { "search word (A-w)", ":lua require('telescope.builtin').live_grep()", 1 },
        { "git files (A-f)", ":lua require('telescope.builtin').git_files()", 1 },
        { "files (C-f)",     ":lua require('telescope.builtin').find_files()", 1 },
      },
      {"Help",
        { "tips", ":help tips" },
        { "cheatsheet", ":help index" },
        { "tutorial", ":help tutor" },
        { "summary", ":help summary" },
        { "quick reference", ":help quickref" },
        { "search help(F1)", ":lua require('telescope.builtin').help_tags()", 1 },
      },
      {"Vim",
				{ "format", ":NeoFormat" },
        { "reload vimrc", ":source $MYVIMRC" },
        { 'check health', ":checkhealth" },
        { "jumps (Alt-j)", ":lua require('telescope.builtin').jumplist()" },
        { "commands", ":lua require('telescope.builtin').commands()" },
        { "command history", ":lua require('telescope.builtin').command_history()" },
        { "registers (A-e)", ":lua require('telescope.builtin').registers()" },
        { "colorshceme", ":lua require('telescope.builtin').colorscheme()", 1 },
        { "vim options", ":lua require('telescope.builtin').vim_options()" },
        { "keymaps", ":lua require('telescope.builtin').keymaps()" },
        { "buffers", ":Telescope buffers" },
        { "search history (C-h)", ":lua require('telescope.builtin').search_history()" },
        { "paste mode", ':set paste!' },
        { 'cursor line', ':set cursorline!' },
        { 'cursor column', ':set cursorcolumn!' },
        { "spell checker", ':set spell!' },
      }
    }
  }
})

require('telescope').load_extension('command_palette')

-- }}}

-- }}}

-- plugin manager {{{

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

vim.notify = require('notify')

require('packer').startup(SetupPlugins)

require('nvim-autopairs').setup()
require('nvim-treesitter.configs').setup {
	endwise = {
		enable = true,
	},
}
require('spectre').setup()
vim.cmd [[nnoremap <leader>S <cmd>lua require('spectre').open()<CR>]]

-- }}}

-- version control {{{

require('gitsigns').setup {
    signs = {
        add = { text = "│"},
        change = {text = "│"},
        delete = {text = "_"},
        topdelete = {text = "‾"},
        changedelete = {text = "~"}
    },
    numhl = false,
    linehl = false,
		yadm = {
			enable = true
		}
}

-- }}}

-- file managment {{{

vim.g.EditorConfig_exclude_patterns = {"fugitive://.*", "scp://.*"}

vim.cmd([[
if executable('vifm')
  let g:vifm_replace_netrw = 1
  nnoremap <bs> :Vifm<cr>
endif
]])

-- }}}

-- bookmarks {{{

-- Shortcuts for frequently accessed files
vim.cmd([[
command! Vimrc e $MYVIMRC
command! Plugins e $XDG_CONFIG_HOME/nvim/lua/plugins.lua
command! Leader e $XDG_CONFIG_HOME/nvim/lua/leaderMappings.lua
command! Reload source $MYVIMRC

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

if executable('k9s')
  command! K9s FloatermNew --autoclose=0 k9s
endif
]])

-- }}}

--- aliases {

-- Shortcuts for frequently accessed files
vim.cmd([[

if executable('k9s')
  command! K9s FloatermNew --autoclose=0 K9s
endif

if executable('mprocs')
  command! Mprocs FloatermNew --autoclose=0 mprocs
endif

if executable('lazygit')
  command! Lg FloatermNew --autoclose=0 lazygit
endif

]])


--}

-- colorscheme {{{

local theme = 'nord'

vim.g.nord_disable_background = true
vim.g.nord_italic = true
vim.g.nord_bold = true

require(theme).set()
vim.cmd[[colorscheme nord]]

--require('onedark').setup {
--    style = 'cooldarker'
--}
--require('onedark').load()

-- }}}

-- statusline {{{

require('lualine').setup {
	options = {
		theme = theme
	}
}

-- }}}

-- lsp {{{

local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
	'tsserver',
	'eslint',
	'lua_ls',
	'rust_analyzer',
	'cssls',
	'astro',
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({ select = true }),
	['<C-Space>'] = cmp.mapping.complete(),
})

lsp.set_preferences({
	sign_icons = { }
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})

lsp.on_attach(function(_, bufnr)
	local opts = {buffer = bufnr, remap = false}

	vim.keymap.set('n', "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set('n', "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set('n', "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set('n', "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set('n', "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set('n', "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set('n', "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set('n', "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set('n', "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set('i', "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

-- }}}

-- refactoring {{{

vim.g.neoformat_try_node_exe = 1

-- }}}
