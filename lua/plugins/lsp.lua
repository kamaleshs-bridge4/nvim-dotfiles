return {
  -- =======================================================================
  -- LSP CONFIGURATION
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
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- --------------------------------------------------------------------------
      -- LSP Server Configurations
      -- --------------------------------------------------------------------------
      -- Note: Must be defined before mason-lspconfig.setup()

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

      vim.lsp.config('html', {
        cmd = { 'vscode-html-language-server', '--stdio' },
        filetypes = { 'html' },
        root_markers = { '.git' },
        capabilities = capabilities,
      })

      vim.lsp.config('cssls', {
        cmd = { 'vscode-css-language-server', '--stdio' },
        filetypes = { 'css', 'scss', 'less' },
        root_markers = { '.git' },
        capabilities = capabilities,
      })

      vim.lsp.config('jsonls', {
        cmd = { 'vscode-json-language-server', '--stdio' },
        filetypes = { 'json', 'jsonc' },
        root_markers = { '.git' },
        capabilities = capabilities,
      })

      vim.lsp.config('ts_ls', {
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
        root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
        capabilities = capabilities,
      })

      vim.lsp.config('pyright', {
        cmd = { 'pyright-langserver', '--stdio' },
        filetypes = { 'python' },
        root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json', '.git' },
        capabilities = capabilities,
      })

      vim.lsp.config('bashls', {
        cmd = { 'bash-language-server', 'start' },
        filetypes = { 'sh' },
        root_markers = { '.git' },
        capabilities = capabilities,
      })

      vim.lsp.config('rust_analyzer', {
        cmd = { 'rust-analyzer' },
        filetypes = { 'rust' },
        root_markers = { 'Cargo.toml', 'rust-project.json' },
        capabilities = capabilities,
      })

      vim.lsp.config('gopls', {
        cmd = { 'gopls' },
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        root_markers = { 'go.mod', 'go.work', '.git' },
        capabilities = capabilities,
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            staticcheck = true,
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

      vim.lsp.config('golangci_lint_ls', {
        cmd = { 'golangci-lint-langserver' },
        filetypes = { 'go', 'gomod' },
        root_markers = { 'go.mod', '.golangci.yaml', '.golangci.yml', '.git' },
        capabilities = capabilities,
        init_options = {
          command = {
            'golangci-lint', 'run',
            '--output.text.path', '/dev/null',
            '--output.json.path', 'stdout',
            '--show-stats=false',
            '--issues-exit-code=1',
          },
        },
      })

      -- --------------------------------------------------------------------------
      -- Mason LSP Setup
      -- --------------------------------------------------------------------------
      require('mason-lspconfig').setup({
        ensure_installed = {
          'html', 'cssls', 'jsonls', 'ts_ls',
          'lua_ls', 'pyright', 'bashls', 'rust_analyzer', 'ruby_lsp',
          'gopls', 'golangci_lint_ls',
        },
        automatic_enable = true,
      })

      -- --------------------------------------------------------------------------
      -- Diagnostics Configuration
      -- --------------------------------------------------------------------------
      -- Expand single-character diagnostics to full word (fixes golangci-lint)
      local orig_underline_show = vim.diagnostic.handlers.underline.show
      local orig_underline_hide = vim.diagnostic.handlers.underline.hide
      
      vim.diagnostic.handlers.underline = {
        show = function(namespace, bufnr, diagnostics, opts)
          local adjusted = {}
          for _, d in ipairs(diagnostics) do
            local diag = vim.deepcopy(d)
            -- If diagnostic is single character or zero-width, expand to word
            if not diag.end_col or diag.col == diag.end_col or (diag.end_col - diag.col <= 1) then
              local line = vim.api.nvim_buf_get_lines(bufnr, diag.lnum, diag.lnum + 1, false)[1]
              if line then
                -- Find word boundaries (1-indexed for string operations)
                local col = diag.col + 1  -- Convert to 1-indexed
                local start_col = col
                local end_col = col
                -- Expand backward to start of word
                while start_col > 1 and line:sub(start_col - 1, start_col - 1):match('[%w_]') do
                  start_col = start_col - 1
                end
                -- Expand forward to end of word
                while end_col <= #line and line:sub(end_col, end_col):match('[%w_]') do
                  end_col = end_col + 1
                end
                diag.col = start_col - 1  -- Convert back to 0-indexed
                diag.end_col = end_col - 1
              end
            end
            table.insert(adjusted, diag)
          end
          orig_underline_show(namespace, bufnr, adjusted, opts)
        end,
        hide = orig_underline_hide,
      }

      -- Virtual text disabled - diagnostics shown on demand via K keymap
      local diagnostic_config = {
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        severity_sort = true,
        underline = true,
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

      -- Configure squiggly underlines using theme colors
      local function setup_squiggly_underlines()
        local function get_diagnostic_color(hl_name)
          local hl = vim.api.nvim_get_hl(0, { name = hl_name })
          return hl.fg or hl.foreground or nil
        end
        
        local severities = {
          { name = 'Error', hl = 'DiagnosticError' },
          { name = 'Warn', hl = 'DiagnosticWarn' },
          { name = 'Info', hl = 'DiagnosticInfo' },
          { name = 'Hint', hl = 'DiagnosticHint' },
        }
        
        for _, severity in ipairs(severities) do
          local color = get_diagnostic_color(severity.hl)
          -- Force undercurl style for all severities (consistent squiggly lines)
          vim.api.nvim_set_hl(0, 'DiagnosticUnderline' .. severity.name, {
            undercurl = true,
            underline = false,
            underdouble = false,
            underdotted = false,
            underdashed = false,
            sp = color,
          })
        end
      end

      -- Apply diagnostic config after other plugins
      vim.schedule(function()
        vim.diagnostic.config(diagnostic_config)
        setup_squiggly_underlines()
      end)

      -- Reapply underlines when colorscheme changes
      vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('DiagnosticSquiggly', { clear = true }),
        callback = setup_squiggly_underlines,
      })

      vim.opt.updatetime = 300

      -- Utility command to open LSP log
      vim.api.nvim_create_user_command('LspLog', function()
        vim.cmd.edit(vim.lsp.get_log_path())
      end, { desc = 'Open LSP log file' })

      -- Ensure diagnostics are displayed when they change
      vim.api.nvim_create_autocmd('DiagnosticChanged', {
        group = vim.api.nvim_create_augroup('LspDiagnosticDisplay', { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          if bufnr == 0 then bufnr = vim.api.nvim_get_current_buf() end
          
          if vim.diagnostic.is_enabled({ bufnr = bufnr }) then
            vim.diagnostic.show(nil, bufnr)
          end
        end,
      })
      
      -- Enable diagnostics when LSP attaches
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('LspDiagnostics', { clear = true }),
        callback = function(args)
          vim.diagnostic.enable(args.buf)
        end,
      })

      -- --------------------------------------------------------------------------
      -- LSP Keymaps
      -- --------------------------------------------------------------------------
      -- Shared float options for consistent styling
      local float_opts = {
        border = 'rounded',
        max_width = 120,
        max_height = 30,
      }

      -- Track hover window for re-entry
      local hover_win = nil

      -- Custom hover with border
      local function hover_with_border()
        local params = vim.lsp.util.make_position_params()
        vim.lsp.buf_request(0, 'textDocument/hover', params, function(err, result, ctx, _)
          if err then return end
          if not (result and result.contents) then return end
          local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
          markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
          if vim.tbl_isempty(markdown_lines) then return end
          
          -- Close existing hover window if it exists
          if hover_win and vim.api.nvim_win_is_valid(hover_win) then
            vim.api.nvim_win_close(hover_win, true)
          end
          
          vim.lsp.util.open_floating_preview(markdown_lines, 'markdown', float_opts)
          
          -- Find the floating window (it's the most recently created floating window)
          local all_wins = vim.api.nvim_list_wins()
          for _, win in ipairs(all_wins) do
            local win_config = vim.api.nvim_win_get_config(win)
            if win_config.relative ~= '' then  -- Floating window
              hover_win = win
              break
            end
          end
          
          -- Set up keymaps for scrolling in hover window
          if hover_win and vim.api.nvim_win_is_valid(hover_win) then
            local hover_buf = vim.api.nvim_win_get_buf(hover_win)
            local hover_opts = { noremap = true, silent = true, buffer = hover_buf }
            
            -- Enable scrolling with j/k
            vim.keymap.set('n', 'j', '<C-e>', hover_opts)
            vim.keymap.set('n', 'k', '<C-y>', hover_opts)
            vim.keymap.set('n', '<Down>', '<C-e>', hover_opts)
            vim.keymap.set('n', '<Up>', '<C-y>', hover_opts)
            vim.keymap.set('n', '<PageDown>', '<C-f>', hover_opts)
            vim.keymap.set('n', '<PageUp>', '<C-b>', hover_opts)
            
            -- Close hover with q or Escape
            vim.keymap.set('n', 'q', function()
              if hover_win and vim.api.nvim_win_is_valid(hover_win) then
                vim.api.nvim_win_close(hover_win, true)
                hover_win = nil
              end
            end, hover_opts)
            vim.keymap.set('n', '<Esc>', function()
              if hover_win and vim.api.nvim_win_is_valid(hover_win) then
                vim.api.nvim_win_close(hover_win, true)
                hover_win = nil
              end
            end, hover_opts)
          end
        end)
      end
      
      -- Function to focus hover window if it exists
      local function focus_hover_window()
        if hover_win and vim.api.nvim_win_is_valid(hover_win) then
          vim.api.nvim_set_current_win(hover_win)
          return true
        end
        return false
      end

      -- Close hover window when cursor moves (unless hovering)
      local hover_autocmd_group = vim.api.nvim_create_augroup('HoverWindow', { clear = true })
      vim.api.nvim_create_autocmd('CursorMoved', {
        group = hover_autocmd_group,
        callback = function()
          -- Only close if we're not currently in the hover window
          if hover_win and vim.api.nvim_win_is_valid(hover_win) then
            local current_win = vim.api.nvim_get_current_win()
            if current_win ~= hover_win then
              vim.api.nvim_win_close(hover_win, true)
              hover_win = nil
            end
          end
        end,
      })

      local function set_lsp_keymaps()
        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { noremap = true, silent = true, buffer = bufnr }

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = '[G]oto [D]eclaration' }))
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = '[G]oto [D]efinition' }))
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = '[G]oto [I]mplementation' }))
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = '[G]oto [R]eferences' }))
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'Signature Help' }))
        vim.keymap.set('n', 'gh', hover_with_border, vim.tbl_extend('force', opts, { desc = '[H]over Documentation' }))
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'Code [A]ctions' }))
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = '[R]e[n]ame' }))
        
        -- K: Focus hover if open, otherwise show diagnostics if present, otherwise show hover
        vim.keymap.set('n', 'K', function()
          -- If hover window is open, focus it
          if focus_hover_window() then
            return
          end
          
          local line = vim.api.nvim_win_get_cursor(0)[1] - 1
          local diagnostics = vim.diagnostic.get(bufnr, { lnum = line })
          
          if #diagnostics > 0 then
            vim.diagnostic.open_float(nil, {
              focus = false,
              border = 'rounded',
              source = 'always',
              scope = 'cursor',
              header = '',
              prefix = '',
            })
          else
            hover_with_border()
          end
        end, vim.tbl_extend('force', opts, { desc = 'Show Diagnostics or Hover' }))
      end

      local lsp_filetypes = {
        'ruby', 'eruby', 'lua', 'html', 'css', 'json',
        'typescript', 'javascript', 'python', 'bash', 'rust',
        'go', 'gomod', 'gowork', 'gotmpl',
      }

      -- Set keymaps on FileType
      vim.api.nvim_create_autocmd('FileType', {
        pattern = lsp_filetypes,
        group = vim.api.nvim_create_augroup('LspKeymaps', { clear = true }),
        callback = set_lsp_keymaps,
      })
      
      -- Also set keymaps on LspAttach for reliability
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('LspAttachKeymaps', { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and vim.tbl_contains(lsp_filetypes, vim.bo[args.buf].filetype) then
            set_lsp_keymaps()
          end
        end,
      })

      -- --------------------------------------------------------------------------
      -- Ruby: RuboCop Autocorrect on Save
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
      -- Go: Format and Organize Imports on Save
      -- --------------------------------------------------------------------------
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = { '*.go' },
        group = vim.api.nvim_create_augroup('GoFormatting', { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          
          -- Find gopls client
          local clients = vim.lsp.get_clients({ bufnr = bufnr })
          local gopls_client = nil
          for _, client in ipairs(clients) do
            if client.name == 'gopls' then
              gopls_client = client
              break
            end
          end
          
          if not gopls_client then return end
          
          -- Format code
          vim.lsp.buf.format({
            timeout_ms = 3000,
            filter = function(client) return client.name == 'gopls' end
          })
          
          -- Organize imports
          local params = vim.lsp.util.make_range_params()
          params.context = { only = { 'source.organizeImports' } }
          local result = vim.lsp.buf_request_sync(bufnr, 'textDocument/codeAction', params, 3000)
          for _, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
              if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, 'utf-8')
              end
            end
          end
        end,
      })
    end,
  },

  -- =======================================================================
  -- TREE-SITTER
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
  -- COMPLETION & SNIPPETS
  -- =======================================================================
  { 'nvim-lua/plenary.nvim' },
  { 'L3MON4D3/LuaSnip' },
  { 'rafamadriz/friendly-snippets' },
  { 'onsails/lspkind.nvim' },
  { 'hrsh7th/nvim-cmp', lazy = false, config = require('plugins.nvim-cmp') },
}
