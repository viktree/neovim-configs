local wk = require("which-key")

local mappings = {
  ["<space>"] = "previous file",
  ["/"] = "search",
  p = "find-file",
  g = {
    name = "git",
    s = "status"
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
    l = "line-numbers"
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
    o = "outline",
  },
  r = "rename",
  f = "fix",
  F = "telescope",
  q = "quit"
}

wk.register(mappings, { prefix = "<leader>" })

wk.setup {
  key_labels = {
    ["<space>"] = "SPC",
    ["<cr>"]    = "RET",
    ["<tab>"]   = "TAB",
  }
}

