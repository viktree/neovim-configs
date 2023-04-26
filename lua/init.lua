--  vim: fdm=marker foldlevel=0 foldenable sw=4 ts=4 sts=4
-------------------------------------------------------------------------------
-- Neovim Configuration
-------------------------------------------------------------------------------

local theme = "catppuccin"

vim.opt.termguicolors = true
vim.opt.cmdheight = 2
vim.opt.foldenable = true
vim.cmd [[
set foldcolumn=2
]]

local add_neovim_cmd = function (name, action)
    vim.api.nvim_create_user_command(name, action, {})
end

local remove_neovim_cmd = function (oldname)
    vim.api.nvim_create_user_command(oldname, '', {})
    vim.api.nvim_del_user_command(oldname)
end

local add_neovim_cmd = function (name, action)
    vim.api.nvim_create_user_command(name, action, {})
end

local remove_neovim_cmd = function (oldname)
    vim.api.nvim_create_user_command(oldname, '', {})
    vim.api.nvim_del_user_command(oldname)
end

-- packer {{{

-- ensure packer {{{
--

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system(
            {
                "git",
                "clone",
                "--depth",
                "1",
                "https://github.com/wbthomason/packer.nvim",
                install_path
            }
        )
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

--
-- }}}

function SetupPlugins(use)
    use "wbthomason/packer.nvim"

    use "direnv/direnv.vim"

    -- colorscheme {{{
    --
    use "shaunsingh/nord.nvim"
    --
    -- }}}

    -- copilot {{{
    --
    use "github/copilot.vim"
    --
    -- }}}

    -- debugging {{{
    --
    use "mfussenegger/nvim-dap"
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    use "Weissle/persistent-breakpoints.nvim"
    use "ofirgall/goto-breakpoints.nvim"
    use { "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } }
    use {
        "microsoft/vscode-js-debug",
        opt = true,
        run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
    }
    --
    -- }}}

    -- find, replace {{{
    --
    use "romainl/vim-cool"
    use "windwp/nvim-spectre"
    --
    -- }}}

    -- file manangers {{{
    --
    use "vifm/vifm.vim"
    --
    -- }}}

    -- indentation {{{

    use "gpanders/editorconfig.nvim"
    use "ntpeters/vim-better-whitespace"
    use "sbdchd/neoformat"
    use "lukas-reineke/indent-blankline.nvim"

    -- }}}

    -- key bindings {{{
    --
    use "folke/which-key.nvim"
    use "anuvyklack/hydra.nvim"
    --
    -- }}}

    -- load things faster {{{
    --
    use "lewis6991/impatient.nvim"
    use {
        "dstein64/vim-startuptime",
        cmd = "StartupTime"
    }
    use {
        "ethanholz/nvim-lastplace",
        config = function()
            require("nvim-lastplace").setup {}
        end
    }
    --
    -- }}}

    -- lsp {{{
    --
    use {
        "VonHeikemen/lsp-zero.nvim",
        requires = {
            -- LSP Support
            {"neovim/nvim-lspconfig"},
            {"williamboman/mason.nvim"},
            {"williamboman/mason-lspconfig.nvim"},
            -- Autocompletion
            {"hrsh7th/nvim-cmp"},
            {"hrsh7th/cmp-buffer"},
            {"hrsh7th/cmp-path"},
            {"saadparwaiz1/cmp_luasnip"},
            {"hrsh7th/cmp-nvim-lsp"},
            {"hrsh7th/cmp-nvim-lua"},
            -- Snippets
            {"L3MON4D3/LuaSnip"},
            {"rafamadriz/friendly-snippets"}
        }
    }
    use "onsails/lspkind.nvim"
    --
    -- }}}

    -- syntax highlighting {{{
    --
    use "sheerun/vim-polyglot"
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    --
    -- }}}

    -- testing {{{
    --
    use "David-Kunz/jester"
    --
    -- }}}

    -- version control {{{
    --
    use {
        "tpope/vim-fugitive",
        "lewis6991/gitsigns.nvim",
        {
            "TimUntersberger/neogit",
            cmd = "Neogit",
            config = [[require('config.neogit')]]
        }
    }
    use {"mbbill/undotree"}
    --
    -- }}}

    -- visual flair {{{
    use "nvim-tree/nvim-web-devicons"
    use "rcarriga/nvim-notify"
    use "karb94/neoscroll.nvim"
    use "machakann/vim-highlightedyank"
    use {"catppuccin/nvim", as = "catppuccin"}
    use "xiyaowong/transparent.nvim"
    use {
        "m4xshen/smartcolumn.nvim",
        config = function()
            require("smartcolumn").setup {
                colorcolumn = {"80", "120"}
            }
        end
    }
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true }
    }
    use {
        "weilbith/nvim-code-action-menu",
        cmd = "CodeActionMenu"
    }
    --
    -- }}}

    use "chentoast/marks.nvim"

    -- move around faster
    use "markonm/traces.vim"
    use {
        "nvim-telescope/telescope.nvim",
        tag = "0.2.0",
        requires = {{"nvim-lua/plenary.nvim"}}
    }
    use {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {}
        end
    }
    use "nvim-lua/plenary.nvim"
    use "voldikss/vim-floaterm"
    use "kosayoda/nvim-lightbulb"
    use {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup {}
        end
    }

    use {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    }

    -- bootstrap packer {{{
    --
    if packer_bootstrap then
        require("packer").sync()
    end
    --
    -- }}}
end

require("packer").startup(SetupPlugins)

require("nvim-treesitter.configs").setup {
    endwise = {enable = true}
}
require("spectre").setup()

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

vim.cmd [[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()]]

-- }}}

-- keybindings {{{
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.cmd[[
ino jj <esc>
cno jj <c-c>

nnoremap f <cmd>CodeActionMenu<cr>
]]

-- leader mappings {{{

local wk = require("which-key")

local mappings = {
    ["<space>"] = "previous file",
    ["/"] = "replace",
    ["."] = {"<cmd>Neoformat<cr>", "format"},
    S = {"<cmd>lua require('spectre').open()<cr>", "Spectre search"},
    p = "find-file",
		d = {
			name = 'debug',
			v = "<cmd>lua require('dapui').open()",
			d = {'<cmd>DapToggleBreakpoint<cr>', 'toggle'}
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

-- }}}

-- telescope {{{

require('telescope').setup{
}

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

require('packer').startup(SetupPlugins)

vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])


require('nvim-autopairs').setup()
require('nvim-treesitter.configs').setup {
	endwise = {
		enable = true,
	},
}
require('spectre').setup()

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
command! Vimrc e $XDG_CONFIG_HOME/nvim/lua/init.lua
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

-- aliases {{{

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


if executable('kubectx')
  command! Kubectx FloatermNew --autoclose=0 kubectx
endif

if executable('kubenv')
  command! Kubenv FloatermNew --autoclose=0 kubenv
endif

command! Fmt Neoformat

]])


--}}}

-- colorscheme {{{

local theme = 'nord'

vim.g.nord_disable_background = true
vim.g.nord_italic = true
vim.g.nord_bold = true

require(theme).set()
vim.cmd[[colorscheme nord]]

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

-- dap {{{

require('persistent-breakpoints').setup{
	load_breakpoints_event = { "BufReadPost" }
}

require("dapui").setup()

local map = vim.keymap.set
map('n', ']d', require('goto-breakpoints').next, {})
map('n', '[d', require('goto-breakpoints').prev, {})

local dap = require('dap')
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js'},
}
dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  },
}

require("dap-vscode-js").setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

for _, language in ipairs({ "typescript", "javascript" }) do
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
      processId = require'dap.utils'.pick_process,
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
    }
  }
end


-- }}}

-- refactoring {{{

vim.g.neoformat_try_node_exe = 1

-- }}}
