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
--}}}

-- text object plugins {{{

use 'tpope/vim-commentary'
use 'tpope/vim-repeat'
use 'tpope/vim-surround'

-- }}}

-- text manipulation {{{

use 'godlygeek/tabular'
use 'alvan/vim-closetag'

-- }}}

-- telescope {{{

use {
    'nvim-telescope/telescope.nvim',
    requires = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim'
    }
}

-- }}}

-- look pretty {{{

use 'sainnhe/everforest'

use 'nvim-treesitter/nvim-treesitter'
use 'sheerun/vim-polyglot'
use 'hoob3rt/lualine.nvim'

use { 'lukas-reineke/indent-blankline.nvim' }
use 'luochen1990/rainbow'
use 'jeffkreeftmeijer/vim-numbertoggle'
use 'machakann/vim-highlightedyank'
use 'RRethy/vim-illuminate'
use 'karb94/neoscroll.nvim'

-- }}}

-- version control {{{

use {
  'lewis6991/gitsigns.nvim',
  requires = {
    'nvim-lua/plenary.nvim'
  }
}
use 'tpope/vim-fugitive'
use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

-- }}}

-- haskell {{{
use { 'eagletmt/neco-ghc', ft = { 'haskell' } }
use { 'dag/vim2hs', ft = { 'haskell' } }
use { 'Twinside/vim-hoogle', ft = { 'haskell' } }
use { 'cloudhead/neovim-ghcid', ft = { 'haskell' } }
use { 'alx741/vim-hindent', ft = { 'haskell' } }
use { 'parsonsmatt/intero-neovim', ft = { 'haskell' } }
use { 'neovimhaskell/haskell-vim', ft = { 'haskell' } }
use { 'eagletmt/ghcmod-vim', ft = { 'haskell' } }

-- nix {{{

use { 'LnL7/vim-nix', ft = { 'nix' } }

-- }}}

-- rust {{{

use { 'racer-rust/vim-racer', ft = { "rust" } }
use { 'rust-lang/rust.vim', ft = { "rust" } }

-- }}}

-- other plugins {{{
  -- use 'kristijanhusak/vim-multiple-cursors'
  -- 
  -- use 'junegunn/gv.vim'
  -- use 'MattesGroeger/vim-bookmarks'
  -- use 'honza/vim-snippets'

  -- use {
  --   'mg979/vim-visual-multi',
  --   branch = 'master'
  -- }

  -- use {
  --   'plasticboy/vim-markdown'
  -- }

  -- use 'w0rp/ale'


 use { 'HerringtonDarkholme/yats.vim', ft = { "typescript" } }
 use { 'pangloss/vim-javascript', ft = { 'typescript' } }
 use { 'leafgarland/typescript-vim', ft = { "typescript" } }
 use { 'peitalin/vim-jsx-typescript', ft = { "typescript" } }
 use { 'styled-components/vim-styled-components', branch='main', ft = { "typescript" } }
 use { 'jparise/vim-graphql', ft = { "graphql" } }


  -- use 'vim-test/vim-test'

  -- use 'szw/vim-maximizer'
  -- use 'hrsh7th/nvim-compe'

  use 'folke/which-key.nvim'
  use 'vifm/vifm.vim'
-- }}}

-- footer {{{
end

return require('packer').startup(SetupPlugins)

--- }}}

