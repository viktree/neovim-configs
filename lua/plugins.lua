--  vim: fdm=marker foldlevel=0 foldenable sw=2 ts=2 sts=2
-------------------------------------------------------------------------------------------
-- Neovim Configuration
-------------------------------------------------------------------------------------------

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

function SetupPlugins (use)
	use 'wbthomason/packer.nvim'

	use 'gpanders/editorconfig.nvim'
	use 'ntpeters/vim-better-whitespace'
	use 'direnv/direnv.vim'

	-- leader key bindings
  use 'folke/which-key.nvim'

	-- multiple language support
	use 'sheerun/vim-polyglot'
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}

	-- Load things faster
	use 'lewis6991/impatient.nvim'
	use {
			'dstein64/vim-startuptime',
			cmd = 'StartupTime'
	}

	-- move around faster
	use {
		'ethanholz/nvim-lastplace',
		config = function()
			require('nvim-lastplace').setup {}
		end,
	}
	use 'markonm/traces.vim'
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use {
		"windwp/nvim-autopairs",
			config = function() require("nvim-autopairs").setup {} end
	}
	use {
  'abecodes/tabout.nvim',
  config = function()
    require('tabout').setup {
    tabkey = '<Tab>',
    backwards_tabkey = '<S-Tab>',
    completion = false,
    tabouts = {
      {open = "'", close = "'"},
      {open = '"', close = '"'},
      {open = '`', close = '`'},
      {open = '(', close = ')'},
      {open = '[', close = ']'},
      {open = '{', close = '}'}
    },
	}
  end,
	wants = {'nvim-treesitter'}, -- or require if not used so far
	after = {'nvim-cmp'} -- if a completion plugin is using tabs load it before
}
	-- search highlighting
	use 'romainl/vim-cool'


	-- Indentation
	use { 'sbdchd/neoformat' }
	use 'lukas-reineke/indent-blankline.nvim'

	-- Version control
	use {
		'tpope/vim-fugitive',
		'lewis6991/gitsigns.nvim',
		{
			'TimUntersberger/neogit',
			cmd = 'Neogit',
			config = [[require('config.neogit')]]
		}
	}
	use { 'mbbill/undotree' }

	-- visual flair
  use 'nvim-web-devicons'
	use { 'rcarriga/nvim-notify' }
	use "karb94/neoscroll.nvim"
	use "machakann/vim-highlightedyank"
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

	-- Colorscheme
	use { 'shaunsingh/nord.nvim' }

	-- filemanangers
	use "vifm/vifm.vim"

	use 'nvim-lua/plenary.nvim'
	use 'windwp/nvim-spectre'

	use 'voldikss/vim-floaterm'

	-- lsp
	use {
		'VonHeikemen/lsp-zero.nvim',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-nvim-lua'},

			-- Snippets
			{'L3MON4D3/LuaSnip'},
			{'rafamadriz/friendly-snippets'},
		}
	}

	use {
		'folke/trouble.nvim',
		requires = 'nvim-tree/nvim-web-devicons',
		config = function()
			require('trouble').setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	}

	use 'David-Kunz/jester'

	use { "LinArcX/telescope-command-palette.nvim" }

	use { 'github/copilot.vim' }
	use {
		'numToStr/Comment.nvim',
		config = function ()
			require('Comment').setup()
		end
	}

	use {
    'tamton-aquib/duck.nvim',
    config = function()
        vim.keymap.set('n', '<leader>dd', function() require("duck").hatch() end, {})
        vim.keymap.set('n', '<leader>dk', function() require("duck").cook() end, {})
    end
	}

	if packer_bootstrap then
		require('packer').sync()
	end
end

return SetupPlugins
