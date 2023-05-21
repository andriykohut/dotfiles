local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "folke/tokyonight.nvim",
  {
    "nvim-tree/nvim-web-devicons",
    config = function() require("nvim-web-devicons").setup({}) end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        sections = { lualine_a = { 'g:coc_status', 'bo:filetype' } }
      })
    end,
  },
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({})
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function() require("todo-comments").setup({}) end,
  },
  {
    "neoclide/coc.nvim",
    branch = "release",
  },
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },
  {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'ggandor/flit.nvim',
    dependencies = {
      'tpope/vim-repeat',
      'ggandor/leap.nvim'
    },
    config = function() require('flit').setup({ labeled_modes = "nvo" }) end
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup() end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "lua", "vim", "vimdoc", "query", "python", "rust", "typescript" },
        highlight = { enable = true },
        incremental_selection = { enable = true },
        indent = { enable = true }
      })
    end
  },
  'RRethy/vim-illuminate',
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function() require('bufferline').setup() end
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("indent_blankline").setup({
        show_current_context = true,
        show_current_context_start = true,
      })
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function () require("dapui").setup() end
  }
})

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
