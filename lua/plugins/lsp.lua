return {
  -- =======================================================================
  -- 1. LSP CORE SETUP (nvim-lspconfig)
  -- =======================================================================
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'hrsh7th/cmp-nvim-lsp' },
      'nvim-lua/plenary.nvim',
      { 'tpope/vim-rails', ft = { 'ruby', 'eruby' } },
    },

    config = function()
      -- Get capabilities for LSP
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- --------------------------------------------------------------------------
      -- 1. Configure LSP servers using NEW vim.lsp.config() API
      -- --------------------------------------------------------------------------
      -- IMPORTANT: Define configs BEFORE calling mason-lspconfig.setup()

      -- Lua LSP
      vim.lsp.config('lua_ls', {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            completion = { callSnippet = 'Replace' },
            workspace = {
              checkThirdParty = false,
              library = { vim.fn.stdpath('config') .. '/lua' }
            },
          },
        },
      })

      -- Ruby LSP
      vim.lsp.config('ruby_lsp', {
        cmd = { 'ruby-lsp' },
        filetypes = { 'ruby', 'eruby' },
        root_markers = { 'Gemfile', '.git' },
        capabilities = capabilities,
        settings = {
          ruby = {
            enabledFeatures = {
              debugging = true, codeActions = true, codeLens = true, completion = true,
              definition = true, diagnostics = true, documentHighlights = true, documentLink = true,
              documentSymbols = true, foldingRanges = true, formatting = true, hover = true,
              inlayHint = true, onTypeFormatting = true, selectionRanges = true,
              semanticHighlighting = true, signatureHelp = true, typeHierarchy = true,
              workspaceSymbol = true,
            },
            formatter = 'rubocop',
            addonSettings = {
              ['Ruby LSP Rails'] = {
                enablePendingMigrationsPrompt = false,
              },
            },
            featuresConfiguration = {
              inlayHint = { enableAll = true },
              debugging = { enabled = true, attachMode = 'remote', remotePort = 38698 },
            },
            rubyVersionManager = { identifier = 'auto' },
          },
        },
      })

      -- HTML LSP
      vim.lsp.config('html', {
        cmd = { 'vscode-html-language-server', '--stdio' },
        filetypes = { 'html' },
        root_markers = { '.git' },
        capabilities = capabilities,
      })

      -- CSS LSP
      vim.lsp.config('cssls', {
        cmd = { 'vscode-css-language-server', '--stdio' },
        filetypes = { 'css', 'scss', 'less' },
        root_markers = { '.git' },
        capabilities = capabilities,
      })

      -- JSON LSP
      vim.lsp.config('jsonls', {
        cmd = { 'vscode-json-language-server', '--stdio' },
        filetypes = { 'json', 'jsonc' },
        root_markers = { '.git' },
        capabilities = capabilities,
      })

      -- TypeScript/JavaScript LSP
      vim.lsp.config('ts_ls', {
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
        root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
        capabilities = capabilities,
      })

      -- Python LSP
      vim.lsp.config('pyright', {
        cmd = { 'pyright-langserver', '--stdio' },
        filetypes = { 'python' },
        root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json', '.git' },
        capabilities = capabilities,
      })

      -- Bash LSP
      vim.lsp.config('bashls', {
        cmd = { 'bash-language-server', 'start' },
        filetypes = { 'sh' },
        root_markers = { '.git' },
        capabilities = capabilities,
      })

      -- Rust LSP
      vim.lsp.config('rust_analyzer', {
        cmd = { 'rust-analyzer' },
        filetypes = { 'rust' },
        root_markers = { 'Cargo.toml', 'rust-project.json' },
        capabilities = capabilities,
      })

      -- Go LSP (gopls)
      vim.lsp.config('gopls', {
        cmd = { 'gopls' },
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        root_markers = { 'go.mod', 'go.work', '.git' },
        capabilities = capabilities,
        settings = {
          gopls = {
            -- Settings based on common Zed/VSCode Go setups
            completeUnimported = true,
            usePlaceholders = true,
            staticcheck = true,
            semanticTokens = true,
            -- Enable all inlay hints for a richer experience
            ["ui.inlayhint.hints"] = {
              compositeLiteralFields = true,
              constantValues = true,
              parameterNames = true,
              rangeVariableTypes = true,
              functionTypeParameters = true,
            },
          },
        },
      })

      -- --------------------------------------------------------------------------
      -- 2. Setup Mason-LSPConfig with automatic_enable
      -- --------------------------------------------------------------------------
      -- This will automatically enable all servers configured above via vim.lsp.config()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'html', 'cssls', 'jsonls', 'ts_ls',
          'lua_ls', 'pyright', 'bashls', 'rust_analyzer', 'ruby_lsp',
          'gopls' -- Added Go LSP
        },
        automatic_enable = true, -- Automatically enable servers configured with vim.lsp.config()
      })

      -- --------------------------------------------------------------------------
      -- 3. Diagnostics Configuration
      -- --------------------------------------------------------------------------
      vim.diagnostic.config({
        virtual_text = {
          source = 'always',
          spacing = 4,
          prefix = '●',
        },
        signs = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          source = 'always',
          border = 'rounded',
        },
      })

      -- --------------------------------------------------------------------------
      -- 4. Reliable FileType Autocmd for Keymaps
      -- --------------------------------------------------------------------------
      local function set_lsp_keymaps()
        local bufnr = vim.api.nvim_get_current_buf()
        local base_opts = { noremap = true, silent = true, buffer = bufnr }

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', base_opts, { desc = '[G]oto [D]eclaration' }))
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', base_opts, { desc = '[G]oto [D]efinition' }))
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', base_opts, { desc = '[G]oto [I]mplementation' }))
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', base_opts, { desc = '[G]oto [R]eferences' }))
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', base_opts, { desc = 'Hover Documentation' }))
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, vim.tbl_extend('force', base_opts, { desc = 'Signature Help' }))
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', base_opts, { desc = 'Code [A]ctions' }))
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', base_opts, { desc = '[R]e[n]ame' }))
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, vim.tbl_extend('force', base_opts, { desc = 'Go to previous diagnostic' }))
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend('force', base_opts, { desc = 'Go to next diagnostic' }))
        vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, vim.tbl_extend('force', base_opts, { desc = 'View Diagnostic' }))
      end

      local lsp_filetypes = {
        'ruby', 'eruby', 'lua', 'html', 'css', 'json',
        'typescript', 'javascript', 'python', 'bash', 'rust',
        'go', 'gomod', 'gowork', 'gotmpl' -- Added Go filetypes
      }

      vim.api.nvim_create_autocmd('FileType', {
        pattern = lsp_filetypes,
        group = vim.api.nvim_create_augroup('LspKeymaps', { clear = true }),
        callback = set_lsp_keymaps,
      })

      -- --------------------------------------------------------------------------
      -- 5. Direct Rubocop Autocorrect on Save
      -- --------------------------------------------------------------------------
      local RUBOCOP_PATH = '/Users/kamalesh.s/.rbenv/shims/rubocop'

      -- Check if rubocop exists
      local function rubocop_exists()
        return vim.fn.executable(RUBOCOP_PATH) == 1 or vim.fn.executable('rubocop') == 1
      end

      -- Get rubocop command
      local function get_rubocop_cmd()
        if vim.fn.executable(RUBOCOP_PATH) == 1 then
          return RUBOCOP_PATH
        elseif vim.fn.executable('rubocop') == 1 then
          return 'rubocop'
        end
        return nil
      end

      vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = { '*.rb', '*.rake', '*.ru', '*.erb' },
        group = vim.api.nvim_create_augroup('RubyFormatting', { clear = true }),
        callback = function(args)
          if not rubocop_exists() then
            vim.notify('RuboCop not found', vim.log.levels.WARN)
            return
          end

          local rubocop_cmd = get_rubocop_cmd()
          local file_path = vim.api.nvim_buf_get_name(args.buf)

          -- Skip if file doesn't exist or is empty
          if file_path == '' or vim.fn.filereadable(file_path) == 0 then
            return
          end

          -- Run rubocop with autocorrect
          local cmd = string.format('%s -A %s', rubocop_cmd, vim.fn.shellescape(file_path))
          local output = vim.fn.system(cmd)
          local exit_code = vim.v.shell_error

          -- Reload buffer if rubocop made changes
          if exit_code == 0 or exit_code == 1 then -- 0 = no offenses, 1 = offenses corrected
            vim.cmd('checktime') -- Check if file changed and reload if needed
          else
            vim.notify('RuboCop failed: ' .. output, vim.log.levels.ERROR)
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
        'bash', 'python', 'rust', 'ruby', 'erb',
        'go', 'gomod' -- Added Go parsers
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

