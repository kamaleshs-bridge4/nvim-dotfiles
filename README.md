# Neovim Configuration

A modern, minimal Neovim configuration focused on simplicity, readability, and developer productivity. Built with Go coding conventions, SOLID principles, and a clean architecture.

## ✨ Features

### 🎨 **Beautiful & Transparent**
- **100% transparent background** - Seamlessly blends with your terminal
- **Subtle line numbers** - Barely visible, non-intrusive
- **Rounded borders** - Modern floating windows throughout
- **Multiple colorschemes** - Catppuccin & Gruvbox with live preview

### 🔍 **Powerful Search & Navigation**
- **Telescope** - Fuzzy finder with centered preview
- **Live grep** - Search across your entire project
- **File explorer** - Floating file tree with centered layout
- **Seamless Tmux integration** - Navigate between Neovim splits and Tmux panes

### 💻 **LSP & Development**
- **Auto LSP installation** - Mason automatically installs language servers
- **12+ LSP servers** - Go, Rust, TypeScript, Python, Ruby, Lua, and more
- **Smart diagnostics** - Squiggly underlines, no virtual text clutter
- **Custom hover documentation** - Navigable floating windows attached to code
- **Auto-completion** - LSP-powered with snippets, buffer, and path sources

### 🎯 **Developer Experience**
- **Token highlighting** - See all references of word under cursor
- **Indentation guides** - Visual scope highlighting
- **Syntax highlighting** - Treesitter-powered for 19+ languages
- **Auto-pairs** - Smart bracket/quote completion

## 🚀 Quick Start

### Prerequisites
- Neovim 0.11+
- Git
- A terminal with transparency support

### Installation

```bash
# Clone the repository
git clone <your-repo-url> ~/.config/nvim

# Start Neovim (plugins will auto-install)
nvim
```

## ⌨️ Keybindings

### File Management
| Key | Action |
|-----|--------|
| `-` | Toggle file explorer (nvim-tree) |
| `<leader>ff` | Find files (includes hidden) |
| `<leader>fs` | Live grep (project search) |
| `<leader>fw` | Grep word under cursor |
| `<leader>fc` | Colorscheme picker with preview |

### LSP Navigation
| Key | Action |
|-----|--------|
| `K` / `<S-K>` | Hover documentation (navigable) |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Go to references |
| `<C-k>` | Signature help |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |

### Terminal
| Key | Action |
|-----|--------|
| `<leader>t` | Toggle floating terminal |
| `Esc` (terminal) | Switch to normal mode |
| `Esc` (normal) | Close terminal |

### Navigation
| Key | Action |
|-----|--------|
| `<C-h>` | Navigate left (Tmux/Nvim) |
| `<C-j>` | Navigate down (Tmux/Nvim) |
| `<C-k>` | Navigate up (Tmux/Nvim) |
| `<C-l>` | Navigate right (Tmux/Nvim) |
| `<C-\>` | Navigate to previous (Tmux/Nvim) |

### Token Highlighting
| Key | Action |
|-----|--------|
| `<A-n>` | Next reference |
| `<A-p>` | Previous reference |

### Hover Documentation (when open)
| Key | Action |
|-----|--------|
| `h`, `j`, `k`, `l` | Navigate |
| `<C-f>`, `<C-b>` | Page scroll |
| `<C-d>`, `<C-u>` | Half-page scroll |
| `Esc` / `q` | Close |

## 📦 Plugins

### Core
- **[lazy.nvim](https://github.com/folke/lazy.nvim)** - Modern plugin manager
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP configuration
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** - LSP installer

### UI & Navigation
- **[nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)** - File explorer
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Fuzzy finder
- **[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)** - Indentation guides

### Development
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Syntax highlighting
- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** - Auto-completion
- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** - Auto-pairs
- **[vim-illuminate](https://github.com/RRethy/vim-illuminate)** - Token highlighting

### Terminal & Integration
- **[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)** - Terminal
- **[vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)** - Tmux integration

### Themes
- **[catppuccin.nvim](https://github.com/catppuccin/nvim)** - Catppuccin colorscheme
- **[gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim)** - Gruvbox colorscheme

## 🎨 Customization

### Colorschemes
Switch between colorschemes using:
- `<leader>fc` - Interactive picker with live preview
- `:colorscheme catppuccin-mocha` - Direct command
- `:colorscheme gruvbox` - Direct command

### Transparency
Transparency is enabled by default. To disable, remove the transparency section in `init.lua`.

### Line Numbers
Line numbers are subtle by default. Adjust colors in `init.lua`:
```lua
vim.api.nvim_set_hl(0, "LineNr", { fg = "#3b4261", bg = "none" })
```

## 🏗️ Architecture

The configuration follows Go coding conventions and SOLID principles:

- **Separation of Concerns** - Each plugin has its own file
- **Single Responsibility** - Files handle one specific feature
- **Explicit Configuration** - No magic numbers or hidden defaults
- **Extensibility** - Easy to add new plugins or modify existing ones

### File Structure
```
nvim/
├── init.lua                 # Main configuration
├── lua/
│   ├── config/
│   │   └── lazy.lua        # Plugin manager setup
│   └── plugins/
│       ├── lsp.lua         # LSP configuration
│       ├── telescope.lua   # Search & navigation
│       ├── nvim-tree.lua   # File explorer
│       ├── themes.lua      # Colorschemes
│       └── ...             # Other plugins
```

## 🔧 Language Support

### LSP Servers (Auto-installed)
- `lua_ls` - Lua
- `gopls` - Go
- `rust_analyzer` - Rust
- `ts_ls` - TypeScript
- `pyright` - Python
- `ruby_lsp` - Ruby
- `bashls` - Bash
- `html`, `cssls`, `jsonls` - Web
- `eslint` - JavaScript linting
- `golangci_lint_ls` - Go linting

### Treesitter Parsers
- lua, vim, html, css, javascript, typescript
- json, markdown, bash, go, ruby, zig, rust, java, python

## 📝 Notes

- **Leader key**: `,` (comma)
- **Lazy loading**: Plugins load on-demand for faster startup
- **Transparency**: Requires terminal transparency support
- **Go files**: Automatically use tabs (8 spaces) instead of spaces

## 🤝 Contributing

Contributions are welcome! Please follow the existing code style and conventions.

## 📄 License

This configuration is provided as-is for personal use.

---

**Built with ❤️ for developers who value simplicity and productivity**

