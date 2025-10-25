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
      
      -- Custom highlight groups for illuminated tokens
      local function set_illuminate_highlights()
        vim.api.nvim_set_hl(0, 'IlluminatedWordText', { 
          bg = '#3e4452'
        })
        vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { 
          bg = '#3e4452'
        })
        vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { 
          bg = '#4e5462',
          underline = true
        })
      end
      
      -- Apply highlights
      set_illuminate_highlights()
      
      -- Reapply on colorscheme change
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_illuminate_highlights
      })
      
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
      
      -- Custom treesitter highlight groups
      local highlights = {
        -- Variables
        ["@variable"] = { fg = "#e06c75" },
        ["@variable.builtin"] = { fg = "#e06c75", bold = true },
        ["@variable.parameter"] = { fg = "#d19a66" },
        ["@variable.member"] = { fg = "#e5c07b" },
        
        -- Functions
        ["@function"] = { fg = "#61afef", bold = true },
        ["@function.builtin"] = { fg = "#c678dd" },
        ["@function.call"] = { fg = "#61afef" },
        ["@method"] = { fg = "#61afef" },
        
        -- Keywords
        ["@keyword"] = { fg = "#c678dd", bold = true },
        ["@keyword.function"] = { fg = "#c678dd" },
        ["@keyword.return"] = { fg = "#c678dd", italic = true },
        
        -- Types
        ["@type"] = { fg = "#e5c07b" },
        ["@type.builtin"] = { fg = "#e06c75" },
        
        -- Constants
        ["@constant"] = { fg = "#d19a66" },
        ["@constant.builtin"] = { fg = "#d19a66", bold = true },
        
        -- Strings
        ["@string"] = { fg = "#98c379" },
        ["@string.escape"] = { fg = "#56b6c2" },
        
        -- Numbers
        ["@number"] = { fg = "#d19a66" },
        ["@boolean"] = { fg = "#d19a66" },
        
        -- Comments
        ["@comment"] = { fg = "#5c6370", italic = true },
        ["@comment.todo"] = { fg = "#c678dd", bold = true },
        
        -- Operators
        ["@operator"] = { fg = "#56b6c2" },
        ["@punctuation.bracket"] = { fg = "#abb2bf" },
        ["@punctuation.delimiter"] = { fg = "#abb2bf" },
        
        -- Tags
        ["@tag"] = { fg = "#e06c75" },
        ["@tag.attribute"] = { fg = "#d19a66" },
        
        -- Properties
        ["@property"] = { fg = "#e5c07b" },
        ["@constructor"] = { fg = "#e5c07b" },
      }
      
      for group, settings in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, settings)
      end
    end,
  },
}
