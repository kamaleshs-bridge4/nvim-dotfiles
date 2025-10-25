-- Add this to your lazy.nvim plugins list
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- Keep priority high, same as other themes
  config = function()
    -- You can set catppuccin-specific options here
    require("catppuccin").setup({
       flavour = "latte", -- Default flavour (frappe, latte, mocha, macchiato)
       -- NOTE: Our global transparency manager will override this,
       -- but you can set other options here.
       transparent_background = false,
       integrations = {
         cmp = true, 
	 treesitter = true,
       },
    })
  end,
}

