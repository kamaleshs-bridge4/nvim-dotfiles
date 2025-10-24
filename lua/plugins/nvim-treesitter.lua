-- File: lua/plugins/nvim-treesitter.lua

return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  
  config = function()
    require('nvim-treesitter.configs').setup {
      -- UPDATED: List of languages to install and use (includes new languages)
      ensure_installed = {
        'lua', 
        'vim', 
        'html', 
        'css', 
        'javascript', 
        'typescript', 
        'json', 
        'markdown', 
        'bash',
        'go',         -- Golang
        'ruby',       -- Ruby
        'zig',        -- Zig
        'rust',       -- Rust
        'java',       -- Java
        'python',     -- Python
      },

      -- Enable Treesitter-based syntax highlighting
      highlight = {
        enable = true,
        disable = function(lang, buf)
          return lang == 'markdown' and vim.api.nvim_buf_get_lines(buf, 0, -1, false)[1] == '---'
        end,
      },
      
      -- Enable Treesitter-based indentation
      indent = {
        enable = true,
      },

      -- Configuration for treesitter-textobjects (advanced motions)
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
            ['a='] = '@assignment.outer',
            ['i='] = '@assignment.inner',
          },
        },
        swap = {
          enable = false,
        },
      },
    }
  end,
}
