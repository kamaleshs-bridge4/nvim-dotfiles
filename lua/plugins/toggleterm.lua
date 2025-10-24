-- File: lua/plugins/toggleterm.lua

local function set_term_keymaps(term)
  -- Get the buffer number from the terminal object
  local bufnr = term.bufnr
  
  -- 1. TERMINAL MODE (t): Map ESC to switch to Normal Mode (<C-\><C-n>)
  vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {
    desc = 'Exit Terminal Mode to Normal Mode',
    buffer = bufnr, -- IMPORTANT: Apply only to the terminal buffer
    nowait = true,
    silent = true,
  })

  -- 2. NORMAL MODE (n): Map ESC to close/hide the terminal (ToggleTerm)
  -- We must use the *buffer-local* mapping here for it to work correctly
  vim.keymap.set('n', '<Esc>', '<cmd>ToggleTerm<cr>', {
    desc = 'Close Terminal on second ESC',
    buffer = bufnr, -- IMPORTANT: Apply only to the terminal buffer
    nowait = true,
    silent = true,
  })
  
  -- Optional: Map 'i' to re-enter Terminal/Insert mode (since ESC took over C-\C-n)
  vim.keymap.set('n', 'i', 'a', {
    desc = 'Re-enter Terminal Insert Mode',
    buffer = bufnr,
    nowait = true,
    silent = true,
  })
end


return {
  'akinsho/toggleterm.nvim',
  version = "*",
  cmd = 'ToggleTerm',

  keys = {
    -- The global key to open/close the main terminal instance
    { '<leader>t', '<cmd>ToggleTerm<cr>', desc = 'Toggle floating terminal' },
    -- Key to toggle the specific 'LazyGit' terminal instance
    { '<leader>g', '<cmd>lua require("toggleterm").funcs.LazyGit("lazygit")<cr>', desc = 'Toggle LazyGit terminal' },
  },

  opts = {
    open_mapping = '<leader>t',
    direction = 'float',
    float_opts = {
      border = 'curved',
    },
    
    -- Crucial: Use the on_create hook to reliably set the keymaps
    on_create = function(term)
      set_term_keymaps(term)
    end,

    -- Disable the plugin's default terminal keymaps as we handle ESC manually
    terminal_mappings = false, 

    -- Configuration for pre-defined terminals
    funcs = {
      LazyGit = function(cmd)
        require('toggleterm.terminal').Terminal:new({
          cmd = cmd,
          direction = 'float',
          hidden = true,
          count = 9, -- unique identifier
          size = vim.o.lines * 0.9, 
        }):toggle()
      end
    },
  },
  
  -- Setup function is simplified now
  config = function(_, opts)
    require('toggleterm').setup(opts)
  end,
}
