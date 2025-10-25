-- File: lua/plugins/autopairs.lua
-- This plugin handles auto-closing of brackets, quotes, etc.

return {
  'windwp/nvim-autopairs',
  -- Event triggers on insert mode
  event = "InsertEnter",
  
  config = function()
    local autopairs = require('nvim-autopairs')
    
    autopairs.setup({
      -- This setting ensures that autopairs doesn't add a closing bracket
      -- if nvim-cmp is already completing a snippet with one.
      check_ts = true, -- Check treesitter nodes to be smarter about pairing
      ts_config = {
        lua = { 'string', 'comment' },
        javascript = { 'string', 'comment' },
        go = { 'string', 'comment' },
        -- Add other languages as needed
      },
      -- Don't add pairs inside comments
      disable_filetype = { "TelescopePrompt", "vim", "neo-tree" },
    })

    -- This part is crucial for making it work with nvim-cmp
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')

    -- Hook into nvim-cmp's confirm event
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  end,
}

