--  vim: fdm=marker foldlevel=0 foldenable sw=2 ts=2 sts=2
-------------------------------------------------------------------------------------------

-- header {{{
function SetupPlugins()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
-- }}}

-- editor essentials {{{
use 'editorconfig/editorconfig-vim'
use 'ntpeters/vim-better-whitespace'
use 'direnv/direnv.vim'

-- sudo
use 'lambdalisue/suda.vim'

-- lsp
use 'neovim/nvim-lspconfig'
use 'onsails/lspkind-nvim'
use 'nvim-lua/lsp-status.nvim'

-- leader key bindings
use 'folke/which-key.nvim'

--}}}

-- profiling {{{

use {
  "dstein64/vim-startuptime",
  cmd = "StartupTime"
}

-- }}}

-- more vim like {{{

use 'tpope/vim-commentary'
use 'tpope/vim-repeat'
use 'tpope/vim-surround'
use 'tpope/vim-eunuch'
use 'tpope/vim-endwise'
use 'tpope/vim-sleuth'

use 'tversteeg/registers.nvim'

-- }}}

-- text manipulation {{{

use 'godlygeek/tabular'
use 'alvan/vim-closetag'

-- }}}

-- autocomplete {{{

 -- Autocomplete
use 'hrsh7th/nvim-compe'
use 'SirVer/ultisnips'
use 'honza/vim-snippets'
use 'windwp/nvim-autopairs'
use 'AndrewRadev/tagalong.vim'
use 'andymass/vim-matchup'

-- }}}

-- switch files {{{

use 'MattesGroeger/vim-bookmarks'
use 'vifm/vifm.vim'

use {
    'nvim-telescope/telescope.nvim',
    requires = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim'
    }
}

-- }}}

-- testing {{{
use { "rcarriga/vim-ultest", requires = {"vim-test/vim-test"}, run = ":UpdateRemotePlugins" }
-- }}}

-- look pretty {{{

-- use 'sainnhe/everforest'
-- use { 'christianchiarulli/nvcode-color-schemes.vim' }
use { 'sainnhe/gruvbox-material' }

-- use 'nvim-treesitter/nvim-treesitter'
-- use 'sheerun/vim-polyglot'
use 'hoob3rt/lualine.nvim'

use 'luochen1990/rainbow'
use 'jeffkreeftmeijer/vim-numbertoggle'
use 'machakann/vim-highlightedyank'
use 'RRethy/vim-illuminate'
use 'karb94/neoscroll.nvim'
use 'folke/todo-comments.nvim'

-- }}}

-- version control {{{

use {
  'lewis6991/gitsigns.nvim',
  requires = {
    'nvim-lua/plenary.nvim'
  }
}
use 'tpope/vim-fugitive'
use {
  'TimUntersberger/neogit',
  requires = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim'
  }
}

-- }}}

-- filetype specific {{{

use 'sbdchd/neoformat'

-- css {{{
use 'norcalli/nvim-colorizer.lua'
-- }}}
-- graphql {{{

use { 'jparise/vim-graphql', ft = { "graphql" } }

-- }}}
-- haskell {{{
--
use { 'eagletmt/neco-ghc', ft = { 'haskell' } }
use { 'dag/vim2hs', ft = { 'haskell' } }
use { 'Twinside/vim-hoogle', ft = { 'haskell' } }
use { 'cloudhead/neovim-ghcid', ft = { 'haskell' } }
use { 'alx741/vim-hindent', ft = { 'haskell' } }
use { 'parsonsmatt/intero-neovim', ft = { 'haskell' } }
use { 'neovimhaskell/haskell-vim', ft = { 'haskell' } }
use { 'eagletmt/ghcmod-vim', ft = { 'haskell' } }

-- }}}
-- idris {{{

use 'edwinb/idris2-vim'

-- }}}
-- markdown {{{

use 'plasticboy/vim-markdown'

-- }}}
-- nix {{{

use { 'LnL7/vim-nix', ft = { 'nix' } }

-- }}}
-- rust {{{

use { 'racer-rust/vim-racer', ft = { "rust" } }
use { 'rust-lang/rust.vim', ft = { "rust" } }

-- }}}
-- typescript {{{

 use { 'HerringtonDarkholme/yats.vim', ft = { "typescript" } }
 use { 'pangloss/vim-javascript', ft = { 'typescript' } }
 use { 'leafgarland/typescript-vim', ft = { "typescript" } }
 use { 'peitalin/vim-jsx-typescript', ft = { "typescript" } }
 use { 'styled-components/vim-styled-components', branch='main', ft = { "typescript" } }

-- }}}

-- }}}

-- other plugins {{{
  -- use 'junegunn/gv.vim'
  -- use 'honza/vim-snippets'
  -- use {
  --   'mg979/vim-visual-multi',
  --   branch = 'master'
  -- }
  -- use 'vim-test/vim-test'
  -- use 'hrsh7th/nvim-compe'

-- }}}

-- footer {{{
end

return require('packer').startup(SetupPlugins)

--- }}}

