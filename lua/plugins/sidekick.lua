-- Sidekick.nvim - AI assistant with Cursor agent integration
-- Reference: https://github.com/folke/sidekick.nvim
return {
  "folke/sidekick.nvim",
  event = "VeryLazy",
  opts = {
    -- Enable/disable Next Edit Suggestions (requires GitHub Copilot)
    nes = {
      enabled = true,
      auto_trigger = true, -- Automatically fetch suggestions
    },
    
    -- CLI tool configuration
    cli = {
      -- Terminal multiplexer for persistent sessions (disabled by default)
      -- To enable: install tmux (brew install tmux) or zellij, then set enabled = true
      mux = {
        enabled = false, -- Disabled until tmux/zellij is installed
        backend = "tmux", -- or "zellij" if you prefer
      },
      
      -- Configure tools - Cursor agent is included
      tools = {
        -- Cursor agent (you mentioned you have it installed)
        cursor = {
          cmd = { "cursor", "agent" },
          -- Custom keymaps for cursor agent
          keys = {
            submit = { "<c-s>", function(t) t:send("\n") end },
            close = { "<c-c>", function(t) t:close() end },
          },
        },
        -- Add other AI tools if you have them
        -- claude = {
        --   cmd = { "claude" },
        -- },
      },
      
      -- Custom prompts for quick access
      prompts = {
        -- Code improvement prompts
        refactor = "Please refactor the following code to be more maintainable and follow best practices:\n{selection}",
        optimize = "Optimize this code for better performance:\n{selection}",
        explain = "Explain what this code does in detail:\n{selection}",
        
        -- Documentation prompts
        document = "Add comprehensive documentation/comments to this code:\n{selection}",
        
        -- Testing prompts
        test = "Generate comprehensive unit tests for this code:\n{selection}",
        
        -- Security and quality
        security = "Review this code for security vulnerabilities and suggest improvements:\n{selection}",
        lint = "Review this code and suggest improvements for code quality:\n{selection}",
        
        -- Debugging
        debug = "Help me debug this code. What could be wrong?\n{selection}",
        
        -- Custom prompt using context
        custom = function(ctx)
          return string.format(
            "I'm working on file %s at line %d. Help me with the following:\n",
            vim.fn.fnamemodify(ctx.file, ":~:."),
            ctx.row
          )
        end,
      },
      
      -- Window configuration
      win = {
        position = "bottom", -- bottom, top, left, right
        size = 0.4, -- 40% of editor height/width
        border = "rounded", -- rounded borders for consistency
      },
      
    },
    
    -- Notification configuration
    notify = {
      enabled = true,
      level = vim.log.levels.INFO,
    },
  },
  
  -- Keymaps
  keys = {
    -- NES (Next Edit Suggestions) keymaps
    { "<leader>ae", "<cmd>Sidekick nes toggle<cr>", desc = "Toggle AI Edit Suggestions" },
    { "<leader>au", "<cmd>Sidekick nes update<cr>", desc = "Update AI Suggestions" },
    { "<leader>ac", "<cmd>Sidekick nes clear<cr>", desc = "Clear AI Suggestions" },
    
    -- CLI keymaps
    { "<leader>aa", "<cmd>Sidekick cli toggle<cr>", desc = "Toggle AI Assistant" },
    { "<leader>af", "<cmd>Sidekick cli focus<cr>", desc = "Focus AI Assistant" },
    { "<leader>as", "<cmd>Sidekick cli select<cr>", desc = "Select AI Tool" },
    { "<leader>ap", "<cmd>Sidekick cli prompt<cr>", desc = "AI Prompt" },
    
    -- Send selection to AI
    { "<leader>ai", ":'<,'>Sidekick cli send msg=\"{selection}\"<cr>", mode = "v", desc = "Send to AI" },
    
    -- Quick prompts in visual mode
    { "<leader>ar", ":'<,'>Sidekick cli prompt name=refactor<cr>", mode = "v", desc = "Refactor Code" },
    { "<leader>ae", ":'<,'>Sidekick cli prompt name=explain<cr>", mode = "v", desc = "Explain Code" },
    { "<leader>at", ":'<,'>Sidekick cli prompt name=test<cr>", mode = "v", desc = "Generate Tests" },
    { "<leader>ad", ":'<,'>Sidekick cli prompt name=document<cr>", mode = "v", desc = "Document Code" },
  },
  
  config = function(_, opts)
    require("sidekick").setup(opts)
    
    -- Add terminal keymaps for all terminal buffers (including sidekick)
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "*",
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        -- Map ESC to exit terminal mode to normal mode for all terminal buffers
        vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {
          desc = 'Exit Terminal Mode to Normal Mode',
          buffer = bufnr,
          nowait = true,
          silent = true,
        })
        
        -- Also add a keymap to re-enter terminal mode from normal mode
        vim.keymap.set('n', 'i', 'a', {
          desc = 'Re-enter Terminal Insert Mode',
          buffer = bufnr,
          nowait = true,
          silent = true,
        })
      end,
    })
    
    -- Integrate with lualine (statusline)
    if pcall(require, "lualine") then
      local lualine_config = require("lualine").get_config()
      
      -- Add Copilot status to lualine
      table.insert(lualine_config.sections.lualine_x, 1, {
        function()
          local status = require("sidekick.status").get()
          if status then
            if status.kind == "Error" then
              return " "
            elseif status.busy then
              return " "
            else
              return " "
            end
          end
          return ""
        end,
        color = function()
          local status = require("sidekick.status").get()
          if status then
            if status.kind == "Error" then
              return { fg = "DiagnosticError" } -- Use theme colors
            elseif status.busy then
              return { fg = "DiagnosticWarn" } -- Use theme colors
            else
              return { fg = "DiagnosticOk" } -- Use theme colors
            end
          end
          return { fg = "Comment" } -- Use theme colors
        end,
        cond = function()
          return require("sidekick.status").get() ~= nil
        end,
      })
      
      -- Add CLI session indicator
      table.insert(lualine_config.sections.lualine_x, 2, {
        function()
          local status = require("sidekick.status").cli()
          if #status > 1 then
            return " " .. #status
          elseif #status == 1 then
            return " "
          end
          return ""
        end,
        color = { fg = "#89b4fa" }, -- Catppuccin blue
        cond = function()
          return #require("sidekick.status").cli() > 0
        end,
      })
      
      require("lualine").setup(lualine_config)
    end
  end,
}

