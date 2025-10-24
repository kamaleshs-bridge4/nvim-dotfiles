-- File: lua/plugins/nvim-tree.lua

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  -- Define the options for the keymap
  local opts = function(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr, -- IMPORTANT: Makes the keymap local to the nvim-tree buffer
      noremap = true,
      silent = true,
      nowait = true,
    }
  end

  -- 1. Apply the default NvimTree keymaps
  -- This ensures other essential nvim-tree mappings (like 'a', 'd', 'r', etc.) still work
  api.config.mappings.default_on_attach(bufnr)

  -- 2. REMOVE the default buffer-local '-' mapping (api.tree.change_root_to_parent)
  vim.keymap.del('n', '-', { buffer = bufnr })

  -- 3. Map '-' to CLOSE the tree *buffer-locally* when in the tree.
  -- You can use 'NvimTreeToggle' or 'NvimTreeClose' here. 'NvimTreeToggle' is versatile.
  vim.keymap.set('n', '-', '<cmd>NvimTreeToggle<CR>', opts("Toggle/Close Tree"))
end


return {
  'nvim-tree/nvim-tree.lua',

  -- We remove the 'cmd' and 'keys' from here, as the keymap is better managed
  -- by the 'on_attach' function and a standard global toggle key.
  -- However, if you want a global key to *open* it, keep the keys table.
  -- Since your goal is to use '-' to *close* it when open, let's keep it simple.

  -- If you want '-' to *always* toggle the tree globally, even when not in the tree buffer:
  -- The global keymap should be defined here, BUT we need a different key, 
  -- or we rely solely on the nvim-tree buffer-local one for simplicity. 
  
  -- LETS USE THE PLUGINS GLOBAL CONFIG TO DEFINE THE GLOBAL KEYMAP
  cmd = 'NvimTreeToggle',

  keys = {
    {
      "-",
      "<cmd>NvimTreeToggle<CR>",
      desc = "Toggle NvimTree (Global)"
    },
  },

  -- Configuration (opts table)
  opts = {
    sort_by = "case_sensitive",
    hijack_netrw = true,
    update_focused_file = {
      enable = true,
      update_root = true,
    },
    renderer = {
      root_folder_label = ":t",
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
      },
    },
    view = {
      width = 30,
      preserve_window_proportions = true,
    },
    actions = {
      open_file = {
        quit_on_open = false,
      }
    },

    -- Pass the on_attach function
    on_attach = on_attach,
  },

  -- Setup function
  config = function(_, opts)
    require('nvim-tree').setup(opts)
  end,
}
