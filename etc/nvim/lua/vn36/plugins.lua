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
-- packer.init: Have packer use a popup window {{{1
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end
  },
  profile = {
    enable = true,
    -- in ms, plugins loading faster than this won't be shown in profile output
    threshold = 1,
  }
}
-- }}}1
-- packer.startup
return packer.startup(function(use)

  use 'wbthomason/packer.nvim'
  -- Non-lua Plugins {{{1
  use 'tpope/vim-unimpaired' -- lots of useful keybinds
  use 'tpope/vim-surround'
  -- use 'tpope/vim-commentary'
  -- use 'tpope/vim-repeat'
  use { 'plasticboy/vim-markdown', ft = 'markdown' }
  use 'google/vim-searchindex'
  use {
    'junegunn/fzf',
    -- The post-hook gives the error /usr/share/vim/vimfiles/install not found
    -- run = ':call fzf#install()'
  }
  use 'junegunn/fzf.vim'
  -- Proprietary completion engines {{{1
  -- use 'github/copilot.vim', { 'on': 'Copilot' }
  -- use 'tom-doerr/vim_codex', { 'on': 'CreateCompletionLine' }
  -- use 'jessfraz/openai.vim' " for completions from openai

  -- Other Lua Plugins {{{1
  use 'folke/zen-mode.nvim'
  use 'samirettali/shebang.nvim' -- automatically add shebangs in files
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require 'vn36.gitsigns' end
  }
  -- Statusline and Bufferline {{{1
  use {
    'itchyny/lightline.vim',
  }
  use 'mengelbrecht/lightline-bufferline'
  -- use 'godlygeek/tabular'
  -- use 'bling/vim-bufferline' -- nice compact bufferline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    disable = true,
    config = function() require 'vn36.lualine' end
  }
  use {
    'romgrk/barbar.nvim',
    disable = true,
    requires = {'kyazdani42/nvim-web-devicons'}
  }
  -- Fancy indent lines {{{1
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require 'indent_blankline'.setup {
        show_current_context = true,
      }
    end
  }
  -- Linting {{{1
  use {
    'mfussenegger/nvim-lint',
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        lua = {'luacheck'},
        sh = {'shellcheck'},
        bash = {'shellcheck'},
        zsh = {'shellcheck'},
        python = {'pylint'},
      }
      lint.linters.luacheck.args = { '--globals', 'vim', '--formatter', 'plain', '--codes', '--ranges', '-' }
      vim.cmd [[ au BufWritePost <buffer> lua require('lint').try_lint() ]]
    end
  }
  -- Telescope {{{1
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require 'vn36.telescope' end
  }
  -- Treesitter {{{1
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() require 'vn36.treesitter' end
  }
  use 'p00f/nvim-ts-rainbow' -- rainbow brackets
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  -- why is this so buggy
  use {
    'windwp/nvim-autopairs',
    disabled = true,
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
    config = function()
      require 'colorizer'.setup ({
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
  use 'drewtempelmeyer/palenight.vim'
  use 'ghifarit53/tokyonight-vim'
  use 'morhetz/gruvbox'
  use 'sainnhe/sonokai'
  use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out

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

end)
