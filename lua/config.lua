--  vim: fdm=marker foldlevel=0 foldenable sw=2 ts=2 sts=2
-------------------------------------------------------------------------------------------

require("lib")

local cmd = vim.cmd
local setoption = vim.opt
local letg = vim.g

local colorscheme = "gruvbox-material"

local icons = require "nvim-nonicons"
icons.get("file")

-- general settings {{{

setoption.mouse = "a"

letg.rainbow_active = 1

-- clipboards {{{

cmd(
    [[
set clipboard+=unnamedplus " map nvim clipboard to system clipboard

" Sync with system clipboard files
if has('macunix') && executable("pbcopy")
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><cr>
endif
]]
)

-- }}}
-- keybindings {{{

cmd(
    [[
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
]]
)

-- }}}

-- }}}

-- setup plugin manager {{{
if MissingPacker() then
    InstallPacker()
end

require("plugins")

--- }}}

-- version control {{{

local vcConfig = {
    signs = {
        add = {hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn"},
        change = {hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn"},
        delete = {hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn"},
        topdelete = {hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn"},
        changedelete = {hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn"}
    },
    numhl = false,
    linehl = false,
    current_line_blame = false,
    current_line_blame_delay = 1000,
    current_line_blame_position = "eol",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    use_decoration_api = true,
    use_internal_diff = true -- If luajit is present
}
require("gitsigns").setup(vcConfig)

local neogitConfig = {
    integrations = {
        diffview = true
    }
}

require("neogit").setup(neogitConfig)

-- }}}

-- file management {{{

letg.EditorConfig_exclude_patterns = {"fugitive://.*", "scp://.*"}

cmd([[
if executable('vifm')
  let g:vifm_replace_netrw = 1
  nnoremap <bs> :Vifm<cr>
endif
]])

-- }}}

-- colorscheme {{{

cmd(
    [[

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

  highlight LspDiagnosticsSignError ctermbg=NONE
endfunction
]]
)

cmd("autocmd VimEnter * call SetColors('" .. colorscheme .. "')")

cmd("call SetColors('" .. colorscheme .. "')")

-- }}}

-- statusline {{{
local statuslineConfig = {
    options = {
        icons_enabled = true,
        theme = colorscheme,
        component_separators = {"", ""}
    },
    sections = {
        lualine_a = {"mode", "paste"},
        lualine_b = {"filename", "readonly", "modified"},
        lualine_c = {},
        lualine_x = {"branch", "b:gitsigns_status"},
        lualine_y = {"location"},
        lualine_z = {"filetype"}
    }
}

require("lualine").setup(statuslineConfig)
-- }}}

-- termimal mode {{{

cmd(
    [[
autocmd TermOpen * setlocal nonumber norelativenumber

tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l

]]
)

-- }}}

-- leader mappings {{{
local wk = require("which-key")

local mappings = {
    ["<space>"] = "previous file",
    ["/"] = "search",
    p = "find-file",
    g = {
        name = "git",
        s = {"<cmd>Neogit<cr>", "status"},
        c = {"<cmd>Neogit commit<cr>", "status"}
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
        l = {":set nu! rnu!", "line-numbers"}
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
        o = "outline"
    },
    r = "rename",
    f = "fix",
    F = "telescope",
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

cmd(
    [[
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
]]
)

-- }}}

-- bookmarks {{{

cmd(
    [[
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

]]
)

-- }}}

-- file associations {{{

cmd(
    [[

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

autocmd filetype markdown setlocal nonumber norelativenumber

]]
)

-- }}}

-- lsp {{{

local nvim_lsp = require("lspconfig")
local lsp_status = require("lsp-status")
local compe = require("compe")

lsp_status.register_progress()
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspKindConfig = {}

require("lspkind").init(lspKindConfig)

-- Diagnostics symbols for display in the sign column.
cmd("sign define LspDiagnosticsSignError text=e")
cmd("sign define LspDiagnosticsSignWarning text=w")
cmd("sign define LspDiagnosticsSignInformation text=i")
cmd("sign define LspDiagnosticsSignHint text=H")
cmd("setlocal omnifunc=v:lua.vim.lsp.omnifunc")

-- Some arbitrary servers
-- diagnosticls {{{
-- nvim_lsp.diagnosticls.setup {
--   on_attach = on_attach,
--   filetypes = vim.tbl_keys(filetypes),
--   init_options = {
--     filetypes = {
--       typescript = "prettier",
--       typescriptreact = "prettier"
--     },
--     formatters = {
--       prettier = {command = "prettier", args = {"--stdin-filepath", "%filepath"}}
--     },
--     formatFiletypes = {
--       typescript = "prettier",
--       typescriptreact = "prettier"
--     }
--   }
-- }
-- }}}
-- clangd {{{
nvim_lsp.clangd.setup(
    {
        handlers = lsp_status.extensions.clangd.setup(),
        init_options = {
            clangdFileStatus = true
        },
        on_attach = function()
            lsp_status.on_attach()
            lsp_compeltions.on_attach()
        end,
        capabilities = lsp_status.capabilities
    }
)
-- }}}
-- cssls {{{
nvim_lsp.cssls.setup {
    capabilities = capabilities
}
-- }}}
-- ghcid {{{
nvim_lsp.ghcide.setup(
    {
        on_attach = function()
            lsp_status.on_attach()
            lsp_compeltions.on_attach()
        end,
        capabilities = lsp_status.capabilities
    }
)
-- }}}
-- go {{{

nvim_lsp.gopls.setup({})

-- }}}
-- jsonls {{{
nvim_lsp.jsonls.setup {
    commands = {
        Format = {
            function()
                vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line("$"), 0})
            end
        }
    }
}
-- }}}
-- rust-analyzer {{{
nvim_lsp.rust_analyzer.setup(
    {
        on_attach = function()
            lsp_status.on_attach()
            lsp_compeltions.on_attach()
        end,
        capabilities = lsp_status.capabilities
    }
)
-- }}}
-- tsserver {{{

local buf_map = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(
        bufnr,
        mode,
        lhs,
        rhs,
        opts or
            {
                silent = true
            }
    )
end

local on_attach = function(client, bufnr)
    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
    vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
    vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
    vim.cmd("command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
    vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
    buf_map(bufnr, "n", "gd", ":LspDef<CR>")
    buf_map(bufnr, "n", "gr", ":LspRename<CR>")
    buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
    buf_map(bufnr, "n", "K", ":LspHover<CR>")
    buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
    buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
    buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>")
    buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
    buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")
end

nvim_lsp.tsserver.setup {
    on_attach = function(client, buffer)
        lsp_status.on_attach(client)
        client.resolved_capabilities.document_formatting = false

        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup(
            {
                eslint_bin = "eslint_d",
                eslint_enable_diagnostics = true,
                eslint_enable_code_actions = true,
                enable_formatting = true,
                formatter = "prettier"
            }
        )
        ts_utils.setup_client(client)
        buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
        buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
        buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
        on_attach(client, bufnr)
    end
}

require("null-ls").config({})
nvim_lsp["null-ls"].setup({on_attach = on_attach})

-- }}}

-- }}}

-- completions {{{

require("tabout").setup({})

setoption.completeopt = "menuone,noselect"

compe.setup(
    {
        enabled = true,
        autocomplete = true,
        documentation = true,
        min_length = 1,
        source = {
            path = true,
            buffer = true,
            calc = false,
            vsnip = true,
            nvim_lsp = true,
            nvim_lua = true,
            spell = true,
            tags = true,
            snippets_nvim = true,
            treesitter = false,
            ultisnips = false
        }
    }
)

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t("<C-n>")
    elseif check_back_space() then
        return t("<Tab>")
    else
        return vim.fn["compe#complete"]()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t("<C-p>")
    else
        return t("<S-Tab>")
    end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- }}}

-- refactoring {{{

local renamer = require('renamer')
renamer.setup({})
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>rn', '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })

-- }}}

-------------------------------------------------------------------------------------------
