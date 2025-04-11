local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  -- Theme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup()

      -- setup must be called before loading
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  -- Programmatically install mason packages
  'WhoIsSethDaniel/mason-tool-installer.nvim',

  -- Easily copy to system clipboard
  'christoomey/vim-system-copy',

  -- Git bits
  'tpope/vim-fugitive',

  -- Show git changes
  'lewis6991/gitsigns.nvim',

  -- Show indentation guides
  'lukas-reineke/indent-blankline.nvim',

  -- Show colours in file
  'norcalli/nvim-colorizer.lua',

  -- Formatting
  'stevearc/conform.nvim',

  -- Automatically close brackets and quotes
  'windwp/nvim-autopairs',

  -- Automatically resize splits
  'nvim-focus/focus.nvim',

  -- Enhanced syntax highlighting and context
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },

  -- Setup language servers
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
  },

  -- Show status of LSP
  'j-hui/fidget.nvim',

  -- Diagnostic bits
  'folke/trouble.nvim',

  -- LSP signature hints
  'ray-x/lsp_signature.nvim',

  -- Code completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'windwp/nvim-autopairs',
      'onsails/lspkind.nvim',
    },
  },

  -- File and text search
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
  },

  -- File tree
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },

  -- Easily manage comments
  {
    'numtostr/comment.nvim',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
      'joosepalviste/nvim-ts-context-commentstring',
    },
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },

  -- Preview markdown files in browser
  {
    'iamcco/markdown-preview.nvim',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },

  -- Lazy git
  'kdheepak/lazygit.nvim',
}
