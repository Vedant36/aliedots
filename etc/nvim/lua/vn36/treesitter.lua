local treesitter = require 'nvim-treesitter.configs'

treesitter.setup {
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "css",
    "go",
    "haskell",
    "html",
    "javascript",
    "java",
    "json",
    "latex",
    "lua",
    "make",
    "python",
    "rust",
    "vim",
    "yaml",
  },
  -- autopairs = { enable = true },
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = true,
  },
  -- indent = { enable = true },
  context_commentstring = {
    enable = true
  },
  -- -- just stopped working and im sleepy, aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
  -- rainbow = {
  --   enable = true,
  --   extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
  -- }
}

