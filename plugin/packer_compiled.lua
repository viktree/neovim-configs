-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/vikram.v/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/vikram.v/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/vikram.v/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/vikram.v/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/vikram.v/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/editorconfig-vim"
  },
  everforest = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/everforest"
  },
  ["ghcmod-vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/opt/ghcmod-vim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["haskell-vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/opt/haskell-vim"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  ["intero-neovim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/opt/intero-neovim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["neco-ghc"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/opt/neco-ghc"
  },
  neogit = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/neogit"
  },
  ["neoscroll.nvim"] = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/neoscroll.nvim"
  },
  ["neovim-ghcid"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/opt/neovim-ghcid"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  rainbow = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/rainbow"
  },
  ["rust.vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/opt/rust.vim"
  },
  tabular = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/tabular"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["typescript-vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/opt/typescript-vim"
  },
  ["vifm.vim"] = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/vifm.vim"
  },
  ["vim-better-whitespace"] = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/vim-better-whitespace"
  },
  ["vim-closetag"] = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/vim-closetag"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-graphql"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-graphql"
  },
  ["vim-highlightedyank"] = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/vim-highlightedyank"
  },
  ["vim-hindent"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-hindent"
  },
  ["vim-hoogle"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-hoogle"
  },
  ["vim-illuminate"] = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/vim-illuminate"
  },
  ["vim-javascript"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-javascript"
  },
  ["vim-jsx-typescript"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-jsx-typescript"
  },
  ["vim-nix"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-nix"
  },
  ["vim-numbertoggle"] = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/vim-numbertoggle"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/vim-polyglot"
  },
  ["vim-racer"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-racer"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-styled-components"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-styled-components"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  vim2hs = {
    after_files = { "/Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim2hs/after/plugin/tabular_haskell.vim" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim2hs"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  },
  ["yats.vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/vikram.v/.local/share/nvim/site/pack/packer/opt/yats.vim"
  }
}

time([[Defining packer_plugins]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType haskell ++once lua require("packer.load")({'intero-neovim', 'neco-ghc', 'vim2hs', 'neovim-ghcid', 'vim-hindent', 'vim-hoogle', 'ghcmod-vim', 'haskell-vim'}, { ft = "haskell" }, _G.packer_plugins)]]
vim.cmd [[au FileType nix ++once lua require("packer.load")({'vim-nix'}, { ft = "nix" }, _G.packer_plugins)]]
vim.cmd [[au FileType rust ++once lua require("packer.load")({'rust.vim', 'vim-racer'}, { ft = "rust" }, _G.packer_plugins)]]
vim.cmd [[au FileType graphql ++once lua require("packer.load")({'vim-graphql'}, { ft = "graphql" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'vim-styled-components', 'typescript-vim', 'yats.vim', 'vim-javascript', 'vim-jsx-typescript'}, { ft = "typescript" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim2hs/ftdetect/cabalconfig.vim]], true)
vim.cmd [[source /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim2hs/ftdetect/cabalconfig.vim]]
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim2hs/ftdetect/cabalconfig.vim]], false)
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim2hs/ftdetect/heist.vim]], true)
vim.cmd [[source /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim2hs/ftdetect/heist.vim]]
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim2hs/ftdetect/heist.vim]], false)
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim2hs/ftdetect/hsc.vim]], true)
vim.cmd [[source /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim2hs/ftdetect/hsc.vim]]
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim2hs/ftdetect/hsc.vim]], false)
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim2hs/ftdetect/jmacro.vim]], true)
vim.cmd [[source /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim2hs/ftdetect/jmacro.vim]]
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim2hs/ftdetect/jmacro.vim]], false)
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/rust.vim/ftdetect/rust.vim]], true)
vim.cmd [[source /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/rust.vim/ftdetect/rust.vim]]
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/rust.vim/ftdetect/rust.vim]], false)
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/typescript-vim/ftdetect/typescript.vim]], true)
vim.cmd [[source /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/typescript-vim/ftdetect/typescript.vim]]
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/typescript-vim/ftdetect/typescript.vim]], false)
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-graphql/ftdetect/graphql.vim]], true)
vim.cmd [[source /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-graphql/ftdetect/graphql.vim]]
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-graphql/ftdetect/graphql.vim]], false)
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/yats.vim/ftdetect/typescript.vim]], true)
vim.cmd [[source /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/yats.vim/ftdetect/typescript.vim]]
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/yats.vim/ftdetect/typescript.vim]], false)
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/yats.vim/ftdetect/typescriptreact.vim]], true)
vim.cmd [[source /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/yats.vim/ftdetect/typescriptreact.vim]]
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/yats.vim/ftdetect/typescriptreact.vim]], false)
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-javascript/ftdetect/flow.vim]], true)
vim.cmd [[source /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-javascript/ftdetect/flow.vim]]
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-javascript/ftdetect/flow.vim]], false)
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-javascript/ftdetect/javascript.vim]], true)
vim.cmd [[source /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-javascript/ftdetect/javascript.vim]]
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-javascript/ftdetect/javascript.vim]], false)
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-jsx-typescript/ftdetect/typescript.vim]], true)
vim.cmd [[source /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-jsx-typescript/ftdetect/typescript.vim]]
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-jsx-typescript/ftdetect/typescript.vim]], false)
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-nix/ftdetect/nix.vim]], true)
vim.cmd [[source /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-nix/ftdetect/nix.vim]]
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/vim-nix/ftdetect/nix.vim]], false)
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/haskell-vim/ftdetect/haskell.vim]], true)
vim.cmd [[source /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/haskell-vim/ftdetect/haskell.vim]]
time([[Sourcing ftdetect script at: /Users/vikram.v/.local/share/nvim/site/pack/packer/opt/haskell-vim/ftdetect/haskell.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
