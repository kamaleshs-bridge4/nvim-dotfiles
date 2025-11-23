-- Beautiful statusline
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  config = function()
    require('lualine').setup({
      options = {
        icons_enabled = true,
        component_separators = { left = '│', right = '│' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = { 'alpha', 'dashboard' },
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true, -- Single statusline for all windows
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = {
          {
            'mode',
            fmt = function(str)
              return str:sub(1, 1) -- Show only first letter
            end,
          }
        },
        lualine_b = {
          {
            'branch',
            icon = '',
          },
          {
            'diff',
            symbols = { added = ' ', modified = ' ', removed = ' ' },
          },
        },
        lualine_c = {
          {
            'filename',
            file_status = true,
            path = 1, -- Relative path
            symbols = {
              modified = ' ●',
              readonly = ' ',
              unnamed = '[No Name]',
              newfile = ' ',
            }
          },
          {
            'diagnostics',
            sources = { 'nvim_diagnostic', 'nvim_lsp' },
            sections = { 'error', 'warn', 'info', 'hint' },
            symbols = {
              error = ' ',
              warn = ' ',
              info = ' ',
              hint = ' ',
            },
            colored = true,
            update_in_insert = false,
            always_visible = false,
          },
        },
        lualine_x = {
          {
            function()
              local msg = 'No LSP'
              local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
              local clients = vim.lsp.get_active_clients()
              if next(clients) == nil then
                return msg
              end
              for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                  return '  ' .. client.name
                end
              end
              return msg
            end,
            icon = '',
          },
          {
            'encoding',
            fmt = string.upper,
          },
          {
            'fileformat',
            symbols = {
              unix = 'LF',
              dos = 'CRLF',
              mac = 'CR',
            },
          },
          'filetype',
        },
        lualine_y = {
          {
            'progress',
            separator = ' ',
            padding = { left = 1, right = 1 },
          },
        },
        lualine_z = {
          {
            'location',
            padding = { left = 1, right = 1 },
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = { 'nvim-tree', 'toggleterm', 'quickfix' },
    })
  end,
}

