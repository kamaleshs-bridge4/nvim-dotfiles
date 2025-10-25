-- File: lua/plugins/indent.lua
-- This plugin adds vertical indentation lines

return {
  "lukas-reineke/indent-blankline.nvim",
  -- Load this plugin on startup
  event = "VeryLazy",
  -- main = "ibl", -- "ibl" is the new module name, but setup{} is fine
  config = function()
    -- Link the highlight groups to your 'NonText' color.
    -- This is typically very faint and in the background, like in Zed.
    vim.api.nvim_set_hl(0, "IblIndent", { link = "NonText" })
    vim.api.nvim_set_hl(0, "IblScope", { link = "NonText" })

    require("ibl").setup({
      -- Use the "box drawings light vertical" character
      indent = { char = "│" },
      -- Enable scope lines, which shows context lines
      scope = {
        enabled = true,
        char = "│",
        show_start = false, -- Removes the top horizontal line
        show_end = false,   -- Removes the bottom horizontal line
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
        },
      },
    })
  end,
}


