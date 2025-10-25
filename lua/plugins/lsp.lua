-- File: lua/plugins/lsp_config.lua (FINAL CORRECTED VERSION with Absolute Path)

return {
  -- =======================================================================
  -- 1. LSP CORE SETUP (nvim-lspconfig)
  -- =======================================================================
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', opts = {} },
      { 'williamboman/mason-lspconfig.nvim', opts = {} },
      { 'hrsh7th/cmp-nvim-lsp' },
      'nvim-lua/plenary.nvim',

      { 'tpope/vim-rails', ft = { 'ruby', 'eruby' } },
    },

    config = function()
      local lspconfig = require('lspconfig')
      local mason_lspconfig = require('mason-lspconfig')

      local servers = {
          'html', 'cssls', 'jsonls', 'tsserver',
          'lua_ls', 'pyright', 'bashls', 'rust_analyzer',
          'ruby_lsp', -- Shopify Ruby LSP
      }

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- --------------------------------------------------------------------------
      -- 1. LSP on_attach - EMPTY
      -- --------------------------------------------------------------------------
      local on_attach = function(client, bufnr) 
          -- Formatting and Keymaps are now handled by FileType Autocmds for reliability.
      end


      -- --------------------------------------------------------------------------
      -- 2. Setup Mason for Automatic LSP Installation
      -- --------------------------------------------------------------------------

      mason_lspconfig.setup {
        ensure_installed = servers,
        handlers = {
          -- Default handler
          function(server_name)
            lspconfig[server_name].setup {
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {},
            }
          end,

          -- Custom handler for LuaLS
          ['lua_ls'] = function()
            lspconfig.lua_ls.setup {
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = { version = 'LuaJIT' },
                  completion = { callSnippet = 'Replace' },
                  workspace = { checkThirdParty = false, library = { vim.fn.stdpath("config") .. "/lua" } },
                },
              },
            }
          end,

          -- Custom handler for Shopify Ruby LSP
          ['ruby_lsp'] = function()
            lspconfig.ruby_lsp.setup {
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                ruby = {
                  enabledFeatures = {
                    debugging = true, codeActions = true, codeLens = true, completion = true, 
                    definition = true, diagnostics = true, documentHighlights = true, documentLink = true,
                    documentSymbols = true, foldingRanges = true, formatting = true, hover = true,
                    inlayHint = true, onTypeFormatting = true, selectionRanges = true, 
                    semanticHighlighting = true, signatureHelp = true, typeHierarchy = true, 
                    workspaceSymbol = true
                  },
                  formatter = "rubocop", 
                  addonSettings = {
                    ['Ruby LSP Rails'] = {
                      enablePendingMigrationsPrompt = false,
                    }
                  },
                  featuresConfiguration = {
                    inlayHint = { enableAll = true },
                    debugging = { enabled = true, attachMode = "remote", remotePort = 38698 },
                  },
                  rubyVersionManager = { identifier = "auto" }
                }
              }
            }
          end,
        },
      }

      -- --------------------------------------------------------------------------
      -- 3. Diagnostics Configuration
      -- --------------------------------------------------------------------------

      vim.diagnostic.config({
        virtual_text = {
          source = "always",
          spacing = 4,
          prefix = '●',
        },
        signs = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          source = "always",
          border = 'rounded',
        },
      })
      
      -- --------------------------------------------------------------------------
      -- 4. Reliable FileType Autocmd for Keymaps
      -- --------------------------------------------------------------------------
      
      local function set_lsp_keymaps()
          local bufnr = vim.api.nvim_get_current_buf()
          local base_opts = { noremap = true, silent = true, buffer = bufnr }

          -- Go to Definition/References
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', base_opts, { desc = '[G]oto [D]eclaration' }))
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', base_opts, { desc = '[G]oto [D]efinition' }))
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', base_opts, { desc = '[G]oto [I]mplementation' }))
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', base_opts, { desc = '[G]oto [R]eferences' }))

          -- Documentation/Code Actions
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', base_opts, { desc = 'Hover Documentation' }))
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, vim.tbl_extend('force', base_opts, { desc = 'Signature Help' }))
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', base_opts, { desc = 'Code [A]ctions' }))
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', base_opts, { desc = '[R]e[n]ame' }))

          -- Diagnostic Navigation
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, vim.tbl_extend('force', base_opts, { desc = 'Go to previous diagnostic' }))
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend('force', base_opts, { desc = 'Go to next diagnostic' }))
          vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, vim.tbl_extend('force', base_opts, { desc = 'View Diagnostic' }))
      end

      local lsp_filetypes = { 
          'ruby', 'eruby', 'lua', 'html', 'css', 'json', 
          'typescript', 'javascript', 'python', 'bash', 'rust' 
      }

      vim.api.nvim_create_autocmd('FileType', {
          pattern = lsp_filetypes,
          group = vim.api.nvim_create_augroup('LspKeymaps', { clear = true }),
          callback = set_lsp_keymaps,
      })
      
      -- --------------------------------------------------------------------------
      -- 5. Direct Rubocop Autocorrect on Save (THE ABSOLUTE PATH FIX)
      -- --------------------------------------------------------------------------
      local rubocop_filetypes = { 'ruby', 'eruby' }

      -- 🚨 USE THE ABSOLUTE PATH FOUND VIA 'which rubocop'
      local RUBOCOP_PATH = '/Users/dalinar/.local/share/mise/installs/ruby/3.3.6/bin/rubocop'
      
      vim.api.nvim_create_autocmd('BufWritePre', {
          pattern = rubocop_filetypes,
          group = vim.api.nvim_create_augroup('RubyFormatting', { clear = true }),
          callback = function()
              local bufnr = vim.api.nvim_get_current_buf()
              local file_path = vim.fn.expand('%:p')
              
              -- 1. Ensure content is written to disk before Rubocop runs on it
              vim.cmd('write') 

              -- 2. Run Rubocop using the absolute path
              -- -A is a shortcut for --autocorrect --safe-autocorrect
              local cmd = RUBOCOP_PATH .. ' -A ' .. vim.fn.shellescape(file_path)
              
              -- Run the command synchronously (blocking until Rubocop finishes)
              vim.fn.system(cmd)
              
              -- 3. Reload the buffer to see the changes made by Rubocop
              if vim.api.nvim_buf_is_loaded(bufnr) then
                  vim.cmd('e!') 
              end
          end,
      })

    end, -- end of nvim-lspconfig config function
  },
  
  -- =======================================================================
  -- 2. TREE-SITTER
  -- =======================================================================
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 
        'lua', 'html', 'css', 'javascript', 'typescript', 'json', 
        'bash', 'python', 'rust', 'ruby', 'erb'
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
  
  -- =======================================================================
  -- 3. nvim-cmp and Snippet Plugins (Dependencies are required here)
  -- =======================================================================
  { 'nvim-lua/plenary.nvim' }, 
  { 'L3MON4D3/LuaSnip' },
  { 'rafamadriz/friendly-snippets' },
  { 'onsails/lspkind.nvim' },
  
  -- The nvim-cmp setup file
  { 'hrsh7th/nvim-cmp', lazy = false, config = require('plugins.nvim-cmp') },
}
