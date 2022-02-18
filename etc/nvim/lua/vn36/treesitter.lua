local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not ok then
  return
end

treesitter.setup {
  ensure_installed = {
    "bash",
    "cpp",
    "css",
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
  indent = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  }
}

