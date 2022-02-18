local telescope = require 'telescope'

telescope.setup {
  defaults = {
    -- ...
  },
  pickers = {
    autocommands = { theme = "dropdown" },
    buffers      = { theme = "dropdown" },
    colorscheme  = { theme = "dropdown" },
    find_files   = { theme = "dropdown" },
    live_grep    = { theme = "dropdown" },
    git_files    = { theme = "dropdown" },
    help_tags    = { theme = "dropdown" },
    man_pages    = { theme = "dropdown" },
    oldfiles     = { theme = "dropdown" }
  },
  extensions = {
    -- ...
  }
}

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>fa', builtin.autocommands)
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fc', builtin.colorscheme)
-- vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
vim.keymap.set('n', '<leader>fm', builtin.man_pages)
vim.keymap.set('n', '<c-p>', function()
  local ok = builtin.git_files()
  if not ok then builtin.find_files() end
end)
vim.keymap.set('n', '<c-n>', builtin.oldfiles)
