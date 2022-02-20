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
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
    }
  }
}
require('telescope').load_extension('fzf')

local builtin = require 'telescope.builtin'
local map = vim.keymap.set
map('n', '<leader>fa', builtin.autocommands)
map('n', '<leader>fb', builtin.buffers)
map('n', '<leader>fc', builtin.colorscheme)
map('n', '<leader>ff', builtin.find_files)
map('n', '<leader>fg', builtin.live_grep)
map('n', '<leader>fh', builtin.help_tags)
map('n', '<leader>fm', function()
  builtin.man_pages {sections={"1","2","3","4","5","6","7","8","9"}}
end)
map('n', '<leader>fo', builtin.oldfiles)
map('n', '<leader>fs', function() builtin.grep_string {search = ''} end)
map('n', '<c-p>', function()
  local ok = pcall(builtin.git_files)
  if not ok then builtin.find_files() end
end)
