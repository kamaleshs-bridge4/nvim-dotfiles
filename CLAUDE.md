# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration (requires Neovim 0.11+) using lazy.nvim as the plugin manager. The configuration emphasizes transparency, minimal UI, and developer productivity.

## Architecture

- **Entry point**: `init.lua` - Contains core settings, transparency system, and autocommands
- **Plugin manager bootstrap**: `lua/config/lazy.lua` - Sets up lazy.nvim with leader key `,`
- **Plugin configurations**: `lua/plugins/*.lua` - Each plugin has its own file (separation of concerns)

Plugins are lazy-loaded and automatically imported from the `plugins/` directory.

## Key Configuration Details

- **Leader key**: `,` (comma)
- **Default colorscheme**: `catppuccin-frappe`
- **Indentation**: 2 spaces (except Go files which use 8-space tabs per Go convention, Java files use 4 spaces)
- **Transparency**: Fully transparent backgrounds, reapplied on colorscheme changes via autocommand
- **Diagnostics**: Uses undercurl (squiggly underlines), no virtual text

## LSP Servers

Auto-installed via Mason: `lua_ls`, `gopls`, `rust_analyzer`, `ts_ls`, `pyright`, `ruby_lsp`, `bashls`, `html`, `cssls`, `jsonls`, `eslint`, `golangci_lint_ls`, `jdtls`

LSP servers are enabled via `vim.lsp.enable()` in `lua/plugins/lsp.lua`.

## Adding/Modifying Plugins

Create or edit files in `lua/plugins/`. Each file should return a lazy.nvim plugin spec:

```lua
return {
  "author/plugin-name",
  dependencies = { ... },
  config = function()
    -- configuration
  end,
}
```

## Common Commands

```bash
nvim                    # Start (plugins auto-install on first run)
:Lazy                   # Open plugin manager UI
:Mason                  # Open LSP server installer UI
:checkhealth            # Diagnose configuration issues
```

## Key Keybindings

| Key | Action |
|-----|--------|
| `-` | Toggle file explorer |
| `<leader>ff` | Find files |
| `<leader>fs` | Live grep |
| `<leader>t` | Toggle terminal |
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover documentation |
| `<leader>ca` | Code actions |
| `<leader>cf` | Format buffer |
