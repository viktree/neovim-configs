
function SetupPlugins()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    opt = true
  }

  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'kristijanhusak/vim-multiple-cursors'
  use 'tpope/vim-fugitive'
  use 'jreybert/vimagit'
  -- use 'mhinz/vim-signify' -- lewis6991/gitsigns.nvim ?
  use 'junegunn/gv.vim'
  use 'MattesGroeger/vim-bookmarks'
  use 'honza/vim-snippets'

  use { 'eagletmt/neco-ghc', ft = { 'haskell' } }
  use { 'dag/vim2hs', ft = { 'haskell' } }
  use { 'Twinside/vim-hoogle', ft = { 'haskell' } }
  use { 'cloudhead/neovim-ghcid', ft = { 'haskell' } }
  use { 'alx741/vim-hindent', ft = { 'haskell' } }
  use { 'parsonsmatt/intero-neovim', ft = { 'haskell' } }
  use { 'neovimhaskell/haskell-vim', ft = { 'haskell' } }
  use { 'eagletmt/ghcmod-vim', ft = { 'haskell' } }

  use 'LnL7/vim-nix'

  use {
    'mg979/vim-visual-multi',
    branch = 'master'
  }

  use {
    'plasticboy/vim-markdown'
  }

  use 'hashivim/vim-terraform'
  use 'sheerun/vim-polyglot'
  use 'alvan/vim-closetag'

  use 'w0rp/ale'

  use {
    'fatih/vim-go', 
    ft = { 'go' },
    run = ':GoUpdateBinaries' 
  }

  use {
    'metakirby5/codi.vim',
    ft = { 'python', 'javascript', 'typescript', 'ghci', 'lua', 'julia', 'elm', 'elixir' }
  }

  use {
    'tmhedberg/SimpylFold',
    ft = { 'python' },
  }

  -- Rust
  use {
   'racer-rust/vim-racer',
   ft = { "rust" }
  }
  use {
   'rust-lang/rust.vim',
   ft = { "rust" }

  }


   use { 'HerringtonDarkholme/yats.vim', ft = { "typescript" } }
   use { 'pangloss/vim-javascript', ft = { 'typescript' } }
   use { 'leafgarland/typescript-vim', ft = { "typescript" } }
   use { 'peitalin/vim-jsx-typescript', ft = { "typescript" } }
   use { 'styled-components/vim-styled-components', branch='main', ft = { "typescript" } }
   use { 'jparise/vim-graphql', ft = { "graphql" } }


  -- elixir plugins
  use {
    'elixir-editors/vim-elixir',
    ft = { 'elixir' }
  }
  use {
    'carlosgaldino/elixir-snippets',
    ft = { 'elixir' }
  }
  use {
    'avdgaag/vim-phoenix',
    ft = { 'elixir' }
  }
  use {
    'mmorearty/elixir-ctags',
    ft = { 'elixir' }
  }
  use {
    'mattreduce/vim-mix',
    ft = { 'elixir' }
  }
  use {
    'BjRo/vim-extest',
    ft = { 'elixir' }
  }
  use {
    'frost/vim-eh-docs',
    ft = { 'elixir' }
  }


  use 'editorconfig/editorconfig-vim'
  use 'sbdchd/neoformat'
  use 'godlygeek/tabular'

  use 'luochen1990/rainbow'
  use 'jeffkreeftmeijer/vim-numbertoggle'
  use 'sainnhe/everforest'
  use 'lifepillar/vim-gruvbox8'
  use 'machakann/vim-highlightedyank'
  use 'RRethy/vim-illuminate'
  use 'karb94/neoscroll.nvim'

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  use {
      'lukas-reineke/indent-blankline.nvim',
      branch = "lua",
  }

  use 'hoob3rt/lualine.nvim'

  use {
      'nvim-telescope/telescope.nvim',
      requires = {
          'nvim-lua/popup.nvim',
          'nvim-lua/plenary.nvim'
      }
  }


  use 'vim-test/vim-test'

  use 'szw/vim-maximizer'
  use 'hrsh7th/nvim-compe'

  use 'folke/which-key.nvim'
  use 'vifm/vifm.vim'

  use {
    'neoclide/coc.nvim',
    branch = 'release'
  }

  use 'akinsho/nvim-bufferline.lua'
  -- use 'romgrk/barbar.nvim'
  use 'ntpeters/vim-better-whitespace'
  use 'ap/vim-css-color'
end

local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])
if not packer_exists then
	if vim.fn.input("Install packer.nvim? (y for yada)") ~= "y" then
		return
	end

	local directory = string.format(
	'%s/site/pack/packer/opt/',
	vim.fn.stdpath('data')
	)

	vim.fn.mkdir(directory, 'p')

	local git_clone_cmd = vim.fn.system(string.format(
	'git clone %s %s',
	'https://github.com/wbthomason/packer.nvim',
	directory .. '/packer.nvim'
	))

	print(git_clone_cmd)
	print("Installing packer.nvim...")

	return
end


return require('packer').startup(SetupPlugins)
