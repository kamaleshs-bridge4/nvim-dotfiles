-- File: lua/plugins/nvim-cmp.lua

return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'onsails/lspkind.nvim',
    'rafamadriz/friendly-snippets',
  },

  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local lspkind = require('lspkind') -- Make sure lspkind is required

    -- IMPORTANT: Load friendly snippets if available
    require('luasnip.loaders.from_vscode').lazy_load()

    cmp.setup({
      -- -----------------------------------------------------------
      -- 1. MAPPING CONFIGURATION
      -- -----------------------------------------------------------
      mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Confirm with Ctrl-y
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Or confirm with Enter
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),

      -- -----------------------------------------------------------
      -- 2. SOURCES
      -- -----------------------------------------------------------
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
      }),

      -- -----------------------------------------------------------
      -- 3. APPEARANCE AND FORMATTING
      -- -----------------------------------------------------------
      formatting = {
        format = lspkind.cmp_format({ -- Use lspkind here
          -- Use a more minimal symbol mode
          mode = 'symbol_text', -- Show both symbol icon and text
          maxwidth = 50,
          ellipsis_char = '...',

          -- Optional: Add a subtle separator between the icon and the label
          menu = ({
            buffer = '[Buf]',
            nvim_lsp = '[LSP]',
            luasnip = '[Snip]',
            path = '[Path]',
            cmdline = '[Cmd]',
          }),
        }),
      },

      -- 4. WINDOW CUSTOMIZATION (Rounded Borders for Softer Look)
      window = {
        -- Use rounded borders for a modern, softer appearance
        completion = cmp.config.window.bordered({
          border = 'rounded',
          -- THIS IS THE FIX:
          -- It maps the 'CursorLine' (selected line) to the 'CmpSel' highlight group.
          -- PmenuSel is also mapped to CmpSel for consistency.
          winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:CmpSel,PmenuSel:CmpSel',
        }),
        documentation = cmp.config.window.bordered({
          border = 'rounded',
          winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpBorder',
        }),
      },

      -- 5. OTHER OPTIONS
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },

      -- Enable auto-completion *only* after typing a character
      completion = {
        keyword_length = 1,
        -- Set trigger characters to show the menu immediately after certain symbols (e.g., in OOP languages)
        -- trigger_characters = { '.', ':', '-', '>', '/' } -- Uncomment to activate
      },

      -- Tweak performance for better visibility
      performance = {
        max_view_entries = 12, -- Show a couple more entries
      },
    })

    -- Optional: Setup command line completion for / and : (UNCHANGED)
    cmp.setup.cmdline('/', {
      sources = {
        { name = 'buffer' }
      }
    })
    cmp.setup.cmdline(':', {
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })
  end,
}


