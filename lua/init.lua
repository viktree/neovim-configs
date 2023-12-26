--  vim: fdm=marker foldlevel=0 foldenable conceallevel=2
-------------------------------------------------------------------------------
-- neovim configuration
-------------------------------------------------------------------------------

vim.opt.termguicolors = true
vim.opt.cmdheight = 2

vim.opt.foldenable = true

-- setup package manager {{{

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

--
-- }}}
-- packages {{{

local lazy = require "lazy"

lazy.setup {
	"nvim-lua/plenary.nvim",
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		requires = { { "nvim-lua/plenary.nvim" } },
	},
	"ThePrimeagen/harpoon",
	"Lilja/zellij.nvim",
	"nacro90/numb.nvim",
	"kylechui/nvim-surround",
	"sebdah/vim-delve",
	"tomasky/bookmarks.nvim",

	"skanehira/denops-docker.vim",
	"rottencandy/vimkubectl",
	"skanehira/k8s.vim",

	{
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	"stevearc/oil.nvim",
	"b0o/schemastore.nvim",
	"almo7aya/openingh.nvim",
	{
		"olexsmir/gopher.nvim",
		requires = {
			-- dependencies
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	"nvim-treesitter/playground",

	"folke/which-key.nvim",
	"anuvyklack/hydra.nvim",

	{ "catppuccin/nvim", as = "catppuccin" },
	{
		"navarasu/onedark.nvim",
		config = function() vim.cmd [[colorscheme onedark]] end,
	},

	-- debugging {{{
	--
	"mfussenegger/nvim-dap",
	{ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } },
	"Weissle/persistent-breakpoints.nvim",
	"ofirgall/goto-breakpoints.nvim",
	{ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } },

	-- }}}
	-- find, replace {{{
	"romainl/vim-cool",
	"windwp/nvim-spectre",
	"markonm/traces.vim",
	{
		"cshuaimin/ssr.nvim",
		module = "ssr",
	},
	-- }}}
	-- indentation {{{

	"ntpeters/vim-better-whitespace",
	"lukas-reineke/indent-blankline.nvim",
	"windwp/nvim-autopairs",
	"stevearc/conform.nvim",

	-- }}}
	-- load things faster {{{
	--
	"lewis6991/impatient.nvim",
	"ethanholz/nvim-lastplace",
	--
	-- }}}
	-- lsp {{{
	--
	{
		"VonHeikemen/lsp-zero.nvim",
	},
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	-- Autocompletion
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lua" },
	-- Snippets
	{ "L3MON4D3/LuaSnip" },
	{ "rafamadriz/friendly-snippets" },
	"onsails/lspkind.nvim",
	"kosayoda/nvim-lightbulb",
	{
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		fold_open = "",
		fold_closed = "",
	},
	"WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
	"ray-x/lsp_signature.nvim",
	"numToStr/Comment.nvim",
	"voldikss/vim-floaterm",
	"David-Kunz/jester",
	--
	-- }}}
	-- syntax highlighting {{{
	--
	"sheerun/vim-polyglot",
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	},
	"HerringtonDarkholme/yats.vim",
	--
	-- }}}
	-- version control {{{
	--
	{
		"tpope/vim-fugitive",
		"lewis6991/gitsigns.nvim",
		{
			"NeogitOrg/neogit",
		},
	},
	{
		"ldelossa/gh.nvim",
		requires = { { "ldelossa/litee.nvim" } },
	},
	{ "mbbill/undotree" },
	{ "ThePrimeagen/git-worktree.nvim" },
	--
	-- }}}
	-- visual flair {{{
	"nvim-tree/nvim-web-devicons",
	"rcarriga/nvim-notify",
	"machakann/vim-highlightedyank",
	"m4xshen/smartcolumn.nvim",
	{
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	},
	{
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
	},
	--
	-- }}}
}

-- }}}
--import external libraries {{{

local actions = require "telescope.actions"
local autopairs = require "nvim-autopairs"
local bookmarks = require "bookmarks"
---@diagnostic disable-next-line: unused-local
local catppuccin = require "catppuccin"
local cmp = require "cmp"
local commentary = require "Comment"
local conform = require "conform"
local dap = require "dap"
local dap_widgets = require "dap.ui.widgets"
local dapui = require "dapui"
local gitsigns = require "gitsigns"
local harpoon = require "harpoon"
local hydra = require "hydra"
local lastplace = require "nvim-lastplace"
local lsp = require "lsp-zero"
local lspconfig = require "lspconfig"
local lspkind = require "lspkind"
local lspsignature = require "lsp_signature"
local lualine = require "lualine"
local luasnip = require "luasnip"
local mason = require "mason"
local mason_lsp = require "mason-lspconfig"
local neogit = require "neogit"
local oil = require "oil"
local refactoring = require "refactoring"
local schemastore = require "schemastore"
local smartcolumn = require "smartcolumn"
local surround = require "nvim-surround"
local telescope = require "telescope"
local toggleDiagonstics = require "toggle_lsp_diagnostics"
local trouble = require "trouble"
local wk = require "which-key"
---@diagnostic disable-next-line: unused-local
local worktree = require "git-worktree"
local zellij = require "zellij"

---@diagnostic disable-next-line: unused-local
local cmp_action = lsp.cmp_action()

autopairs.setup {}
conform.setup {
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		go = { "goimports", "gofmt" },
	},
}
commentary.setup {}
lastplace.setup {}
smartcolumn.setup {
	colorcolumn = { "80", "120" },
}
refactoring.setup {
	prompt_func_return_type = {
		go = true,
	},
	prompt_func_param_type = {
		go = true,
	},
	printf_statements = {},
	print_var_statements = {},
}
surround.setup {}
trouble.setup {
	signs = {
		error = "",
		warning = "",
		hint = "",
		information = "",
		other = "﫠",
	},
	use_diagnostic_signs = true,
}
zellij.setup {
	vimTmuxNavigatorKeybinds = true,
	replaceVimWindowNavigationKeybinds = true,
}

-- }}}
-- helper functions {{{

local remove_neovim_cmd = function(oldname)
	vim.api.nvim_create_user_command(oldname, "", {})
	vim.api.nvim_del_user_command(oldname)
end

local add_neovim_cmd = function(name, action) vim.api.nvim_create_user_command(name, action, {}) end

local function get_git_root()
	local dot_git_path = vim.fn.finddir(".git", ".;")
	return vim.fn.fnamemodify(dot_git_path, ":h")
end

local function bin_exists(bin_name) return vim.fn.executable(bin_name) == 1 end

-- }}}
-- navigation {{{
harpoon.setup {}

oil.setup {
	default_file_explorer = true,
	columns = {
		"icon",
		"permissions",
		"size",
		"mtime",
	},
	view_options = {
		show_hidden = true,
	},
}

-- require("ssr").setup {
--     border = "rounded",
--     min_width = 50,
--     min_height = 5,
--     max_width = 120,
--     max_height = 25,
--     keymaps = {
--         close = "q",
--         next_match = "n",
--         prev_match = "N",
--         replace_confirm = "<cr>",
--         replace_all = "<leader><cr>"
--     }
-- }
require("spectre").setup()

-- }}}
-- version control {{{

neogit.setup {
	disable_commit_confirmation = true,
	signs = {
		section = { "", "" },
		item = { "", "" },
		hunk = { "", "" },
	},
}

gitsigns.setup {
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
	numhl = false,
	linehl = false,
	yadm = {
		enable = true,
	},
}
-- }}}
-- remove commands {{{

remove_neovim_cmd "StripWhitespaceOnChangedLines"
remove_neovim_cmd "CurrentLineWhitespaceOn"
remove_neovim_cmd "CurrentLineWhitespaceOff"

remove_neovim_cmd "Explore"
remove_neovim_cmd "Sexplore"
remove_neovim_cmd "Hexplore"
remove_neovim_cmd "NetrwC"
remove_neovim_cmd "NetrwClean"
remove_neovim_cmd "Ntree"

remove_neovim_cmd "HighlightedyankOn"
remove_neovim_cmd "HighlightedyankOff"
remove_neovim_cmd "HighlightedyankToggle"

-- color scheme should be set not changed
remove_neovim_cmd "Catppuccin"
remove_neovim_cmd "CatppuccinCompile"

-- }}}
-- general autocmd {{{

-- packer {{{
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]]
-- }}}
-- cursor {{{
local cursorGrp = vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd(
	{ "InsertLeave", "WinEnter" },
	{ pattern = "*", command = "set cursorline", group = cursorGrp }
)
vim.api.nvim_create_autocmd(
	{ "InsertEnter", "WinLeave" },
	{ pattern = "*", command = "set nocursorline", group = cursorGrp }
)
-- }}}
-- file associations {{{

vim.cmd [[
augroup file_associations
  autocmd!
  autocmd BufRead,BufNewFile *.md setlocal filetype=markdown syntax =markdown
  autocmd BufRead,BufNewFile *.markdown setlocal filetype=markdown syntax =markdown
  autocmd BufRead,BufNewFile *.ts setlocal filetype=typescript syntax =typescript
  autocmd BufRead,BufNewFile *.pgf setlocal filetype=tex syntax =tex
  autocmd BufRead,BufNewFile *.tikz setlocal filetype=tex syntax =tex
  autocmd BufRead,BufNewFile *.pdf_tex setlocal filetype=tex syntax =tex
  autocmd BufRead,BufNewFile .latexmkrc setlocal filetype=perl syntax =perl
  autocmd BufRead,BufNewFile *.env setlocal filetype=sh syntax=sh
  autocmd BufRead,BufNewFile *.env.example setlocal filetype=sh syntax=sh
  autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
  autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

augroup END
autocmd filetype markdown setlocal nonumber nornu
]]

-- }}}
-- templates {{{

vim.cmd [[
augroup file_associations
    autocmd!
    autocmd BufNewFile  *.py 0r ~/.config/nvim/snippets/python.txt
augroup END
]]

-- }}}

vim.cmd [[
	autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()
]]

-- }}}
-- telescope {{{

vim.cmd "au ColorScheme * hi TelescopeBorder ctermbg=none guibg=none"

telescope.setup {
	defaults = {
		file_ignore_patterns = {
			"node_modules",
		},
		mappings = {
			i = {
				["<esc>"] = actions.close,
			},
		},
	},
	pickers = {
		keymaps = {
			theme = "ivy",
		},
		workspaces = {
			theme = "dropdown",
		},
		lsp_references = {
			theme = "dropdown",
		},
	},
	extensions = {
		workspaces = {
			keep_insert = false,
		},
		harpoon = {},
	},
}

telescope.load_extension "git_worktree"
telescope.load_extension "harpoon"
telescope.load_extension "refactoring"
telescope.load_extension "bookmarks"

-- }}}
-- bookmarks {{{

add_neovim_cmd("Config", "edit $XDG_CONFIG_HOME/nvim/lua/init.lua")
add_neovim_cmd("Terminal", "edit $XDG_CONFIG_HOME/wezterm/wezterm.lua")

if bin_exists "brew" then add_neovim_cmd("Brew", "edit $HOMEBREW_BUNDLE_FILE") end

if bin_exists "zsh" then
	add_neovim_cmd("Shell", "edit $ZDOTDIR/.zshrc")
	add_neovim_cmd("Env", "edit $ZDOTDIR/.zshenv")
elseif bin_exists "bash" then
	add_neovim_cmd("Shell", "edit $HOME/.bashrc")
	add_neovim_cmd("Env", "edit $HOME/.profile")
end

add_neovim_cmd("Yadm", "edit $XDG_CONFIG_HOME/yadm/bootstrap")
if bin_exists "yadm" == not 1 then remove_neovim_cmd "Yadm" end

bookmarks.setup {
	save_file = vim.fn.expand "$XDG_CONFIG_HOME/nvim/bookmarks",
	keywords = {
		["@t"] = "☑️",
		["@w"] = "⚠️",
		["@d"] = "🎥",
		["@f"] = "⛏ ",
	},
	sign_priority = 8,
	on_attach = function()
		vim.keymap.set("n", "mm", bookmarks.bookmark_toggle)
		vim.keymap.set("n", "ma", bookmarks.bookmark_ann)
		vim.keymap.set("n", "mc", bookmarks.bookmark_clean)
		vim.keymap.set("n", "[m", bookmarks.bookmark_next)
		vim.keymap.set("n", "]m", bookmarks.bookmark_prev)
	end,
}

-- }}}
-- aliases {{{

add_neovim_cmd("Fix", "CodeActionMenu")
add_neovim_cmd("Fmt", function() conform.format() end)
add_neovim_cmd("RemoveWhitespace", "StripWhitespaceOnChangedLines")

add_neovim_cmd("Ecp", "FloatermNew $HOME/dev/osiris/ecp-core/mprocs_client.vik.sh")

add_neovim_cmd("Cd", "cd %:p:h")
add_neovim_cmd("Run", '!"%:p"')
add_neovim_cmd("Source", ":!source %")
add_neovim_cmd("GWorktree", "lua require('telescope').extensions.git_worktree.git_worktrees()")

add_neovim_cmd("CdGitRoot", function() vim.api.nvim_set_current_dir(get_git_root()) end)

if bin_exists "rtx" then
	add_neovim_cmd("Rtx", function()
		vim.api.nvim_set_current_dir(get_git_root())
		vim.api.nvim_command ":e .rtx.toml"
	end)
end

add_neovim_cmd("Dotenv", function()
	vim.api.nvim_set_current_dir(get_git_root())
	vim.api.nvim_command ":sp .env"
end)

add_neovim_cmd("Rtx", function()
	vim.api.nvim_set_current_dir(get_git_root())
	vim.api.nvim_command ":sp .rtx.toml"
end)

if bin_exists "k9s" then add_neovim_cmd("K9s", "FloatermNew --autoclose=0 k9s") end

if bin_exists "mprocs" then add_neovim_cmd("Mprocs", "FloatermNew --autoclose=0 mprocs") end

if bin_exists "kubectx" then add_neovim_cmd("Kubectx", "FloatermNew --autoclose=0 kubectx") end

if bin_exists "kubens" then add_neovim_cmd("Kubens", "FloatermNew --autoclose=0 kubens") end

if bin_exists "lazygit" then add_neovim_cmd("Lg", "FloatermNew --autoclose=0 lazygit") end

--}}}
-- file management {{{

vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*", "oil://.*" }
-- }}}
-- keymaps {{{

-- insert mode mappings {{{
vim.cmd [[ imap ;; <ESC>A; ]]
vim.keymap.set("i", "jj", "<Esc>", { noremap = true })
-- }}}

-- normal mode mappings {{{

vim.keymap.set("n", ";", ":")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<leader>/", ":%s/", { noremap = true })
vim.keymap.set("n", "<bs>", "<cmd>Oil --float<cr>", { noremap = true })
vim.keymap.set("n", "Q", "@q", { noremap = true })
vim.keymap.set("n", "U", "<C-R>", { noremap = true })

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "[g", gitsigns.next_hunk)
vim.keymap.set("n", "]g", gitsigns.prev_hunk)
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>")
vim.keymap.set("n", "]b", "<cmd>bnext<cr>")

-- }}}

-- visual mode mappings {{{
vim.cmd [[ vnoremap <leader>p "_dP ]]
vim.keymap.set("v", "<leader>/", ":s/", { noremap = true })
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")
vim.keymap.set("v", "Q", ":normal @q", { noremap = true })
-- }}}

-- refactoring {{{

vim.keymap.set("n", "<localleader>rb", function() refactoring.refactor "Extract Block" end)
vim.keymap.set("n", "<localleader>rf", function() refactoring.refactor "Extract Block To File" end)

-- }}}

-- easy increment / decrement {{{
vim.api.nvim_set_keymap("n", "+", "<c-a>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "-", "<c-x>", { noremap = true, silent = true })
-- }}}

-- leader mappings {{{

vim.g.mapleader = " "
vim.g.maplocalleader = ","

local leaderMapings = {
	["<space>"] = "previous file",
	["/"] = "replace",
	["."] = { "<cmd>Fmt<cr>", "format" },
	c = "config",
	w = "window",
	s = {
		name = "search",
		s = { "<cmd>lua require('spectre').open()<cr>", "spectre search" },
		r = { "<cmd>lua require('ssr').open()<cr>", "structural" },
	},
	p = "files",
	g = {
		name = "git",
		A = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "stage buffer" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "reset buffer" },
		a = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "stage hunk" },
		b = { "<cmd>Telescope git_branches<cr>", "switch branch" },
		B = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "blame" },
		c = { "<cmd>Neogit commit<cr>", "commit" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "next hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "prev hunk" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "preview hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "reset hunk" },
		s = { "<cmd>Neogit<cr>", "status" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"undo stage hunk",
		},
		w = {
			"<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
			"switch worktree",
		},
	},
	t = {
		name = "toggle/todo",
		b = { "<cmd>DapToggleBreakpoint<cr>", "breakpoint" },
		d = { name = "todo" },
		l = { "<Plug>(toggle-lsp-diag)", "lsp" },
	},
	r = {
		"<cmd>Telescope live_grep<cr>",
		"grep",
	},
	D = {
		name = "debug",
		t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "toggle breakpoint" },
		b = { "<cmd>lua require'dap'.step_back()<cr>", "step back" },
		c = { "<cmd>lua require'dap'.continue()<cr>", "continue" },
		C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "run to cursor" },
		d = { "<cmd>lua require'dap'.disconnect()<cr>", "disconnect" },
		g = { "<cmd>lua require'dap'.session()<cr>", "get session" },
		i = { "<cmd>lua require'dap'.step_into()<cr>", "step into" },
		o = { "<cmd>lua require'dap'.step_over()<cr>", "step over" },
		u = { "<cmd>lua require'dap'.step_out()<cr>", "step out" },
		p = { "<cmd>lua require'dap'.pause()<cr>", "pause" },
		r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "toggle repl" },
		s = { "<cmd>lua require'dap'.continue()<cr>", "start" },
		q = { "<cmd>lua require'dap'.close()<cr>", "quit" },
		U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "toggle ui" },
		v = "<cmd>lua require('dapui').open()",
		a = { "<cmd>DapToggleBreakpoint<cr>", "add breakpoint" },
	},
	f = { "<cmd>Fix<cr>", "fix" },
	q = "quit",
	j = {
		name = "jump",
		a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add" },
		m = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Menu" },
		b = { "<cmd>Telescope bookmarks list<cr>", "Bookmarks" },
	},
	["<cr>"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "harpoon" },
	h = {
		name = "quick harpoon",
		["1"] = { "<cmd>lua require('harpoon.ui').nav_file(1) <cr>", "harpoon 1" },
		["2"] = { "<cmd>lua require('harpoon.ui').nav_file(2) <cr>", "harpoon 2" },
		["3"] = { "<cmd>lua require('harpoon.ui').nav_file(3) <cr>", "harpoon 3" },
		["4"] = { "<cmd>lua require('harpoon.term').gotoTerminal(1)<cr>", "harpoon terminal" },
	},
	z = {
		name = "zellij",
		h = { "<cmd>ZellijNavigateLeft<cr>", "left" },
		j = { "<cmd>ZellijNavigateDown<cr>", "down" },
		k = { "<cmd>ZellijNavigateUp<cr>", "up" },
		l = { "<cmd>ZellijNavigateRight<cr>", "right" },
		t = {
			name = "tab",
			r = {
				"<cmd>ZellijRenameTab" .. vim.fn.expand "%" .. "<cr>",
				"rename",
			},
			n = { "<cmd>ZellijNewTab<cr>", "new" },
		},
	},
}

vim.cmd [[
nmap <leader>td OTODO: <ESC>gccA
]]

vim.cmd [[
nmap <leader>p :Telescope find_files theme=get_dropdown<cr>
nnoremap <leader><space> :b#<cr>
nnoremap <leader>/ :%s/
vnoremap <leader>/ :s/
]]

-- }}}

-- localleader mappings {{{

local localleaderMappings = {
	g = {
		name = "lsp",
		a = "action",
		d = "definition",
		D = "declaration",
		i = "implementation",
		r = "reference",
		t = "type definition",
	},
	f = {
		name = "find",
		w = "workspace",
		W = "dynamic_workspace",
		d = "document",
	},
	F = {
		"<cmd>CodeActionMenu<cr>",
		"fix",
	},
	r = {
		name = "refactor",
		n = "rename",
		b = "extract block",
		f = "extract block to file",
		r = { "<cmd> lua require('telescope').extensions.refactoring.refactors()<cr>", "telescope" },
	},
	D = "debug",
	k = "signature",
	d = { "<cmd>Telescope diagnostics theme=dropdown<cr>", "diagnostics" },
	[","] = { "<cmd>Fmt<cr>", "format" },
}

-- }}}

-- next / prev {{{
local nextMappings = {
	["%"] = "matchit backwards",
	g = "next git hunk",
	d = "next diagnostic message",
	b = "next buffer",
	m = "next bookmark",
}
local prevMappings = {
	["%"] = "matchit forwards",
	g = "previous git hunk",
	d = "previous diagnostic message",
	b = "previous buffer",
	m = "next bookmark",
}
-- }}}

-- setup which-key {{{

wk.register(leaderMapings, { prefix = "<leader>" })
wk.register(localleaderMappings, { prefix = "<localleader>" })
wk.register(nextMappings, { prefix = "[" })
wk.register(prevMappings, { prefix = "]" })

wk.setup {
	key_labels = {
		["<space>"] = "SPC",
		["<bs>"] = "DEL",
		["<cr>"] = "RET",
		["<tab>"] = "TAB",
	},
	plugins = {
		marks = false,
		registers = false,
		presets = {
			operators = false,
			motions = false,
			text_objects = false,
			windows = false,
			nav = false,
			z = false,
			g = false,
		},
	},
}
-- }}}

-- splits {{{

wk.register {
	["<C-h>"] = { "<cmd>ZellijNavigateLeft<cr>", "Navigate left vim window/zellij  pane" },
	["<C-j>"] = { "<cmd>ZellijNavigateDown<cr>", "Navigate down vim window/zellij  pane" },
	["<C-k>"] = { "<cmd>ZellijNavigateUp<cr>", "Navigate up vim window/zellij pane" },
	["<C-l>"] = { "<cmd>ZellijNavigateRight<cr>", "Navigate right vim window/zellij pane" },
	["<C-p>"] = {
		["h"] = { "<cmd>ZellijNavigateLeft<cr>", "Navigate left vim window/zellij  pane" },
		["j"] = { "<cmd>ZellijNavigateDown<cr>", "Navigate down vim window/zellij  pane" },
		["k"] = { "<cmd>ZellijNavigateUp<cr>", "Navigate up vim window/zellij pane" },
		["l"] = { "<cmd>ZellijNavigateRight<cr>", "Navigate right vim window/zellij pane" },
		name = "Zeillij",
	},
}

--
-- }}}

-- lsp {{{

---@diagnostic disable-next-line: unused-local
local on_attach = function(_client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	buf_set_keymap("n", "<localleader>gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
	buf_set_keymap("n", "<localleader>gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
	buf_set_keymap("n", "<localleader>gd", "<cmd>Telescope lsp_definitions<cr>", opts)
	buf_set_keymap("n", "<localleader>gt", "<cmd>Telescope lsp_type_definitions<cr>", opts)
	buf_set_keymap("n", "<localleader>gr", "<cmd>Telescope lsp_references theme=dropdown<cr>", opts)
	buf_set_keymap("n", "<localleader>ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	buf_set_keymap("n", "<localleader>gr", "<cmd>Telescope lsp_references theme=dropdown<cr>", opts)
	buf_set_keymap("n", "<localleader>gi", "<cmd>Telescope lsp_implementations theme=dropdown<cr>", opts)
	buf_set_keymap("n", "<localleader>k", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
	buf_set_keymap("n", "<localleader>fd", "<cmd>Telescope lsp_document_symbols theme=dropdown<cr>", opts)
	buf_set_keymap("n", "<localleader>fw", "<cmd>Telescope lsp_workspace_symbols theme=dropdown<cr>", opts)
	buf_set_keymap("n", "<localleader>fW", "<cmd>Telescope lsp_dynamic_workspace_symbols theme=dropdown<cr>", opts)
	buf_set_keymap("n", "<localleader>fr", "<cmd>Telescope live_grep theme=dropdown<cr>", opts)
	buf_set_keymap("n", "<localleader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
end

-- }}}

-- hydra {{{

-- dap {{{

local function dap_menu()
	local debug_hint = [[
 _t_: Toggle Breakpoint             _R_: Run to Cursor
 _s_: Start                         _E_: Evaluate Input
 _c_: Continue                      _C_: Conditional Breakpoint
 _b_: Step Back                     _U_: Toggle UI
 _d_: Disconnect                    _S_: Scopes
 _e_: Evaluate                      _X_: Close
 _g_: Get Session                   _i_: Step Into
 _h_: Hover Variables               _o_: Step Over
 _r_: Toggle REPL                   _u_: Step Out
 _x_: Terminate                     _p_: Pause
 ^ ^               _q_: Quit
]]

	return {
		name = "Debug",
		hint = debug_hint,
		config = {
			color = "pink",
			invoke_on_body = true,
			hint = {
				border = "rounded",
				position = "middle-right",
			},
		},
		mode = "n",
		body = "<localleader>D",
        -- stylua: ignore
        heads = {
            {
                "C",
                function()
                    dap.set_breakpoint(vim.fn.input "[Condition] > ")
                end,
                desc = "Conditional Breakpoint"
            },
            {
                "E",
                function()
                    dapui.eval(vim.fn.input "[Expression] > ")
                end,
                desc = "Evaluate Input"
            },
            {
                "R",
                function()
                    dap.run_to_cursor()
                end,
                desc = "Run to Cursor"
            },
            {
                "S",
                function()
                    dap_widgets.scopes()
                end,
                desc = "Scopes"
            },
            {
                "U",
                function()
                    dapui.toggle()
                end,
                desc = "Toggle UI"
            },
            {
                "X",
                function()
                    dap.close()
                end,
                desc = "Quit"
            },
            {
                "b",
                function()
                    dap.step_back()
                end,
                desc = "Step Back"
            },
            {
                "c",
                function()
                    dap.continue()
                end,
                desc = "Continue"
            },
            {
                "d",
                function()
                    dap.disconnect()
                end,
                desc = "Disconnect"
            },
            {
                "e",
                function()
                    dapui.eval()
                end,
                mode = {"n", "v"},
                desc = "Evaluate"
            },
            {
                "g",
                function()
                    dap.session()
                end,
                desc = "Get Session"
            },
            {
                "h",
                function()
                    dap_widgets.hover()
                end,
                desc = "Hover Variables"
            },
            {
                "i",
                function()
                    dap.step_into()
                end,
                desc = "Step Into"
            },
            {
                "o",
                function()
                    dap.step_over()
                end,
                desc = "Step Over"
            },
            {
                "p",
                function()
                    dap.pause.toggle()
                end,
                desc = "Pause"
            },
            {
                "r",
                function()
                    dap.repl.toggle()
                end,
                desc = "Toggle REPL"
            },
            {
                "s",
                function()
                    dap.continue()
                end,
                desc = "Start"
            },
            {
                "t",
                function()
                    dap.toggle_breakpoint()
                end,
                desc = "Toggle Breakpoint"
            },
            {
                "u",
                function()
                    dap.step_out()
                end,
                desc = "Step Out"
            },
            {
                "x",
                function()
                    dap.terminate()
                end,
                desc = "Terminate"
            },
            {"q", nil, {exit = true, nowait = true, desc = "Exit"}}
        }
,
	}
end

hydra(dap_menu())

-- }}}

-- windows {{{

local cmd = require("hydra.keymap-util").cmd
local pcmd = require("hydra.keymap-util").pcmd

local buffer_hydra = hydra {
	name = "windows",
	config = {
		on_key = function()
			-- Preserve animation
			vim.wait(200, function() vim.cmd "redraw" end, 30, false)
		end,
	},
	heads = {
		{
			"h",
			function() vim.cmd "BufferPrevious" end,
			{ on_key = false },
		},
		{
			"l",
			function() vim.cmd "BufferNext" end,
			{ desc = "choose", on_key = false },
		},
		{
			"H",
			function() vim.cmd "BufferMovePrevious" end,
		},
		{
			"L",
			function() vim.cmd "BufferMoveNext" end,
			{ desc = "move" },
		},
		{
			"p",
			function() vim.cmd "BufferPin" end,
			{ desc = "pin" },
		},
		{
			"d",
			function() vim.cmd "BufferClose" end,
			{ desc = "close" },
		},
		{
			"c",
			function() vim.cmd "BufferClose" end,
			{ desc = false },
		},
		{
			"q",
			function() vim.cmd "BufferClose" end,
			{ desc = false },
		},
		{
			"od",
			function() vim.cmd "BufferOrderByDirectory" end,
			{ desc = "by directory" },
		},
		{
			"ol",
			function() vim.cmd "BufferOrderByLanguage" end,
			{ desc = "by language" },
		},
		{ "<Esc>", nil, { exit = true } },
	},
}

local function choose_buffer()
	if #vim.fn.getbufinfo { buflisted = true } > 1 then buffer_hydra:activate() end
end

local window_hint = [[
 ^^^^^^^^^^^^     Move       ^^     Split
 ^^^^^^^^^^^^-------------   ^^---------------
 ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^    _s_: horizontally
 _h_ ^ ^ _l_  _H_ ^ ^ _L_    _v_: vertically
 ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^    _q_, _c_: close
 focus^^^^^^  window^^^^^^   _z_: maximize
 ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^    _o_: remain only
 _b_: choose buffer
]]

hydra {
	name = "Windows",
	hint = window_hint,
	config = {
		invoke_on_body = true,
		hint = {
			border = "rounded",
			offset = -1,
		},
	},
	mode = "n",
	body = "<leader>w",
	heads = {
		{ "h", "<C-w>h" },
		{ "j", "<C-w>j" },
		{ "k", pcmd("wincmd k", "E11", "close") },
		{ "l", "<C-w>l" },
		{ "H", cmd "WinShift left" },
		{ "J", cmd "WinShift down" },
		{ "K", cmd "WinShift up" },
		{ "L", cmd "WinShift right" },
		{ "s", pcmd("split", "E36") },
		{ "<C-s>", pcmd("split", "E36"), { desc = false } },
		{ "v", pcmd("vsplit", "E36") },
		{ "<C-v>", pcmd("vsplit", "E36"), { desc = false } },
		{ "w", "<C-w>w", { exit = true, desc = false } },
		{ "<C-w>", "<C-w>w", { exit = true, desc = false } },
		{ "z", cmd "WindowsMaximaze", { exit = true, desc = "maximize" } },
		{ "<C-z>", cmd "WindowsMaximaze", { exit = true, desc = false } },
		{ "o", "<C-w>o", { exit = true, desc = "remain only" } },
		{ "<C-o>", "<C-w>o", { exit = true, desc = false } },
		{ "b", choose_buffer, { exit = true, desc = "choose buffer" } },
		{ "c", pcmd("close", "E444") },
		{ "q", pcmd("close", "E444"), { desc = "close window" } },
		{ "<C-c>", pcmd("close", "E444"), { desc = false } },
		{ "<C-q>", pcmd("close", "E444"), { desc = false } },
		{ "<Esc>", nil, { exit = true, desc = false } },
	},
}

-- }}}

-- options {{{

vim.g.formatOnSave = false

local hint = [[
  ^ ^        Options
  ^
  _c_ %{cul} cursor line
  _i_ %{list} invisible characters
  _n_ %{nu} number
  _r_ %{rnu} relative number
  _s_ %{spell} spell
  _v_ %{ve} virtual edit
  _w_ %{wrap} wrap

  c close
  ^
       ^^^^                _jj_
]]

hydra {
	name = "Config",
	hint = hint,
	config = {
		color = "amaranth",
		invoke_on_body = true,
		hint = {
			border = "rounded",
			position = "middle",
		},
	},
	mode = { "n", "x" },
	body = "<leader>c",
	heads = {
		{
			"n",
			function()
				if vim.o.number == true then
					vim.o.number = false
				else
					vim.o.number = true
				end
			end,
			{ desc = "number" },
		},
		{
			"r",
			function()
				if vim.o.relativenumber == true then
					vim.o.relativenumber = false
				else
					vim.o.number = true
					vim.o.relativenumber = true
				end
			end,
			{ desc = "relativenumber" },
		},
		{
			"v",
			function()
				if vim.o.virtualedit == "all" then
					vim.o.virtualedit = "block"
				else
					vim.o.virtualedit = "all"
				end
			end,
			{ desc = "virtualedit" },
		},
		{
			"i",
			function()
				if vim.o.list == true then
					vim.o.list = false
				else
					vim.o.list = true
				end
			end,
			{ desc = "show invisible" },
		},
		{
			"s",
			function()
				if vim.o.spell == true then
					vim.o.spell = false
				else
					vim.o.spell = true
				end
			end,
			{ exit = false, desc = "spell" },
		},
		{
			"w",
			function()
				if vim.o.wrap ~= true then
					vim.o.wrap = true
					-- Dealing with word wrap:
					-- If cursor is inside very long line in the file than wraps
					-- around several rows on the screen, then 'j' key moves you to
					-- the next line in the file, but not to the next row on the
					-- screen under your previous position as in other editors. These
					-- bindings fixes this.
					vim.keymap.set(
						"n",
						"k",
						function() return vim.v.count > 0 and "k" or "gk" end,
						{ expr = true, desc = "k or gk" }
					)
					vim.keymap.set(
						"n",
						"j",
						function() return vim.v.count > 0 and "j" or "gj" end,
						{ expr = true, desc = "j or gj" }
					)
				else
					vim.o.wrap = false
					vim.keymap.del("n", "k")
					vim.keymap.del("n", "j")
				end
			end,
			{ desc = "wrap" },
		},
		{
			"c",
			function()
				if vim.o.cursorline == true then
					vim.o.cursorline = false
				else
					vim.o.cursorline = true
				end
			end,
			{ desc = "cursor line" },
		},
		{ "jj", nil, { exit = true } },
		{ "c", nil, { exit = true } },
	},
}

-- }}}

-- }}}

-- }}}
-- lsp {{{

lspsignature.setup {}
toggleDiagonstics.init()

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end, opts)
	end,
})

mason.setup {
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
}

mason_lsp.setup {
	ensure_installed = {
		"gopls",
		"tsserver",
		"rust_analyzer",
	},
}
--
-- lspconfig.jsonls.setup {
-- 	settings = {
-- 		json = {
-- 			schemas = schemastore.json.schemas(),
-- 			validate = { enable = true },
-- 		},
-- 	},
-- }
--
-- lspconfig.yamlls.setup {
-- 	settings = {
-- 		yaml = {
-- 			schemas = schemastore.yaml.schemas(),
-- 		},
-- 	},
-- }
--
--
-- local has_words_before = function()
-- 	unpack = unpack or table.unpack
-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
-- end
--
-- cmp.setup {
-- 	sources = {
-- 		{ name = "nvim_lsp" },
-- 		{ name = "luasnip" },
-- 	},
-- 	mapping = {
-- 		["<CR>"] = cmp.mapping.confirm { select = true },
-- 		["<Tab>"] = cmp.mapping(function(fallback)
-- 			if cmp.visible() then
-- 				-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
-- 				-- that way you will only jump inside the snippet region
-- 				cmp.select_next_item()
-- 			elseif luasnip.expand_or_jumpable() then
-- 				luasnip.expand_or_jump()
-- 			elseif has_words_before() then
-- 				cmp.complete()
-- 			else
-- 				fallback()
-- 			end
-- 		end, { "i", "s" }),
-- 		["<S-Tab>"] = cmp.mapping(function(fallback)
-- 			if cmp.visible() then
-- 				cmp.select_prev_item()
-- 			elseif luasnip.jumpable(-1) then
-- 				luasnip.jump(-1)
-- 			else
-- 				fallback()
-- 			end
-- 		end, { "i", "s" }),
-- 	},
-- }
--
-- lsp.on_attach(on_attach)
--
-- lsp.preset {
-- 	name = "recommended",
-- 	manage_nvim_cmp = {
-- 		set_sources = "recommended",
-- 	},
-- 	set_lsp_keymaps = true,
-- 	suggest_lsp_servers = true,
-- }
--
-- lsp.setup_nvim_cmp {
-- 	sources = {
-- 		{ name = "path" },
-- 		{ name = "nvim_lsp" },
-- 		{ name = "buffer", keyword_length = 3 },
-- 		{ name = "luasnip", keyword_length = 2 },
-- 	},
-- 	formatting = {
-- 		mode = "symbol",
-- 		fields = { "menu", "abbr", "kind" },
-- 		format = lspkind.cmp_format {
-- 			mode = "symbol",
-- 			maxwidth = 50,
-- 			ellipsis_char = "...",
-- 			before = function(entry, item)
-- 				local menu_icon = {
-- 					nvim_lsp = "",
-- 					luasnip = "",
-- 					buffer = "",
-- 					path = "",
-- 					nvim_lua = "",
-- 				}
-- 				item.menu = menu_icon[entry.source.name]
-- 				return item
-- 			end,
-- 		},
-- 	},
-- }
--
-- lsp.nvim_workspace()
-- lsp.setup()
--
require("nvim-treesitter.configs").setup {
	ensure_installed = { "go", "lua", "vim", "vimdoc", "typescript", "tsx", "query" },
	highlight = {
		enable = true,
	},
	endwise = { enable = true },
	context_commentstring = {
		enable = true,
	},
}

vim.cmd [[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()]]

-- }}}
-- ui {{{

-- icons {{{

local icons = {
	kind = {},
	ui = {
		Thunder = "󱐋",
		Dot = " ●  ",
		Save = " 󰆓 ",
	},
	separators = {
		triangles = {
			left = " ",
		},
		circles = {
			right = " ",
		},
		none = "",
	},
	diagnostics = {},
	misc = {},
}

-- }}}
-- colorscheme {{{

-- catppuccin.setup {
--     flavour = "mocha",
--     transparent_background = true
-- }
--
-- vim.cmd.colorscheme "catppuccin"

local onedark = require "onedark"

onedark.setup = {
	style = "cool",
	transparent = true,
	term_colors = true,
	code_style = {
		comments = "italic",
		keywords = "none",
		functions = "none",
		strings = "none",
		variables = "none",
	},
	lualine = {
		transparent = true,
	},
}

onedark.load()
vim.cmd.colorscheme "onedark"

-- }}}
-- lualine {{{

lualine.setup {
	options = {
		icons_enabled = true,
		globalstatus = true,
		component_separators = "|",
		section_separators = {
			left = icons.separators.triangles.left,
			right = icons.separators.circles.right,
		},
	},
	sections = {
		lualine_a = {
			{
				function() return icons.ui.Thunder end,
				separator = { right = icons.separators.none },
			},
		},
		lualine_b = {
			{
				path = 1,
				symbols = {
					modified = icons.ui.Save,
					alternate_file = "[-]", -- Text to show to identify the alternate file
				},
				"filename",
			},
		},
		lualine_c = {
			{
				"branch",
				icon = { "" },
			},
		},
		lualine_x = {
			{ "selectioncount" },
			{ "searchcount" },
		},
		lualine_y = {
			{
				"diagnostics",
				symbols = { error = " ", warn = " ", info = " " },
			},
			"filetype",
			{
				icon = "󰞔",
				"bo:tabstop",
			},
			{
				"require'lsp-status'.status()",
			},
		},
		lualine_z = { "progress", "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
}

-- -- }}}

-- }}}
-- dap {{{

-- require("persistent-breakpoints").setup {
-- 	load_breakpoints_event = { "BufReadPost" },
-- }

dapui.setup {}

local map = vim.keymap.set
map("n", "]d", require("goto-breakpoints").next, {})
map("n", "[d", require("goto-breakpoints").prev, {})

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = { os.getenv "HOME" .. "/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js" },
}
dap.configurations.javascript = {
	{
		name = "Launch",
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
	{
		-- For this to work you need to make sure the node process is started with the `--inspect` flag.
		name = "Attach to process",
		type = "node2",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}

dap.adapters.go = {
	type = "executable",
	command = "node",
	args = { os.getenv "HOME" .. "/dev/golang/vscode-go/dist/debugAdapter.js" },
}
dap.configurations.go = {
	{
		type = "go",
		name = "Debug",
		request = "launch",
		showLog = false,
		program = "${file}",
		dlvToolPath = "/usr/bin/delv", -- vim.fn.exepath('dlv')  -- Adjust to where delve is installed
	},
}

require("dap-vscode-js").setup {
	-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
	-- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
	-- debugger_cmd = { "js-debug-adapter" }, -- Command to  to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
	-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
	-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
	-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
}

for _, language in ipairs { "typescript", "javascript" } do
	require("dap").configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Debug Jest Tests",
			-- trace = true, -- include debugger info
			runtimeExecutable = "node",
			runtimeArgs = {
				"./node_modules/jest/bin/jest.js",
				"--runInBand",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
		},
	}
end

require("gopher.dap").setup()

-- }}}
-- spelling {{{

vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- }}}
-- snippets {{{

-- autocmd BufNewFile  *.py 0r ~/.config/nvim/snippets/python.txt
-- autocmd BufNewFile  *.html 0r ~/.config/nvim/snippets/html5.html

-- }}}
