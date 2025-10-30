-- nvim-dap configuration for Go debugging
return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
    },
    keys = {
      -- Debug keymaps
      { '<F5>', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
      { '<F1>', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
      { '<F2>', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
      { '<F3>', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
      { '<F4>', function() require('dap').restart() end, desc = 'Debug: Restart' },
      { '<F6>', function() require('dap').pause() end, desc = 'Debug: Pause' },
      { '<F7>', function() require('dap').stop() end, desc = 'Debug: Stop' },
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
      { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = 'Debug: Set Conditional Breakpoint' },
      { '<leader>dM', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, desc = 'Debug: Set Log Point' },
      { '<leader>dr', function() require('dap').repl.open() end, desc = 'Debug: Open REPL' },
      { '<leader>dl', function() require('dap').run_last() end, desc = 'Debug: Run Last' },
      { '<leader>du', function() require('dapui').toggle() end, desc = 'Debug: Toggle UI' },
      { '<leader>dc', function() require('dap').continue() end, desc = 'Debug: Continue' },
      { '<leader>dt', function() require('dap').run_to_cursor() end, desc = 'Debug: Run to Cursor' },
      { '<leader>dT', function() require('dap').terminate() end, desc = 'Debug: Terminate' },
      { '<leader>dC', function() require('dap').clear_breakpoints() end, desc = 'Debug: Clear Breakpoints' },
      { '<leader>dL', function() require('dap').list_breakpoints() end, desc = 'Debug: List Breakpoints' },
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')
      
      -- Configure DAP UI
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = 'scopes', size = 0.25 },
              { id = 'breakpoints', size = 0.25 },
              { id = 'stacks', size = 0.25 },
              { id = 'watches', size = 0.25 },
            },
            position = 'left',
            size = 40,
          },
          {
            elements = {
              { id = 'repl', size = 0.5 },
              { id = 'console', size = 0.5 },
            },
            position = 'bottom',
            size = 10,
          },
        },
      })
      
      -- Auto-open/close DAP UI
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
      
      -- Go debugger configuration
      dap.adapters.go = {
        type = 'executable',
        command = 'dlv',
        args = { 'dap', '-l', '127.0.0.1:38697' },
      }
      
      -- Helper function to find main.go in current directory or parent
      local function find_main_go()
        local current_dir = vim.fn.expand('%:p:h')
        local main_files = { 'main.go', 'cmd/main.go' }
        
        -- Check current directory first
        for _, main_file in ipairs(main_files) do
          local main_path = current_dir .. '/' .. main_file
          if vim.fn.filereadable(main_path) == 1 then
            return main_path
          end
        end
        
        -- Check parent directory (for workspace structure)
        local parent_dir = vim.fn.fnamemodify(current_dir, ':h')
        for _, main_file in ipairs(main_files) do
          local main_path = parent_dir .. '/' .. main_file
          if vim.fn.filereadable(main_path) == 1 then
            return main_path
          end
        end
        
        return '${file}' -- fallback to current file
      end
      
      dap.configurations.go = {
        {
          type = 'go',
          name = 'Debug Current File',
          request = 'launch',
          program = '${file}',
        },
        {
          type = 'go',
          name = 'Debug Main.go (Auto-find)',
          request = 'launch',
          program = find_main_go(),
        },
        {
          type = 'go',
          name = 'Debug Package',
          request = 'launch',
          program = '${fileDirname}',
        },
        {
          type = 'go',
          name = 'Debug Workspace Root',
          request = 'launch',
          program = '${workspaceFolder}',
        },
        {
          type = 'go',
          name = 'Debug Test (Current File)',
          request = 'launch',
          mode = 'test',
          program = '${file}',
        },
        {
          type = 'go',
          name = 'Debug Test (Specific)',
          request = 'launch',
          mode = 'test',
          program = '${file}',
          args = { '-test.run', '^${input:testName}$' },
        },
        {
          type = 'go',
          name = 'Debug Test (Package)',
          request = 'launch',
          mode = 'test',
          program = '${fileDirname}',
        },
        {
          type = 'go',
          name = 'Debug Test (Workspace)',
          request = 'launch',
          mode = 'test',
          program = '${workspaceFolder}',
        },
        {
          type = 'go',
          name = 'Attach to Process',
          request = 'attach',
          mode = 'local',
          processId = '${command:pickProcess}',
        },
      }
      
      -- Virtual text configuration
      require('nvim-dap-virtual-text').setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        filter_references_pattern = '<module',
        virt_text_pos = 'eol',
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil,
      })
    end,
  },
  
  -- DAP UI
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap' },
  },
  
  -- Virtual text for DAP
  {
    'theHamsta/nvim-dap-virtual-text',
    dependencies = { 'mfussenegger/nvim-dap' },
  },
}