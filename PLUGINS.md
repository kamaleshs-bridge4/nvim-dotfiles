# Neovim Configuration - Complete Plugin Overview

This document provides a comprehensive overview of all plugins configured in this Neovim setup, organized by category.

---

## 📋 Table of Contents

1. [Plugin Manager](#plugin-manager)
2. [UI & Appearance](#ui--appearance)
3. [LSP & Language Support](#lsp--language-support)
4. [Completion & Snippets](#completion--snippets)
5. [File Management](#file-management)
6. [Search & Navigation](#search--navigation)
7. [Editor Enhancements](#editor-enhancements)
8. [Terminal Integration](#terminal-integration)
9. [AI Assistant](#ai-assistant)
10. [Utilities](#utilities)

---

## 🔧 Plugin Manager

### lazy.nvim
- **Repository**: [folke/lazy.nvim](https://github.com/folke/lazy.nvim)
- **Purpose**: Modern plugin manager for Neovim
- **Configuration**: `lua/config/lazy.lua`
- **Features**:
  - Lazy loading for optimal performance
  - Automatic plugin updates checking
  - Lock file for version management (`lazy-lock.json`)
  - Startup time profiling
- **Key Commands**:
  - `:Lazy` - Open plugin manager UI
  - `:Lazy sync` - Sync all plugins
  - `:Lazy update` - Update plugins
  - `:Lazy profile` - View startup performance

---

## 🎨 UI & Appearance

### 1. catppuccin.nvim
- **Repository**: [catppuccin/nvim](https://github.com/catppuccin/nvim)
- **Purpose**: Soothing pastel color scheme
- **Configuration**: `lua/plugins/catpuccin.lua`
- **Features**:
  - 4 variants: latte, frappe, macchiato, mocha
  - Theme cycling support (`<leader>cc`)
  - Custom highlights for all UI components
  - Integration with Telescope, NvimTree, Sidekick, ToggleTerm
  - Solid backgrounds for floating windows
- **Variants**:
  - `latte` - Light theme
  - `frappe` - Medium-dark theme
  - `macchiato` - Dark theme
  - `mocha` - Darkest theme (default)

### 2. gruvbox.nvim
- **Repository**: [ellisonleao/gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim)
- **Purpose**: Retro groove color scheme
- **Configuration**: `lua/plugins/gruvbox.lua`
- **Features**:
  - Warm, retro color palette
  - Unified theme switcher integration
  - Custom UI theming for all plugins
  - Theme cycling with Catppuccin variants

### 3. gruvbox-dark-hard (Custom)
- **File**: `lua/gruvbox-dark-hard.lua` + `colors/gruvbox-dark-hard.vim`
- **Purpose**: Custom Gruvbox variant with hard contrast
- **Features**:
  - Very dark background (#1d2021)
  - High contrast for better visibility
  - Consistent theming across all UI components
  - Default theme on startup

### 4. lualine.nvim
- **Repository**: [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- **Purpose**: Beautiful statusline
- **Configuration**: `lua/plugins/lualine.lua`
- **Features**:
  - Global statusline (single line for all windows)
  - Git branch and diff indicators
  - LSP client name display
  - Diagnostics count (errors, warnings, info, hints)
  - File encoding and format (LF/CRLF)
  - Progress and location indicators
  - Theme-aware (adapts to Catppuccin)
  - Disabled on dashboard/alpha buffer

### 5. alpha-nvim
- **Repository**: [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim)
- **Purpose**: Beautiful dashboard/start screen
- **Configuration**: `lua/plugins/alpha.lua`
- **Features**:
  - ASCII art "NEOVIM" header
  - Quick action buttons:
    - `f` - Find file (Telescope)
    - `s` - Search text (Telescope live_grep)
    - `r` - Recent files
    - `e` - New file
    - `c` - Open configuration
    - `u` - Update plugins
    - `q` - Quit
  - Footer with plugin count and Neovim version
  - Auto-hides statusline when active

### 6. nvim-notify
- **Repository**: [rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify)
- **Purpose**: Beautiful notification system
- **Configuration**: `lua/plugins/nvim-notify.lua`
- **Features**:
  - Fade-in slide-out animations
  - Theme-aware colors
  - Solid backgrounds matching current theme
  - Notification history via Telescope
  - Custom icons for different log levels
- **Keymaps**:
  - `<leader>nd` - Dismiss all notifications
  - `<leader>nh` - Show notification history

### 7. indent-blankline.nvim
- **Repository**: [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
- **Purpose**: Indentation guides
- **Configuration**: `lua/plugins/indent.lua`
- **Features**:
  - Subtle vertical indent lines (│)
  - Scope highlighting with thicker line (▎)
  - Language-specific scope detection (Lua, Python, JS/TS)
  - Excludes help files, alpha, telescope, etc.
  - Theme-aware colors

### 8. neoscroll.nvim
- **Repository**: [karb94/neoscroll.nvim](https://github.com/karb94/neoscroll.nvim)
- **Purpose**: Smooth scrolling animations
- **Configuration**: `lua/plugins/neoscroll.lua`
- **Features**:
  - Smooth scrolling for `<C-u>`, `<C-d>`, `<C-b>`, `<C-f>`
  - Custom easing functions (sine, circular, quadratic)
  - Configurable scroll speeds
  - Cursor hiding during scroll
  - Respects scrolloff settings

---

## 🔌 LSP & Language Support

### 1. nvim-lspconfig
- **Repository**: [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- **Purpose**: LSP configuration framework
- **Configuration**: `lua/plugins/lsp.lua`
- **Features**:
  - Native Neovim LSP client configuration
  - Multiple language servers configured
  - Auto-attach to buffers
  - Diagnostics with virtual text and floating windows
  - Code actions, hover, signature help
- **Configured Language Servers**:
  - **Lua**: `lua_ls` - Lua language server
  - **Ruby**: `ruby_lsp` - Ruby language server with Rails support
  - **Go**: `gopls` + `golangci_lint_ls` - Go language server + linter
  - **Python**: `pyright` - Python language server
  - **JavaScript/TypeScript**: `ts_ls` - TypeScript language server
  - **Rust**: `rust_analyzer` - Rust language server
  - **HTML**: `html` - HTML language server
  - **CSS**: `cssls` - CSS language server
  - **JSON**: `jsonls` - JSON language server
  - **Bash**: `bashls` - Bash language server

### 2. mason.nvim
- **Repository**: [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)
- **Purpose**: LSP/DAP/Linter installer
- **Features**:
  - Automatic language server installation
  - Easy management of LSP tools
  - UI for browsing and installing tools

### 3. mason-lspconfig.nvim
- **Repository**: [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- **Purpose**: Bridge between Mason and nvim-lspconfig
- **Features**:
  - Automatic server setup
  - Ensures servers are installed before starting
  - Configures servers with `automatic_enable = true`

### 4. nvim-treesitter
- **Repository**: [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- **Purpose**: Syntax highlighting and code parsing
- **Configuration**: `lua/plugins/nvim-treesitter.lua` + `lua/plugins/illuminate-cfg.lua`
- **Features**:
  - Tree-sitter based syntax highlighting
  - Smart indentation
  - Text objects for code navigation
  - Incremental selection
  - Language support: Lua, Vim, HTML, CSS, JavaScript, TypeScript, JSON, Markdown, Bash, Go, Ruby, Zig, Rust, Java, Python
- **Text Objects**:
  - `af` / `if` - Function outer/inner
  - `ac` / `ic` - Class outer/inner
  - `a=` / `i=` - Assignment outer/inner
  - `gnn` - Init selection
  - `grn` - Node incremental
  - `grc` - Scope incremental
  - `grm` - Node decremental

### 5. vim-illuminate
- **Repository**: [RRethy/vim-illuminate](https://github.com/RRethy/vim-illuminate)
- **Purpose**: Highlight word under cursor
- **Configuration**: `lua/plugins/illuminate-cfg.lua`
- **Features**:
  - Highlights all occurrences of word under cursor
  - Uses LSP, Tree-sitter, and regex providers
  - Theme-aware highlighting
  - Navigation between references
- **Keymaps**:
  - `<A-n>` - Next reference
  - `<A-p>` - Previous reference

---

## 💡 Completion & Snippets

### 1. nvim-cmp
- **Repository**: [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- **Purpose**: Completion engine
- **Configuration**: `lua/plugins/nvim-cmp.lua`
- **Features**:
  - LSP completion
  - Buffer completion
  - Path completion
  - Snippet completion (LuaSnip)
  - Command-line completion
  - Beautiful UI with rounded borders
  - Theme-aware styling
- **Sources**:
  - `nvim_lsp` - LSP completions
  - `luasnip` - Snippet completions
  - `buffer` - Buffer text completions
  - `path` - File path completions
  - `cmdline` - Command-line completions
- **Keymaps**:
  - `<C-n>` / `<C-p>` - Navigate items
  - `<Tab>` / `<S-Tab>` - Navigate / expand snippet
  - `<C-y>` / `<CR>` - Confirm selection

### 2. LuaSnip
- **Repository**: [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- **Purpose**: Snippet engine
- **Features**:
  - Fast snippet expansion
  - Integration with nvim-cmp
  - VSCode snippet format support

### 3. friendly-snippets
- **Repository**: [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- **Purpose**: Pre-configured snippets
- **Features**:
  - Collection of useful snippets
  - VSCode-compatible format
  - Auto-loaded via LuaSnip

### 4. cmp-nvim-lsp
- **Repository**: [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- **Purpose**: LSP source for nvim-cmp
- **Features**:
  - Provides LSP completions to nvim-cmp
  - Includes capabilities for better completion

### 5. cmp-buffer
- **Repository**: [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
- **Purpose**: Buffer text completion source

### 6. cmp-path
- **Repository**: [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path)
- **Purpose**: File path completion source

### 7. cmp-cmdline
- **Repository**: [hrsh7th/cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)
- **Purpose**: Command-line completion source

### 8. cmp_luasnip
- **Repository**: [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
- **Purpose**: LuaSnip source for nvim-cmp

### 9. lspkind.nvim
- **Repository**: [onsails/lspkind.nvim](https://github.com/onsails/lspkind.nvim)
- **Purpose**: Icons for completion menu
- **Features**:
  - Shows icons for different completion types
  - Symbol + text mode
  - Theme-aware icons

### 10. nvim-autopairs
- **Repository**: [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- **Purpose**: Auto-pair brackets, quotes, etc.
- **Configuration**: `lua/plugins/autopairs.lua`
- **Features**:
  - Smart bracket/quote pairing
  - Tree-sitter aware (skips pairs in strings/comments)
  - Integration with nvim-cmp
  - Disabled in Telescope, vim, neo-tree buffers

---

## 📁 File Management

### 1. nvim-tree.lua
- **Repository**: [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
- **Purpose**: File explorer
- **Configuration**: `lua/plugins/nvim-tree.lua`
- **Features**:
  - Sidebar file tree
  - Git integration (status indicators)
  - File icons (via nvim-web-devicons)
  - Auto-focus on file open
  - Custom keybindings
  - Rounded borders for floating mode
- **Keymaps**:
  - `-` (global) - Toggle tree
  - `-` (in tree) - Close tree
  - Default nvim-tree keymaps (a, d, r, etc.)

### 2. nvim-web-devicons
- **Repository**: [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- **Purpose**: File type icons
- **Features**:
  - Beautiful icons for file types
  - Used by nvim-tree, lualine, telescope

---

## 🔍 Search & Navigation

### 1. telescope.nvim
- **Repository**: [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- **Purpose**: Fuzzy finder
- **Configuration**: `lua/plugins/telescope.lua`
- **Features**:
  - File finder (including hidden files)
  - Live grep (ripgrep integration)
  - Word search (grep string)
  - Preview window with `<Tab>` focus
  - Rounded borders
  - Theme-aware styling
- **Keymaps**:
  - `<leader>ff` - Find files
  - `<leader>fs` - Live grep (search in project)
  - `<leader>fw` - Find word under cursor
  - `<Tab>` - Focus preview window
  - `<C-j>` / `<C-k>` - Navigate results
  - `<C-q>` - Send to quickfix

### 2. plenary.nvim
- **Repository**: [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- **Purpose**: Lua utilities library
- **Features**:
  - Required dependency for Telescope
  - Provides async utilities
  - Used by multiple plugins

---

## ✏️ Editor Enhancements

### 1. project-theme-manager (Custom)
- **File**: `lua/plugins/project_theme_manager.lua`
- **Purpose**: Per-project theme switching
- **Features**:
  - Automatically applies theme based on project
  - Detects project root via `.git` directory
  - Configurable project-to-theme mapping
  - Applies theme on directory change
  - Sets up completion menu highlights

---

## 🖥️ Terminal Integration

### 1. toggleterm.nvim
- **Repository**: [akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
- **Purpose**: Terminal integration
- **Configuration**: `lua/plugins/toggleterm.lua`
- **Features**:
  - Floating terminal
  - LazyGit integration
  - Custom keymaps for terminal mode
  - Rounded borders
  - Theme-aware styling
- **Keymaps**:
  - `<leader>t` - Toggle floating terminal
  - `<leader>g` - Toggle LazyGit terminal
  - `<Esc>` (in terminal) - Exit to normal mode
  - `<Esc>` (in normal, terminal buffer) - Close terminal
  - `i` (in normal, terminal buffer) - Re-enter insert mode

---

## 🤖 AI Assistant

### 1. sidekick.nvim
- **Repository**: [folke/sidekick.nvim](https://github.com/folke/sidekick.nvim)
- **Purpose**: AI coding assistant
- **Configuration**: `lua/plugins/sidekick.lua`
- **Features**:
  - **CLI Terminal Integration**: AI assistant in terminal window
  - **Cursor Agent Integration**: Pre-configured Cursor AI support
  - **Next Edit Suggestions (NES)**: Optional GitHub Copilot integration
  - **Custom Prompts**: Pre-configured prompts for common tasks
  - **Visual Selection**: Send code to AI with keypress
  - **Persistent Sessions**: Optional tmux/zellij support
- **Keymaps**:
  - `<leader>aa` - Toggle AI assistant
  - `<leader>af` - Focus AI assistant
  - `<leader>as` - Select AI tool
  - `<leader>ap` - AI prompt menu
  - `<leader>ae` - Toggle AI edit suggestions (NES)
  - `<leader>au` - Update AI suggestions
  - `<leader>ac` - Clear AI suggestions
  - `<leader>ai` (visual) - Send selection to AI
  - `<leader>ar` (visual) - Refactor code
  - `<leader>ae` (visual) - Explain code
  - `<leader>at` (visual) - Generate tests
  - `<leader>ad` (visual) - Document code
- **Custom Prompts**:
  - `refactor` - Code refactoring
  - `optimize` - Performance optimization
  - `explain` - Code explanation
  - `document` - Add documentation
  - `test` - Generate unit tests
  - `security` - Security review
  - `lint` - Code quality review
  - `debug` - Debugging help

---

## 🛠️ Utilities

### 1. vim-rails
- **Repository**: [tpope/vim-rails](https://github.com/tpope/vim-rails)
- **Purpose**: Ruby on Rails support
- **Features**:
  - Rails-specific file navigation
  - Rails commands integration
  - File type detection for `.rb`, `.erb` files

---

## 📊 Plugin Summary

### Total Plugins: ~30+

**By Category:**
- **Plugin Manager**: 1
- **UI & Appearance**: 8
- **LSP & Language Support**: 5
- **Completion & Snippets**: 10
- **File Management**: 2
- **Search & Navigation**: 2
- **Editor Enhancements**: 1
- **Terminal Integration**: 1
- **AI Assistant**: 1
- **Utilities**: 1

### Key Features

1. **Modern Plugin Management**: Lazy loading with lazy.nvim
2. **Beautiful UI**: Multiple themes with consistent styling
3. **Comprehensive LSP**: 10+ languages fully configured
4. **Smart Completion**: Multi-source completion with snippets
5. **Powerful Search**: Telescope for files and text
6. **AI Integration**: Sidekick with Cursor agent support
7. **Smooth UX**: Animations, smooth scrolling, beautiful notifications
8. **Terminal Integration**: Floating terminals with LazyGit
9. **Code Navigation**: Tree-sitter text objects, LSP navigation
10. **Per-Project Themes**: Automatic theme switching

---

## 🔗 Dependencies

### External Tools Required:
- **ripgrep** (`rg`) - For Telescope live grep
- **fd** - For Telescope file finder (optional, falls back to find)
- **git** - For lazy.nvim and git integration
- **Cursor** - For Sidekick Cursor agent (optional)
- **GitHub Copilot** - For NES features (optional)
- **tmux/zellij** - For persistent AI sessions (optional)

### Language Servers (Auto-installed via Mason):
- lua-language-server
- ruby-lsp
- gopls
- golangci-lint-langserver
- pyright-langserver
- typescript-language-server
- rust-analyzer
- vscode-html-language-server
- vscode-css-language-server
- vscode-json-language-server
- bash-language-server

---

## 📝 Configuration Files

```
~/.config/nvim/
├── init.lua                          # Main entry point
├── lazy-lock.json                    # Plugin versions lock
├── colors/
│   └── gruvbox-dark-hard.vim         # Custom theme colors
├── lua/
│   ├── config/
│   │   └── lazy.lua                  # Plugin manager setup
│   ├── gruvbox-dark-hard.lua        # Custom theme module
│   └── plugins/
│       ├── alpha.lua                 # Dashboard
│       ├── autopairs.lua             # Auto-pairs
│       ├── catpuccin.lua            # Catppuccin theme
│       ├── gruvbox.lua              # Gruvbox theme
│       ├── illuminate-cfg.lua      # Symbol highlighting
│       ├── indent.lua               # Indent guides
│       ├── lsp.lua                  # LSP configuration
│       ├── lualine.lua              # Statusline
│       ├── neoscroll.lua            # Smooth scrolling
│       ├── nvim-cmp.lua            # Completion
│       ├── nvim-notify.lua         # Notifications
│       ├── nvim-tree.lua           # File explorer
│       ├── nvim-treesitter.lua     # Syntax highlighting
│       ├── project_theme_manager.lua # Per-project themes
│       ├── sidekick.lua            # AI assistant
│       ├── telescope.lua            # Fuzzy finder
│       └── toggleterm.lua           # Terminal
└── PLUGINS.md                       # This file
```

---

## 🎯 Quick Reference

### Essential Commands
```vim
:Lazy              " Open plugin manager
:Mason             " Install language servers
:LspInfo           " Check LSP status
:checkhealth       " System health check
:TSUpdate          " Update Tree-sitter parsers
```

### Key Leader Mappings
- `<leader>ff` - Find files
- `<leader>fs` - Search in project
- `<leader>t` - Toggle terminal
- `<leader>aa` - Toggle AI assistant
- `<leader>cc` - Cycle themes
- `-` - Toggle file tree

---

**Last Updated**: Generated from configuration analysis
**Neovim Version**: Requires >= 0.11.2
