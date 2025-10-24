return {
  "ellisonleao/gruvbox.nvim",
  name = "gruvbox", -- Optional, but good practice
  priority = 1000, -- Make sure to load this before all the other start plugins
  config = function()
    -- Set the contrast to 'hard' for the dark theme
    vim.g.gruvbox_contrast_dark = "hard"

    -- Load the colorscheme
    vim.cmd.colorscheme("gruvbox")

    -- *** This is the key code to make the background transparent ***
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- You may also want to set NonText and other window backgrounds to none
    vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

  end,
}
