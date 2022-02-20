-- Bootstrap begin {{{1
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap = (function()
  if fn.empty(fn.glob(install_path)) > 0 then
    local ran = fn.system
      {'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path}
    vim.cmd [[packadd packer.nvim]]
    return ran
  end
end)()

-- clean, update, install and compile on write {{{1
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]
-- }}}1

local packer = require 'packer'
-- }}}1
-- packer.startup
return packer.startup {function(use)

  -- Basic {{{1
  use 'wbthomason/packer.nvim'
  use 'lewis6991/impatient.nvim' -- improved startup time by >3x on my config
  use 'dstein64/vim-startuptime' -- profiling startup time
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
  -- Non-lua Plugins {{{1
  use 'tpope/vim-unimpaired' -- lots of useful keybinds
  use 'tpope/vim-surround'
  use {
    'tpope/vim-commentary',
    config = function()
      vim.keymap.set('n', '<leader>i', '<Plug>CommentaryLine')
      vim.keymap.set('n', '<leader>u', '<Plug>Commentary<Plug>Commentary')
      vim.keymap.set('v', '<leader>i', '<Plug>Commentary')
    end
  }
  -- use 'tpope/vim-repeat'
  use {
    'preservim/vim-markdown',
    ft = 'markdown',
    config = function()
      vim.g.vim_markdown_folding_disabled = 0
      vim.g.vim_markdown_folding_style_pythonic = 1
    end
  }
  use 'google/vim-searchindex'
  use {
    'junegunn/fzf',
    cmd = ':Rg',
    -- The post-hook gives the error /usr/share/vim/vimfiles/install not found
    -- run = ':call fzf#install()'
  }
  use 'junegunn/fzf.vim'
  -- Other Lua Plugins {{{1
  use 'folke/zen-mode.nvim'
  use { 'samirettali/shebang.nvim', event = 'BufNewFile' } -- auto add shebangs
  use {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require("notify")
      require 'notify'.setup { render = "minimal" }
    end
  }
  -- Gitsigns {{{1
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require 'vn36.gitsigns' end
  }
  -- Statusline and Bufferline {{{1
  use 'itchyny/lightline.vim'
  -- get a better statusline
  use {
    'mengelbrecht/lightline-bufferline',
    config = function()
      vim.cmd [[
let g:lightline#bufferline#enable_nerdfont = 1
let g:lightline#bufferline#show_number = 2
" let g:lightline#bufferline#unicode_symbols = 1
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#min_buffer_count = 2
" let g:lightline#bufferline#auto_hide = 400
      ]]
    end
  }
  -- use 'godlygeek/tabular'
  use {
    'bling/vim-bufferline', -- nice compact bufferline
    opt = true,
    config = function()
      vim.cmd [[
let bufferline = get(g:, 'bufferline', {})
let bufferline.auto_hide = v:true
let g:bufferline_rotate = 2
      ]]
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    opt = true,
    config = function() require 'vn36.lualine' end
  }
  use {
    'romgrk/barbar.nvim',
    opt = true,
    requires = {'kyazdani42/nvim-web-devicons'}
  }
  -- Fancy indent lines {{{1
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require 'indent_blankline'.setup {
        show_current_context = true,
        filetype_exclude = { "markdown", "help" }
      }
    end
  }
  -- Linting {{{1
  use {
    'mfussenegger/nvim-lint',
    ft = { 'c', 'cpp', 'lua', 'sh', 'bash', 'zsh', 'python' },
    event = {'BufWritePost', 'InsertLeave'},
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        c = {'cppcheck'},
        cpp = {'cppcheck'},
        lua = {'luacheck'},
        sh = {'shellcheck'},
        bash = {'shellcheck'},
        zsh = {'shellcheck'},
        python = {'pylint'},
      }
      lint.linters.luacheck.args = { '--globals', 'vim', '--formatter', 'plain', '--codes', '--ranges', '-' }
      vim.cmd [[ autocmd BufWritePost,InsertLeave <buffer> lua require('lint').try_lint() ]]
    end
  }
  -- Telescope {{{1
  use {
    'nvim-telescope/telescope.nvim',
    keys = {'<c-p>', '<leader>fa', '<leader>fb', '<leader>fc', '<leader>ff',
      '<leader>fg', '<leader>fh', '<leader>fm', '<leader>fo', '<leader>fs'},
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require 'vn36.telescope' end
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- Treesitter {{{1
  use {
    'nvim-treesitter/nvim-treesitter',
    -- causes error :<
    --ft = { "bash", "cpp", "css", "haskell", "html", "javascript", "java",
    --  "json", "latex", "lua", "make", "python", "rust", "vim", "yaml", },
    run = ':TSUpdate',
    requires = {
      'p00f/nvim-ts-rainbow', -- rainbow brackets
      'JoosepAlviste/nvim-ts-context-commentstring'
    },
    config = function() require 'vn36.treesitter' end
  }

  -- why is this so buggy
  use {
    'windwp/nvim-autopairs',
    opt = true,
    config = function()
      require 'nvim-autopairs'.setup {
        -- check_ts = true,
        ignored_next_char = '[^)}%]\'"$]'
      }
    end
  }

  -- Colorizer {{{1
  use {
    'norcalli/nvim-colorizer.lua',
    cmd = 'ColorizerAttachToBuffer',
    config = function()
      require 'colorizer'.setup ({
          -- filetype rules
        }, {
          -- RGB      = true;         -- #RGB hex codes
          -- RRGGBB   = true;         -- #RRGGBB hex codes
          -- names    = true;         -- "Name" codes like Blue
          RRGGBBAA = true;         -- #RRGGBBAA hex codes
          rgb_fn   = true;        -- CSS rgb() and rgba() functions
          hsl_fn   = true;        -- CSS hsl() and hsla() functions
          css      = true;        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn   = true;        -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes: foreground, background
          -- mode     = 'background'; -- Set the display mode.
      })
    end
  }

  -- Color Schemes {{{1
  use {
    'drewtempelmeyer/palenight.vim',
    config = function()
      vim.g.palenight_terminal_italics=1
    end
  }
  use {
    'ghifarit53/tokyonight-vim',
    config = function()
      vim.g.tokyonight_style = 'night' -- available: night, storm
      vim.g.tokyonight_enable_italic = 1
      -- vim.g.tokyonight_transparent_background = 0
    end
  }
  use 'morhetz/gruvbox'
  use 'sainnhe/sonokai'
  use 'sainnhe/everforest'
  -- includes: aurora,codemonkey,darkplus,onedarker,spacedark,system76,tomorrow
  use "lunarvim/colorschemes"

  use 'tomasr/molokai'
  use 'crusoexia/vim-monokai'
  use 'marko-cerovac/material.nvim'
  use 'RRethy/nvim-base16'

  -- Bootstrap end {{{1
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
  -- }}}1

end,
-- config: enable popup window and profiling {{{1
config = {
  display = {
    open_fn = require('packer.util').float,
  },
  profile = {
    enable = true,
    threshold = 0,
  }
}}
