local telescope = require 'telescope'

telescope.setup {
  defaults = {
    -- ...
  },
  pickers = {
    find_files   = {
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
    },
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      mappings = {
        ["n"] = {
          -- ["h"] = "change_cwd",
          ["l"] = "select_default",
          -- ["."] = "toggle_hidden"
        },
      }
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
    }
  }
}
require("telescope").load_extension "file_browser"
require('telescope').load_extension('fzf')

local builtin = require 'telescope.builtin'
local themes = require 'telescope.themes'
local map = vim.keymap.set
-- wrapper to set theme ivy to all pickers
local wrap = setmetatable({}, {
  __index = function(_, picker)
    return function(opts)
      opts = themes.get_ivy(opts)
      builtin[picker](opts)
    end
  end
})

map('n', '<leader>e' , telescope.extensions.file_browser.file_browser)
map('n', '<leader>fa', wrap.autocommands)
map('n', '<leader>fb', wrap.buffers)
map('n', '<leader>fc', wrap.colorscheme)
map('n', '<leader>ff', wrap.find_files)
map('n', '<leader>fg', wrap.live_grep)
map('n', '<leader>fh', wrap.help_tags)
-- giv me thems all yer fookin manuals
map('n', '<leader>fm', function()
  wrap.man_pages {sections={"1","2","3","4","5","6","7","8","9"}}
end)
map('n', '<leader>fo', wrap.oldfiles)
map('n', '<leader>fs', function() wrap.grep_string {search = ''} end)
map('n', '<leader>ft', wrap.treesitter)
-- if in a git repo run git_files else find_files
map('n', '<c-p>', function()
  local ok = pcall(wrap.git_files)
  if not ok then wrap.find_files() end
end)
