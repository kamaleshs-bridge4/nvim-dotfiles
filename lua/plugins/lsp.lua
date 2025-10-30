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
              library = { vim.fn.stdpath('config') .. '/lua' },
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
            completeUnimported = true,
            usePlaceholders = true,
            staticcheck = false, -- Disable gopls staticcheck, let golangci-lint handle it
            semanticTokens = true,
            analyses = {
              unusedparams = true,
              shadow = false,
              nilness = true,
              unusedwrite = true,
            },
            codelenses = {
              generate = true,
              gc_details = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      })

      -- golangci-lint Language Server
      vim.lsp.config('golangci_lint_ls', {
        cmd = { 'golangci-lint-langserver' },
        filetypes = { 'go' },
        root_markers = { 'go.mod', '.golangci.yml', '.golangci.yaml', '.git' },
        capabilities = capabilities,
        init_options = {
          command = {
            'golangci-lint',
            'run',
            '--output.text.path',
            '/dev/null',
            '--output.json.path',
            'stdout',
            '--show-stats=false',
            '--issues-exit-code=1',
          },
        },
        on_attach = function(client, bufnr)
          -- Custom function to find .golangci.yaml recursively up the directory tree
          local function find_golangci_config()
            local current_dir = vim.fn.expand('%:p:h')
            local config_files = { '.golangci.yaml', '.golangci.yml' }
            
            -- Function to check if config file exists in a directory
            local function check_config_in_dir(dir)
              for _, config_file in ipairs(config_files) do
                local config_path = dir .. '/' .. config_file
                if vim.fn.filereadable(config_path) == 1 then
                  return config_path
                end
              end
              return nil
            end
            
            -- Check current directory first
            local config = check_config_in_dir(current_dir)
            if config then
              return config
            end
            
            -- Recursively check parent directories up to root
            local dir = current_dir
            while dir ~= '/' and dir ~= '' do
              local parent_dir = vim.fn.fnamemodify(dir, ':h')
              if parent_dir == dir then -- reached root
                break
              end
              config = check_config_in_dir(parent_dir)
              if config then
                return config
              end
              dir = parent_dir
            end
            
            return nil -- no config found
          end
          
          -- Find config file and set working directory
          local config_file = find_golangci_config()
          if config_file then
            local config_dir = vim.fn.fnamemodify(config_file, ':h')
            -- Change working directory to where config is located
            client.config.cmd = { 'sh', '-c', string.format('cd %s && golangci-lint-langserver', vim.fn.shellescape(config_dir)) }
          end
        end,
      })

      -- --------------------------------------------------------------------------
      -- 2. Setup Mason-LSPConfig with automatic_enable
      -- --------------------------------------------------------------------------
      require('mason-lspconfig').setup({
        ensure_installed = {
          'html', 'cssls', 'jsonls', 'ts_ls',
          'lua_ls', 'pyright', 'bashls', 'rust_analyzer', 'ruby_lsp',
          'gopls',
          'golangci_lint_ls', -- Re-enabled for diagnostics
        },
        automatic_enable = true,
      })

      -- --------------------------------------------------------------------------
      -- 3. Diagnostics Configuration (Default Formatter)
      -- --------------------------------------------------------------------------

      -- This is the config table we want to apply.
      -- The custom `format` function has been removed from `virtual_text`.
      local diagnostic_config = {
        virtual_text = {
          source = 'always',
          spacing = 4,
          prefix = '●',
          -- NO format function here, so Neovim uses its default
        },
        signs = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          source = 'always',
          border = 'rounded',
          wrap = true,
          max_width = 120,
          max_height = 30,
          focusable = true,
          header = '',
          prefix = '',
        },
      }

      -- Wrap in vim.schedule() to ensure this config is applied *last*,
      -- overriding any defaults set by other plugins.
      vim.schedule(function()
        vim.diagnostic.config(diagnostic_config)
      end)

      -- Set updatetime for better responsiveness
      vim.opt.updatetime = 300

      -- Auto-show full diagnostic on cursor hold
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        group = vim.api.nvim_create_augroup('float_diagnostic', { clear = true }),
        callback = function()
          vim.diagnostic.open_float(nil, {
            focus = false,
            close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
            scope = 'cursor',
            header = '',
          })
        end,
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

        -- Quick diagnostic view with 'gl' (go lint)
        vim.keymap.set('n', 'gl', function()
          vim.diagnostic.open_float(nil, {
            border = 'rounded',
            source = 'always',
            wrap = true,
            max_width = 120,
          })
        end, vim.tbl_extend('force', base_opts, { desc = 'Show line diagnostics' }))

        -- Additional diagnostic keymaps
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, vim.tbl_extend('force', base_opts, { desc = 'Diagnostic [Q]uickfix' }))
        vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist, vim.tbl_extend('force', base_opts, { desc = 'All Diagnostics [Q]uickfix' }))
        
        -- Toggle virtual text on/off
        vim.keymap.set('n', '<leader>td', function()
          local current_config = vim.diagnostic.config()
          local is_enabled = current_config.virtual_text ~= false
          
          -- This toggle now re-uses the `virtual_text` table from our
          -- main `diagnostic_config`, which no longer has a format function.
          vim.diagnostic.config({
            virtual_text = not is_enabled and diagnostic_config.virtual_text or false,
          })
          
          vim.notify('Virtual text: ' .. (not is_enabled and 'ON' or 'OFF'), vim.log.levels.INFO)
        end, vim.tbl_extend('force', base_opts, { desc = '[T]oggle [D]iagnostic virtual text' }))
      end

      local lsp_filetypes = {
        'ruby', 'eruby', 'lua', 'html', 'css', 'json',
        'typescript', 'javascript', 'python', 'bash', 'rust',
        'go', 'gomod', 'gowork', 'gotmpl',
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

      local function rubocop_exists()
        return vim.fn.executable(RUBOCOP_PATH) == 1 or vim.fn.executable('rubocop') == 1
      end

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

          if file_path == '' or vim.fn.filereadable(file_path) == 0 then
            return
          end

          local cmd = string.format('%s -A %s', rubocop_cmd, vim.fn.shellescape(file_path))
          local output = vim.fn.system(cmd)
          local exit_code = vim.v.shell_error

          if exit_code == 0 or exit_code == 1 then
            vim.cmd('checktime')
          else
            vim.notify('RuboCop failed: ' .. output, vim.log.levels.ERROR)
          end
        end,
      })

      -- --------------------------------------------------------------------------
      -- 6. Go Auto-format, Organize Imports, and Lint Autofix on Save
      -- --------------------------------------------------------------------------
      
      -- Go formatting and import organization on save
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = { '*.go' },
        group = vim.api.nvim_create_augroup('GoFormatting', { clear = true }),
        callback = function()
          -- Format with gopls
          vim.lsp.buf.format({ timeout_ms = 3000 })

          -- Organize imports
          local params = vim.lsp.util.make_range_params()
          params.context = { only = { 'source.organizeImports' } }
          local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 3000)
          for _, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
              if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, 'utf-8')
              end
            end
          end
        end,
      })

      -- Go lint autofix on save (similar to Ruby RuboCop)
      local function golangci_lint_exists()
        return vim.fn.executable('golangci-lint') == 1
      end

      local function find_golangci_config_for_autofix()
        local current_dir = vim.fn.expand('%:p:h')
        local config_files = { '.golangci.yaml', '.golangci.yml' }
        
        -- Function to check if config file exists in a directory
        local function check_config_in_dir(dir)
          for _, config_file in ipairs(config_files) do
            local config_path = dir .. '/' .. config_file
            if vim.fn.filereadable(config_path) == 1 then
              return config_path
            end
          end
          return nil
        end
        
        -- Check current directory first
        local config = check_config_in_dir(current_dir)
        if config then
          return config
        end
        
        -- Recursively check parent directories up to root
        local dir = current_dir
        while dir ~= '/' and dir ~= '' do
          local parent_dir = vim.fn.fnamemodify(dir, ':h')
          if parent_dir == dir then -- reached root
            break
          end
          config = check_config_in_dir(parent_dir)
          if config then
            return config
          end
          dir = parent_dir
        end
        
        return nil -- no config found
      end

      -- Go lint autofix temporarily disabled
      --[[
      -- Track if file was actually written to prevent running on file open
      local file_write_times = {}
      
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = { '*.go' },
        group = vim.api.nvim_create_augroup('GoLintPreWrite', { clear = true }),
        callback = function(args)
          local file_path = vim.api.nvim_buf_get_name(args.buf)
          if file_path ~= '' then
            file_write_times[file_path] = vim.fn.getftime(file_path)
          end
        end,
      })
      --]]

      --[[
      vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = { '*.go' },
        group = vim.api.nvim_create_augroup('GoLinting', { clear = true }),
        callback = function(args)
          if not golangci_lint_exists() then
            vim.notify('golangci-lint not found', vim.log.levels.WARN)
            return
          end

          local file_path = vim.api.nvim_buf_get_name(args.buf)
          if file_path == '' or vim.fn.filereadable(file_path) == 0 then
            return
          end

          -- Only run if file was actually written (not just opened)
          local current_time = vim.fn.getftime(file_path)
          local previous_time = file_write_times[file_path]
          if not previous_time or current_time <= previous_time then
            return
          end

          -- Find golangci-lint config file
          local config_file = find_golangci_config_for_autofix()
          local cmd
          
          if config_file then
            -- Extract directory from config file path
            local working_dir = vim.fn.fnamemodify(config_file, ':h')
            -- Get relative path from config directory to file
            local file_dir = vim.fn.fnamemodify(file_path, ':h')
            local file_name = vim.fn.fnamemodify(file_path, ':t')
            
            -- Calculate relative path from config dir to file
            local relative_path = vim.fn.fnamemodify(file_path, ':p')
            local config_dir = vim.fn.fnamemodify(config_file, ':p:h')
            
            -- Use vim.fn.fnamemodify to get relative path
            local relative_file_path = vim.fn.fnamemodify(relative_path, ':p')
            local relative_file = relative_file_path:gsub('^' .. vim.fn.escape(config_dir, '\\') .. '/', '')
            
            cmd = string.format('cd %s && golangci-lint run --fix %s', 
                               vim.fn.shellescape(working_dir), 
                               vim.fn.shellescape(relative_file))
            
          else
            -- No config found, run from file's directory
            local working_dir = vim.fn.fnamemodify(file_path, ':h')
            local file_name = vim.fn.fnamemodify(file_path, ':t')
            cmd = string.format('cd %s && golangci-lint run --fix %s', 
                               vim.fn.shellescape(working_dir), 
                               vim.fn.shellescape(file_name))
            
          end

          local output = vim.fn.system(cmd)
          local exit_code = vim.v.shell_error

          if exit_code == 0 or exit_code == 1 then
            vim.cmd('checktime')
          else
            vim.notify('golangci-lint failed: ' .. output, vim.log.levels.ERROR)
          end
        end,
      })
      --]]

      -- Go lint autofix on save (simplified version)
      local function golangci_lint_exists()
        return vim.fn.executable('golangci-lint') == 1
      end

      local function find_golangci_config_for_autofix()
        local current_dir = vim.fn.expand('%:p:h')
        local config_files = { '.golangci.yaml', '.golangci.yml' }
        
        -- Function to check if config file exists in a directory
        local function check_config_in_dir(dir)
          for _, config_file in ipairs(config_files) do
            local config_path = dir .. '/' .. config_file
            if vim.fn.filereadable(config_path) == 1 then
              return config_path
            end
          end
          return nil
        end
        
        -- Check current directory first
        local config = check_config_in_dir(current_dir)
        if config then
          return config
        end
        
        -- Recursively check parent directories up to root
        local dir = current_dir
        while dir ~= '/' and dir ~= '' do
          local parent_dir = vim.fn.fnamemodify(dir, ':h')
          if parent_dir == dir then -- reached root
            break
          end
          config = check_config_in_dir(parent_dir)
          if config then
            return config
          end
          dir = parent_dir
        end
        
        return nil -- no config found
      end

      vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = { '*.go' },
        group = vim.api.nvim_create_augroup('GoLinting', { clear = true }),
        callback = function(args)
          if not golangci_lint_exists() then
            return -- silently skip if golangci-lint not available
          end

          local file_path = vim.api.nvim_buf_get_name(args.buf)
          if file_path == '' or vim.fn.filereadable(file_path) == 0 then
            return
          end

          -- Find golangci-lint config file
          local config_file = find_golangci_config_for_autofix()
          local cmd
          
          if config_file then
            -- Extract directory from config file path
            local working_dir = vim.fn.fnamemodify(config_file, ':h')
            -- Get relative path from config directory to file
            local relative_path = vim.fn.fnamemodify(file_path, ':p')
            local config_dir = vim.fn.fnamemodify(config_file, ':p:h')
            
            -- Calculate relative path from config dir to file
            local relative_file = relative_path:gsub('^' .. vim.fn.escape(config_dir, '\\') .. '/', '')
            
            cmd = string.format('cd %s && golangci-lint run --fix %s', 
                               vim.fn.shellescape(working_dir), 
                               vim.fn.shellescape(relative_file))
          else
            -- No config found, run from file's directory
            local working_dir = vim.fn.fnamemodify(file_path, ':h')
            local file_name = vim.fn.fnamemodify(file_path, ':t')
            cmd = string.format('cd %s && golangci-lint run --fix %s', 
                               vim.fn.shellescape(working_dir), 
                               vim.fn.shellescape(file_name))
          end

          local output = vim.fn.system(cmd)
          local exit_code = vim.v.shell_error

          if exit_code == 0 or exit_code == 1 then
            vim.cmd('checktime')
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
        'go', 'gomod',
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
