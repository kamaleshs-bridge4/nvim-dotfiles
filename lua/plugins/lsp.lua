-- File: lua/config/lsp.lua (Revised)

local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')

-- --------------------------------------------------------------------------
-- SERVER LIST: Added 'ruby_lsp'
-- --------------------------------------------------------------------------
local servers = {
    -- Common Web/JavaScript/TypeScript Servers
    'html', 'cssls', 'jsonls', 'tsserver',

    -- Common General Purpose Servers
    'lua_ls', 'pyright', 'bashls', 'rust_analyzer',
    
    -- ADDED: Ruby LSP
    'ruby_lsp', 
}

-- --------------------------------------------------------------------------
-- 1. LSP Keymaps & Formatting on Save
-- --------------------------------------------------------------------------

local on_attach = function(client, bufnr)
  -- Auto-formatting on save (BufWritePre)
  if client.supports_method('textDocument/formatting') then
    -- NOTE: This handles the rubocop auto-formatting you desire.
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        -- Ensure only non-Ruby files are auto-formatted if Ruby LSP is active,
        -- as Ruby LSP handles its own formatting with 'rubocop' configured below.
        -- We will let the global setup function handle the formatting call.
        vim.lsp.buf.format({ async = true })
      end,
    })
  end

  -- Local reference for setting buffer-local keymaps (UNCHANGED)
  local buf_set_keymap = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- Standard LSP Keymaps for Normal Mode (n)
  buf_set_keymap('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  buf_set_keymap('n', 'gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  buf_set_keymap('n', 'gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  buf_set_keymap('n', 'gr', vim.lsp.buf.references, '[G]oto [R]eferences')
  buf_set_keymap('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
  buf_set_keymap('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature Help')
  buf_set_keymap('n', '<leader>ca', vim.lsp.buf.code_action, 'Code [A]ctions')
  buf_set_keymap('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
end


-- --------------------------------------------------------------------------
-- 2. Setup Mason for Automatic LSP Installation (Including Ruby LSP handler)
-- --------------------------------------------------------------------------

mason_lspconfig.setup {
  ensure_installed = servers,
  handlers = {
    -- Default handler for all servers not listed explicitly (e.g., tsserver, pyright)
    function(server_name)
      lspconfig[server_name].setup {
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        settings = {},
      }
    end,

    -- Custom handler for LuaLS (UNCHANGED)
    ['lua_ls'] = function()
      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            completion = { callSnippet = 'Replace' },
            workspace = { checkThirdParty = false, library = { vim.fn.stdpath("config") .. "/lua" } },
          },
        },
      }
    end,

    -- NEW: Custom handler for Ruby LSP
    ['ruby_lsp'] = function()
      lspconfig.ruby_lsp.setup {
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        -- Translate Zed's initialization_options directly to Neovim's settings
        settings = {
          ruby = {
            -- Features
            enabledFeatures = {
              debugging = true, codeActions = true, codeLens = true, completion = true, 
              definition = true, diagnostics = true, documentHighlights = true, documentLink = true,
              documentSymbols = true, foldingRanges = true, formatting = true, hover = true,
              inlayHint = true, onTypeFormatting = true, selectionRanges = true, 
              semanticHighlighting = true, signatureHelp = true, typeHierarchy = true, 
              workspaceSymbol = true
            },
            
            -- Formatter: Set to rubocop (Matches Zed config)
            formatter = "rubocop",
            
            -- Addon Settings (Ruby LSP Rails)
            addonSettings = {
              ['Ruby LSP Rails'] = {
                enablePendingMigrationsPrompt = false,
              }
            },
            
            -- Features Configuration
            featuresConfiguration = {
              inlayHint = { enableAll = true },
              debugging = { enabled = true, attachMode = "remote", remotePort = 38698 },
            },
            
            -- Version Manager
            rubyVersionManager = { identifier = "auto" }
          }
        }
      }
    end,
  },
}

-- --------------------------------------------------------------------------
-- 3. Diagnostics (How errors/warnings are displayed) (UNCHANGED)
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

-- Keymaps for navigating diagnostics (UNCHANGED)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic')
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, 'Go to next diagnostic')
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, 'Open diagnostic window')
