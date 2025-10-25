# ✨ Modern Neovim Configuration

A beautiful, feature-rich Neovim configuration with transparent themes, AI assistance, and a complete IDE experience.

![Neovim Banner]()
<!-- Screenshot: Main editor view with transparent background -->

## 📸 Screenshots

### Dashboard
![Dashboard]()
<!-- Screenshot: Alpha dashboard start screen -->

### Transparent Theme
![Transparent Theme]()
<!-- Screenshot: Transparent background with blur effect -->

### Telescope File Finder
![Telescope]()
<!-- Screenshot: Telescope file finder with transparent background -->

### LSP in Action
![LSP Features]()
<!-- Screenshot: Code with LSP diagnostics and hover information -->

### AI Assistant
![Sidekick AI]()
<!-- Screenshot: Sidekick with Cursor agent in action -->

---

## 🚀 Features

### 🎨 **Visual & UI**
- ✅ **Transparent Themes**: Beautiful transparency with both Catppuccin Mocha & Gruvbox Hard
- ✅ **Rounded Borders**: Elegant rounded borders on all floating windows
- ✅ **Smooth Scrolling**: Buttery-smooth scrolling animations
- ✅ **Beautiful Dashboard**: Welcoming start screen with quick actions
- ✅ **Enhanced Status Line**: Feature-rich lualine with LSP info
- ✅ **Window Decorations**: Subtle borders and separators with Unicode characters
- ✅ **Elegant Notifications**: Animated notification system
- ✅ **Indent Guides**: Subtle, beautiful indentation visualization
- ✅ **Cursor Line Enhancement**: Bold line numbers with highlighted cursor line
- ✅ **Color Enhancements**: Better LSP references, matching brackets, and visual selection

### 🤖 **AI Integration**
- ✅ **Sidekick.nvim**: AI-powered coding assistant
- ✅ **Cursor Agent**: Integrated Cursor AI for code generation and refactoring
- ✅ **Custom Prompts**: Pre-configured prompts for refactoring, documentation, testing, and more
- ✅ **Visual Selection to AI**: Send selected code directly to AI assistant
- ✅ **Optional NES**: Next Edit Suggestions with GitHub Copilot (optional)

### 💻 **Development Tools**
- ✅ **LSP Support**: Multi-language LSP (Lua, Ruby, Go, Python, JS/TS, Rust, HTML, CSS, JSON, Bash)
- ✅ **Intelligent Completion**: nvim-cmp with LSP, snippets, buffer, and path completion
- ✅ **Syntax Highlighting**: Tree-sitter powered syntax highlighting
- ✅ **Auto-formatting**: Language-specific auto-formatting on save
- ✅ **Code Navigation**: Go to definition, references, implementation, hover docs
- ✅ **Diagnostics**: Real-time error detection with virtual text and floating windows
- ✅ **Fuzzy Finding**: Telescope for file search, live grep, and more
- ✅ **File Explorer**: nvim-tree with custom keybindings
- ✅ **Terminal Integration**: Toggleterm with LazyGit support
- ✅ **Auto Pairs**: Smart bracket/quote auto-pairing
- ✅ **Symbol Highlighting**: Illuminate matching symbols under cursor

### 🎯 **Project Management**
- ✅ **Per-Project Themes**: Automatically switch themes based on project
- ✅ **Git Integration**: Branch info, diff stats, LazyGit terminal
- ✅ **Session Persistence**: Optional tmux/zellij integration for persistent sessions

---

## 📦 Installation

### Prerequisites
```bash
# Required
brew install neovim       # Neovim >= 0.11.2
brew install ripgrep      # For Telescope live grep
brew install fd           # For Telescope file finder

# Optional (for AI features)
# Cursor agent (if you have Cursor installed)
# GitHub Copilot subscription (for NES suggestions)

# Optional (for persistent sessions)
brew install tmux         # Or zellij
```

### Install Configuration
```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this configuration
git clone <your-repo-url> ~/.config/nvim

# Start Neovim - plugins will auto-install
nvim
```

### Terminal Configuration for Transparency + Blur

#### iTerm2 (macOS)
1. Preferences → Profiles → Window
2. Set **Transparency**: 10-20%
3. Set **Blur**: 20-30

#### Kitty
Add to `~/.config/kitty/kitty.conf`:
```
background_opacity 0.95
```

#### WezTerm
Add to `~/.config/wezterm/wezterm.lua`:
```lua
return {
  window_background_opacity = 0.95,
}
```

---

## ⌨️ Keymaps

### Leader Key
- **Leader**: `<Space>` (default)

### 📁 File Navigation

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>ff` | Normal | Find files in project |
| `<leader>fs` | Normal | Search text in project (live grep) |
| `<leader>fw` | Normal | Find word under cursor in project |
| `-` | Normal | Toggle file tree (nvim-tree) |

### 💡 LSP Features

| Keymap | Mode | Description |
|--------|------|-------------|
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `gi` | Normal | Go to implementation |
| `gr` | Normal | Show references |
| `K` | Normal | Show hover documentation |
| `<C-k>` | Normal | Signature help |
| `<leader>ca` | Normal | Code actions |
| `<leader>rn` | Normal | Rename symbol |
| `[d` | Normal | Previous diagnostic |
| `]d` | Normal | Next diagnostic |
| `gl` | Normal | Show line diagnostics |
| `<leader>vd` | Normal | View diagnostic float |
| `<leader>td` | Normal | Toggle diagnostic virtual text |

### 🤖 AI Assistant (Sidekick)

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>aa` | Normal | Toggle AI assistant (Cursor) |
| `<leader>af` | Normal | Focus AI assistant window |
| `<leader>as` | Normal | Select AI tool |
| `<leader>ap` | Normal | AI prompt menu |
| `<leader>ae` | Normal | Toggle AI edit suggestions (NES) |
| `<leader>au` | Normal | Update AI suggestions |
| `<leader>ac` | Normal | Clear AI suggestions |
| `<leader>ai` | Visual | Send selection to AI |
| `<leader>ar` | Visual | Refactor selected code |
| `<leader>ae` | Visual | Explain selected code |
| `<leader>at` | Visual | Generate tests for selection |
| `<leader>ad` | Visual | Document selected code |

### 🔔 Notifications

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>nd` | Normal | Dismiss all notifications |
| `<leader>nh` | Normal | Show notification history |

### 🖥️ Terminal

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>t` | Normal | Toggle floating terminal |
| `<leader>g` | Normal | Toggle LazyGit terminal |
| `<Esc>` | Terminal | Exit to normal mode |
| `<Esc>` (2nd) | Normal (in terminal) | Close terminal |

### 🔍 Telescope Navigation

| Keymap | Mode | Description |
|--------|------|-------------|
| `<C-j>` / `<C-k>` | Insert | Navigate results |
| `<Tab>` | Normal | Focus preview window |
| `<Tab>` | Normal (in preview) | Return to prompt |
| `<C-q>` | Insert | Send to quickfix |

### ✏️ Completion (nvim-cmp)

| Keymap | Mode | Description |
|--------|------|-------------|
| `<C-n>` / `<C-p>` | Insert | Navigate items |
| `<Tab>` / `<S-Tab>` | Insert | Navigate / expand snippet |
| `<C-y>` / `<CR>` | Insert | Confirm selection |

---

## 🎨 Themes

### Available Themes
1. **Catppuccin Mocha** - Soothing pastel dark theme
2. **Gruvbox Hard** - Warm retro dark theme

Both themes are configured with:
- Full transparency support
- Rounded borders
- Enhanced LSP highlighting
- Beautiful color enhancements

### Switching Themes
```vim
:colorscheme catppuccin
:colorscheme gruvbox
```

### Per-Project Theme Configuration
Edit `lua/plugins/project_theme_manager.lua`:
```lua
local project_themes = {
  ["nvim"] = "gruvbox",
  ["my-project"] = "catppuccin-mocha",
  -- Add your projects here
}
```

---

## 🔧 Configuration Structure

```
~/.config/nvim/
├── init.lua                          # Main entry point
├── lazy-lock.json                    # Plugin version lock
├── lua/
│   ├── config/
│   │   └── lazy.lua                  # Lazy.nvim setup
│   └── plugins/
│       ├── alpha.lua                 # Dashboard
│       ├── autopairs.lua             # Auto-pair brackets
│       ├── catpuccin.lua             # Catppuccin theme
│       ├── gruvbox.lua               # Gruvbox theme
│       ├── illuminate-cfg.lua        # Symbol highlighting
│       ├── indent.lua                # Indent guides
│       ├── lsp.lua                   # LSP configuration
│       ├── lualine.lua               # Statusline
│       ├── neoscroll.lua             # Smooth scrolling
│       ├── nvim-cmp.lua              # Completion
│       ├── nvim-notify.lua           # Notifications
│       ├── nvim-tree.lua             # File explorer
│       ├── nvim-treesitter.lua       # Syntax highlighting
│       ├── project_theme_manager.lua # Per-project themes
│       ├── sidekick.lua              # AI assistant
│       ├── telescope.lua             # Fuzzy finder
│       ├── toggleterm.lua            # Terminal
│       └── window-decorations.lua    # Window borders
└── README.md                         # This file
```

---

## 🎯 Language Support

### Fully Configured Languages
- 🔷 **Lua**: lua_ls with Neovim-specific settings
- 💎 **Ruby**: ruby_lsp with RuboCop auto-formatting
- 🐹 **Go**: gopls + golangci-lint with auto-format & import organization
- 🐍 **Python**: pyright
- 📜 **JavaScript/TypeScript**: ts_ls
- 🦀 **Rust**: rust_analyzer
- 🌐 **HTML/CSS**: HTML & CSS language servers
- 📦 **JSON**: JSON language server
- 🐚 **Bash**: bashls

### Adding New Languages
Edit `lua/plugins/lsp.lua` to add more language servers using the `vim.lsp.config()` API.

---

## 🤖 AI Features Details

### Sidekick.nvim
Sidekick provides two main features:

#### 1. **CLI Terminal Integration** (Always Available)
- Opens AI assistant in a terminal window
- Works with Cursor agent (pre-configured)
- Custom prompts for common tasks
- Send code selections for review/refactoring

#### 2. **Next Edit Suggestions (NES)** (Requires Copilot)
- AI-powered inline code suggestions
- Multi-line refactoring suggestions
- **Requires**: GitHub Copilot subscription

### Custom AI Prompts
Pre-configured prompts in `lua/plugins/sidekick.lua`:
- `refactor` - Code refactoring
- `optimize` - Performance optimization
- `explain` - Code explanation
- `document` - Add documentation
- `test` - Generate unit tests
- `security` - Security review
- `lint` - Code quality review
- `debug` - Debugging help

### Using Cursor Agent
1. Ensure Cursor is installed: `cursor --version`
2. Press `<leader>aa` to open AI assistant
3. Type your question or request
4. Select code and press `<leader>ai` to send to AI

---

## 🎨 Customization

### Changing Color Scheme Colors
Edit theme files:
- `lua/plugins/catpuccin.lua` - Catppuccin customization
- `lua/plugins/gruvbox.lua` - Gruvbox customization

### Modifying Keymaps
All keymaps are defined in their respective plugin files. Search for `keys = {` or `vim.keymap.set()`.

### Adjusting Transparency
To disable transparency:
1. Edit `lua/plugins/catpuccin.lua`: Set `transparent_background = false`
2. Edit `lua/plugins/gruvbox.lua`: Set `transparent_mode = false`
3. Comment out transparency autocmd in `init.lua`

### Plugin Management
```vim
:Lazy                 " Open plugin manager
:Lazy sync            " Update all plugins
:Lazy clean           " Remove unused plugins
:Lazy profile         " View startup time
```

---

## 🔍 Troubleshooting

### Plugins Not Loading
```vim
:Lazy sync            " Sync all plugins
:Lazy restore         " Restore from lockfile
```

### LSP Not Working
```vim
:LspInfo              " Check LSP status
:Mason                " Install language servers
:checkhealth lsp      " Diagnostic check
```

### Sidekick/AI Errors
```vim
:checkhealth sidekick " Check Sidekick status
```

If tmux error appears:
- Install tmux: `brew install tmux`
- Or disable in `lua/plugins/sidekick.lua`: `mux.enabled = false`

### Telescope Issues
```vim
:checkhealth telescope
```
Ensure ripgrep is installed: `brew install ripgrep`

### Theme Not Transparent
1. Check terminal emulator supports transparency
2. Enable transparency in terminal settings
3. Reload Neovim: `:source ~/.config/nvim/init.lua`

---

## 📚 Plugin List

### Core Plugins
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configuration
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Completion engine
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting

### UI Enhancements
- [catppuccin/nvim](https://github.com/catppuccin/nvim) - Catppuccin theme
- [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) - Gruvbox theme
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Statusline
- [alpha-nvim](https://github.com/goolord/alpha-nvim) - Dashboard
- [nvim-notify](https://github.com/rcarriga/nvim-notify) - Notifications
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) - Indent guides
- [neoscroll.nvim](https://github.com/karb94/neoscroll.nvim) - Smooth scrolling

### Development Tools
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) - File explorer
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) - Terminal
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) - Auto-pairs
- [vim-illuminate](https://github.com/RRethy/vim-illuminate) - Symbol highlighting
- [mason.nvim](https://github.com/williamboman/mason.nvim) - LSP installer

### AI Integration
- [sidekick.nvim](https://github.com/folke/sidekick.nvim) - AI assistant

---

## 🌟 Highlights

### What Makes This Config Special?

1. **🎨 Gorgeous Aesthetics**
   - Fully transparent themes with blur support
   - Rounded borders everywhere for a modern look
   - Smooth animations and transitions

2. **🤖 AI-First Workflow**
   - Integrated Cursor agent for AI assistance
   - Custom prompts for common coding tasks
   - Visual selection to AI with one keypress

3. **⚡ Performance Optimized**
   - Lazy loading for fast startup
   - Minimal overhead with smart plugin choices
   - Tree-sitter for efficient syntax highlighting

4. **🔧 Comprehensive LSP**
   - 10+ languages pre-configured
   - Auto-formatting on save
   - Real-time diagnostics
   - Intelligent code actions

5. **🎯 Thoughtful UX**
   - Consistent keybindings
   - Visual feedback for all actions
   - Per-project theme switching
   - Persistent terminal sessions

---

## 📝 Notes

- **Neovim Version**: Requires >= 0.11.2
- **Font**: Works best with a Nerd Font (for icons)
- **Terminal**: Recommended: iTerm2, Kitty, WezTerm, or Alacritty
- **Git**: Required for lazy.nvim and plugin management

---

## 🙏 Credits

This configuration is built on the shoulders of giants:
- [folke](https://github.com/folke) - For lazy.nvim and sidekick.nvim
- [Neovim Team](https://neovim.io/) - For the amazing editor
- [Catppuccin](https://github.com/catppuccin) - Beautiful pastel theme
- [Gruvbox](https://github.com/morhetz/gruvbox) - Classic retro theme
- All plugin authors - For their incredible work

---

## 📄 License

MIT License - Feel free to use and modify this configuration!

---

## 🚀 Quick Start Commands

```bash
# Install config
git clone <repo-url> ~/.config/nvim && nvim

# Inside Neovim
:Lazy sync              # Install/update plugins
:Mason                  # Install language servers
:checkhealth            # Verify setup

# Configure terminal blur (iTerm2)
# Preferences → Profiles → Window → Blur: 20-30

# Start coding!
```

---

**Made with ❤️ and lots of ☕**

*Happy coding! 🎉*
