# Neovide Integration Guide

This Neovim configuration includes full Neovide GUI support with optimized settings for a smooth, beautiful editing experience.

## Installation

### macOS
```bash
# Using Homebrew
brew install --cask neovide

# Or download from GitHub releases
# https://github.com/neovide/neovide/releases
```

### Linux
```bash
# Using your package manager or download from releases
# https://github.com/neovide/neovide/releases
```

### Windows
Download the installer from [GitHub Releases](https://github.com/neovide/neovide/releases)

## Configuration

The Neovide configuration is automatically loaded when you run Neovim inside Neovide. All settings are in `lua/config/neovide.lua`.

### Key Features Configured

1. **Font**: JetBrainsMono Nerd Font (size 14)
   - Change in `lua/config/neovide.lua`: `vim.g.neovide_font`
   - Popular alternatives: "FiraCode Nerd Font", "CascadiaCode Nerd Font"

2. **Animations**: Smooth cursor animations with particle effects
   - Cursor trail and particle effects enabled
   - Customizable via keymaps

3. **Performance**: Optimized refresh rates and rendering
   - 60 FPS during editing
   - 5 FPS when idle

4. **Transparency**: 95% opacity with background blur support

## Keymaps

### Font Size
- `<C-=>` - Increase font size
- `<C-->` - Decrease font size  
- `<C-0>` - Reset font size to default

### Visual Effects
- `,cp` - Toggle cursor particle effects
- `,ct` - Toggle transparency

### Default Neovide Shortcuts
- `Ctrl+Plus` / `Ctrl+Minus` - Zoom in/out (also works)
- `Ctrl+0` - Reset zoom

## Customization

### Change Font

Edit `lua/config/neovide.lua`:
```lua
vim.g.neovide_font = "YourFont Nerd Font:h14"
```

Make sure you have the font installed. Popular choices:
- JetBrainsMono Nerd Font
- FiraCode Nerd Font
- CascadiaCode Nerd Font
- Hack Nerd Font

### Adjust Cursor Effects

Edit `lua/config/neovide.lua`:
```lua
-- Change particle effect style
vim.g.neovide_cursor_vfx_mode = "railgun"  -- Options: "railgun", "torpedo", "pixiedust", "sonicboom", "ripple", "wireframe"

-- Adjust particle density
vim.g.neovide_cursor_vfx_particle_density = 7.0  -- Higher = more particles

-- Adjust particle speed
vim.g.neovide_cursor_vfx_speed = 10.0  -- Higher = faster
```

### Adjust Transparency

Edit `lua/config/neovide.lua`:
```lua
vim.g.neovide_transparency = 0.95  -- 0.0 = fully transparent, 1.0 = opaque
```

### Performance Tuning

For better performance on slower machines:
```lua
vim.g.neovide_refresh_rate = 30  -- Lower FPS
vim.g.neovide_refresh_rate_idle = 5
vim.g.neovide_cursor_vfx_mode = ""  -- Disable particles
```

For maximum smoothness on powerful machines:
```lua
vim.g.neovide_refresh_rate = 120  -- Higher FPS
vim.g.neovide_multigrid = true  -- Better for large files
```

## Running Neovide

### macOS
```bash
# Launch from terminal
neovide

# Or open specific file
neovide path/to/file.go

# Or open with your Neovim config
neovide -- -u ~/.config/nvim/init.lua
```

### Create Application Shortcut (macOS)

You can create an alias or add to your PATH:
```bash
# Add to ~/.zshrc or ~/.bashrc
alias nv='neovide'
```

## Troubleshooting

### Font Not Found
- Install the Nerd Font you're using
- Download from: https://www.nerdfonts.com/
- Or change to a system font you have installed

### Performance Issues
- Reduce refresh rate: `vim.g.neovide_refresh_rate = 30`
- Disable cursor particles: `vim.g.neovide_cursor_vfx_mode = ""`
- Disable transparency: `vim.g.neovide_transparency = 1.0`

### Cursor Not Visible
- Check cursor settings in `init.lua`
- Try different cursor modes in Neovide settings

### Configuration Not Loading
- Ensure `lua/config/neovide.lua` exists
- Check that `require("config.neovide").setup()` is in `init.lua`
- Verify Neovide is detecting Neovim: `:echo v:progname` should show "neovide"

## Benefits Over Terminal Neovim

✅ **Smooth animations** - GPU-accelerated rendering  
✅ **Better font rendering** - Ligatures and subpixel antialiasing  
✅ **Cursor effects** - Beautiful particle effects  
✅ **Transparency** - Modern blurred background  
✅ **Better clipboard** - Improved system clipboard integration  
✅ **Window management** - Native window controls  
✅ **Performance** - GPU acceleration for large files  

## All Your Config Works!

All your existing Neovim configuration works perfectly in Neovide:
- ✅ LSP and diagnostics
- ✅ All plugins (Telescope, Treesitter, etc.)
- ✅ Keymaps and settings
- ✅ Themes (Gruvbox, Catppuccin, etc.)
- ✅ Everything else!

Neovide is just a different frontend - your config is 100% compatible.
