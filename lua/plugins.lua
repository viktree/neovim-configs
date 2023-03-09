--  vim: fdm=marker foldlevel=0 foldenable sw=4 ts=4 sts=4
-------------------------------------------------------------------------------------------
-- Neovim Configuration
-------------------------------------------------------------------------------------------

-- ensure packer {{{
--
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end
--
-- }}}

function SetupPlugins(use)
    use "wbthomason/packer.nvim"

    use "gpanders/editorconfig.nvim"
    use "ntpeters/vim-better-whitespace"
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
    use {"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}}
    use "Weissle/persistent-breakpoints.nvim"
    use "ofirgall/goto-breakpoints.nvim"
    use {"mxsdev/nvim-dap-vscode-js", requires = {"mfussenegger/nvim-dap"}}
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
    --
    use "sbdchd/neoformat"
    use "lukas-reineke/indent-blankline.nvim"
    --
    -- }}}

    -- key bindings {{{
    --
    use "folke/which-key.nvim"
    --
    -- }}}

    -- load things faster {{{
    --
    use "lewis6991/impatient.nvim"
    use {
        "dstein64/vim-startuptime",
        cmd = "StartupTime"
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

    -- move around faster
    use {
        "ethanholz/nvim-lastplace",
        config = function()
            require("nvim-lastplace").setup {}
        end
    }
    use "markonm/traces.vim"
    use {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        requires = {{"nvim-lua/plenary.nvim"}}
    }
    use {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {}
        end
    }

    -- visual flair
    use "nvim-tree/nvim-web-devicons"
    use "rcarriga/nvim-notify"
    use "karb94/neoscroll.nvim"
    use "machakann/vim-highlightedyank"
    use {
        "nvim-lualine/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons", opt = true}
    }
    use {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
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

return SetupPlugins
