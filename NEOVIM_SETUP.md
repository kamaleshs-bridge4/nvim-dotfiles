# Neovim Setup Documentation

### Neovide GUI (`lua/config/neovide.lua`)
*   **Font**: `JetBrainsMono Nerd Font:h14`
*   **Visuals**:
    *   Transparency: 0.95
    *   Blur: Enabled (macOS)
    *   Refresh Rate: 60fps (5fps idle)
*   **Keymaps**:
    *   `<C-=>` / `<C-->`: Increase/Decrease font size.
    *   `<C-0>`: Reset font size.
    *   `<leader>cp`: Toggle cursor particles (Railgun effect).
    *   `<leader>ct`: Toggle transparency.

*   Shows: Mode, Branch, Diff, Filename, Diagnostics, LSP Server Name, Encoding, Progress, Location.
*   **Notifications** (`lua/plugins/nvim-notify.lua`):
    *   Animation: `fade_in_slide_out`.
    *   Replaces standard `vim.notify`.
    *   Keymaps:
        *   `<leader>nd`: Dismiss all notifications.
        *   `<leader>nh`: Show notification history.
*   **Indentation** (`lua/plugins/indent.lua`): `indent-blankline.nvim` with scope highlighting.
*   **Scrolling** (`lua/plugins/neoscroll.lua`): Smooth scrolling animations (`sine`, `circular` easing).
*   **Token Highlighting** (`lua/plugins/illuminate-cfg.lua`):
    *   Highlights word under cursor using LSP/Treesitter/Regex.
    *   Keymaps: `<A-n>` (Next Ref), `<A-p>` (Prev Ref).

## 3. LSP & Development (`lua/plugins/lsp.lua`)

### Configuration
*   **Mason**: Automatic installation of LSPs.
*   **LSP Servers**:
    *   `lua_ls`, `ruby_lsp`, `html`, `cssls`, `jsonls`, `ts_ls`, `eslint`, `pyright`, `bashls`, `rust_analyzer`, `gopls`, `golangci_lint_ls`.
*   **Diagnostics**:
    *   Squiggly underlines (Error, Warn, Info, Hint).
    *   Virtual text disabled (use hover `K` to see).
    *   Expanded underline range for single-char diagnostics.

### Auto-Formatting & Linting
*   **Ruby**: Runs `rubocop -A` on save.
*   **Go**: Runs `gopls` formatting + import organization on save.

### Completion (`lua/plugins/nvim-cmp.lua`)
*   **Sources**: LSP, LuaSnip, Buffer, Path.
*   **Formatting**: `lspkind` with symbols.
*   **Mappings**:
    *   `<C-n>`/`<C-p>`: Navigate.
    *   `<C-y>` / `<CR>`: Confirm.
    *   `<Tab>`/`<S-Tab>`: Cycle/Expand Snippet.
*   **Autopairs**: `nvim-autopairs` automatically closes brackets/quotes.

### LSP Keymaps (Buffer Local)
| Key | Action |
| :--- | :--- |
| `gD` | Goto Declaration |
| `gd` | Goto Definition |
| `gi` | Goto Implementation |
| `gr` | Goto References |
| `K` | Hover Documentation / Show Diagnostics |
| `<C-k>` | Signature Help |
| `<leader>ca` | Code Actions |
| `<leader>rn` | Rename |

---

## 4. Keymap Summary

| Context | Key | Action |
| :--- | :--- | :--- |
| **General** | `,` | Leader Key |
| **Neovide** | `<C-=>` | Increase Font |
| **Neovide** | `<C-->` | Decrease Font |
| **Theme** | `<leader>tt` | Toggle Theme |
| **Files** | `-` | Toggle File Explorer |
| **Search** | `<leader>ff` | Find Files |
| **Search** | `<leader>fs` | Live Grep |
| **Search** | `<leader>fw` | Find Word |
| **Terminal** | `<leader>t` | Toggle Terminal |
| **Terminal** | `<leader>g` | Toggle LazyGit |

| **Notifications** | `<leader>nd` | Dismiss Notifications |
