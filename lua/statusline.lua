local lualine = require 'lualine'

local config = {
  options = {
    icons_enabled = false,
    theme = "everforest"
  },
  sections = {
    lualine_a = {'mode', 'paste' },
    lualine_b = {'filename', 'readonly', 'modified'},
    lualine_c = {'branch', 'g:coc_status' },
    lualine_x = {'encoding' },
    lualine_y = {'progress', 'location'},
    lualine_z = {'filetype'}
  },
}

lualine.setup(config)

