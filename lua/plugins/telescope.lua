-- This configuration snippet uses the 'telescope.nvim' plugin, 
-- which is the standard way to implement 'ff' (Fuzzy Find) in Neovim.
-- It offers seamless integration and better performance than running an external script.

-- FUNCTION TO FOCUS THE PREVIEW WINDOW
local focus_preview = function(prompt_bufnr)
  local action_state = require("telescope.actions.state")
  local picker = action_state.get_current_picker(prompt_bufnr)
  local prompt_win = picker.prompt_win
  local previewer = picker.previewer

  -- Handle both standard buffer previews and terminal previews
  local bufnr = previewer.state.bufnr or previewer.state.termopen_bufnr
  -- Get window ID, falling back to finding it by buffer number for terminal previews
  local winid = previewer.state.winid or vim.fn.win_findbuf(bufnr)[1]

  -- Set a keymap in the PREVIEW BUFFER to jump back to the prompt window.
  -- The keymap is set specifically for the preview buffer (`{ buffer = bufnr }`).
  vim.keymap.set("n", "<Tab>", function()
    -- Use noautocmd to prevent unnecessary event triggers
    vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", prompt_win))
  end, { buffer = bufnr, silent = true })

  -- Jump the focus to the preview window
  vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", winid))
end
-- END OF FOCUS FUNCTION

return {
  -- 1. Ensure the 'nvim-telescope/telescope.nvim' plugin is installed and configured
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    
    -- 2. Define Keymaps
    keys = {
      -- Map <leader>ff (The most common mapping) to open the file finder
      { "<leader>ff", 
        function() 
          require('telescope.builtin').find_files() 
        end, 
        desc = "Fuzzy Find Files" 
      },
    },
    
    -- 3. Configure Telescope (Basic Setup)
    config = function()
      require("telescope").setup {
        defaults = {
          -- Customize layout and mappings for a better experience
          layout_config = {
              width = 0.9,
              height = 0.9,
          },
          mappings = {
            n = {
              -- ADDED: Map <Tab> in normal mode to focus the preview window
              ["<Tab>"] = focus_preview,
            },
            i = {
              -- Map C-j and C-k for easier navigation in insert mode
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
              ["<C-q>"] = "smart_send_to_qflist", -- Send results to quickfix list
              -- You may want to unmap <Tab> in insert mode if it conflicts,
              -- but in the provided setup, <Tab> is not defined in `i` mode 
              -- so it defaults to Telescope's action (usually move_selection_next or a snippet expansion).
            },
          },
        },
      }
    end
  }
}
