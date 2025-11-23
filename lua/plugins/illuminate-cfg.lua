-- Token highlighting configuration with vim-illuminate
-- Place at: ~/.config/nvim/lua/plugins/illuminate-cfg.lua

return {
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- Providers: 'lsp', 'treesitter', 'regex'
      providers = {
        'lsp',
        'treesitter',
        'regex',
      },
      -- Delay in milliseconds before highlighting
      delay = 100,
      -- Filetypes to exclude
      filetypes_denylist = {
        'dirvish',
        'fugitive',
        'NvimTree',
        'neo-tree',
        'alpha',
        'dashboard',
        'TelescopePrompt',
        'lazy',
        'mason',
        'help',
      },
      -- Filetypes to include (if empty, all are included)
      filetypes_allowlist = {},
      -- Modes to highlight in
      modes_denylist = {},
      -- Modes to allow (if empty, all are allowed)
      modes_allowlist = {},
      -- Providers to run regex on
      providers_regex_syntax_denylist = {},
      providers_regex_syntax_allowlist = {},
      -- When true, highlight under cursor
      under_cursor = true,
      -- Highlight word boundaries
      large_file_cutoff = 2000,
      large_file_overrides = nil,
      -- Minimum number of matches to highlight
      min_count_to_highlight = 1,
    },
    config = function(_, opts)
      require('illuminate').configure(opts)
      
      -- Keymaps for navigating between highlighted tokens
      vim.keymap.set('n', '<A-n>', function()
        require('illuminate').goto_next_reference(false)
      end, { desc = 'Next Reference' })
      
      vim.keymap.set('n', '<A-p>', function()
        require('illuminate').goto_prev_reference(false)
      end, { desc = 'Prev Reference' })
    end,
  },
  
  -- Optional: Add treesitter for better token detection
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "lua", "vim", "vimdoc", "python", "javascript", 
        "typescript", "rust", "go", "c", "cpp", "bash",
        "json", "yaml", "html", "css", "markdown"
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
