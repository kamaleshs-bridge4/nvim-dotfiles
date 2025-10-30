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
      
      -- Custom highlight groups for illuminated tokens (Catppuccin compatible)
      local function set_illuminate_highlights()
        local colorscheme = vim.g.colors_name or ""
        if colorscheme:match("catppuccin") then
          -- Use Catppuccin colors for illuminated tokens
          vim.api.nvim_set_hl(0, 'IlluminatedWordText', { 
            bg = '#45475a' -- Catppuccin surface1
          })
          vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { 
            bg = '#45475a' -- Catppuccin surface1
          })
          vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { 
            bg = '#585b70', -- Catppuccin surface2
            underline = true
          })
        else
          -- Fallback colors for other themes
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
      
      -- Custom treesitter highlight groups (Catppuccin compatible)
      local function set_treesitter_highlights()
        local colorscheme = vim.g.colors_name or ""
        local highlights = {}
        
        if colorscheme:match("catppuccin") then
          -- Use Catppuccin colors for treesitter
          highlights = {
            -- Variables
            ["@variable"] = { fg = "#f5c2e7" }, -- Catppuccin pink
            ["@variable.builtin"] = { fg = "#f5c2e7", bold = true },
            ["@variable.parameter"] = { fg = "#fab387" }, -- Catppuccin peach
            ["@variable.member"] = { fg = "#f9e2af" }, -- Catppuccin yellow
            
            -- Functions
            ["@function"] = { fg = "#89b4fa", bold = true }, -- Catppuccin blue
            ["@function.builtin"] = { fg = "#cba6f7" }, -- Catppuccin mauve
            ["@function.call"] = { fg = "#89b4fa" },
            ["@method"] = { fg = "#89b4fa" },
            
            -- Keywords
            ["@keyword"] = { fg = "#cba6f7", bold = true }, -- Catppuccin mauve
            ["@keyword.function"] = { fg = "#cba6f7" },
            ["@keyword.return"] = { fg = "#cba6f7", italic = true },
            
            -- Types
            ["@type"] = { fg = "#f9e2af" }, -- Catppuccin yellow
            ["@type.builtin"] = { fg = "#f5c2e7" }, -- Catppuccin pink
            
            -- Constants
            ["@constant"] = { fg = "#fab387" }, -- Catppuccin peach
            ["@constant.builtin"] = { fg = "#fab387", bold = true },
            
            -- Strings
            ["@string"] = { fg = "#a6e3a1" }, -- Catppuccin green
            ["@string.escape"] = { fg = "#94e2d5" }, -- Catppuccin teal
            
            -- Numbers
            ["@number"] = { fg = "#fab387" }, -- Catppuccin peach
            ["@boolean"] = { fg = "#fab387" },
            
            -- Comments
            ["@comment"] = { fg = "#6c7086", italic = true }, -- Catppuccin overlay2
            ["@comment.todo"] = { fg = "#cba6f7", bold = true }, -- Catppuccin mauve
            
            -- Operators
            ["@operator"] = { fg = "#94e2d5" }, -- Catppuccin teal
            ["@punctuation.bracket"] = { fg = "#cdd6f4" }, -- Catppuccin text
            ["@punctuation.delimiter"] = { fg = "#cdd6f4" },
            
            -- Tags
            ["@tag"] = { fg = "#f5c2e7" }, -- Catppuccin pink
            ["@tag.attribute"] = { fg = "#fab387" }, -- Catppuccin peach
            
            -- Properties
            ["@property"] = { fg = "#f9e2af" }, -- Catppuccin yellow
            ["@constructor"] = { fg = "#f9e2af" },
          }
        else
          -- Fallback colors for other themes
          highlights = {
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
        end
        
        for group, settings in pairs(highlights) do
          vim.api.nvim_set_hl(0, group, settings)
        end
      end
      
      -- Apply treesitter highlights
      set_treesitter_highlights()
      
      -- Reapply on colorscheme change
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_treesitter_highlights
      })
    end,
  },
}
