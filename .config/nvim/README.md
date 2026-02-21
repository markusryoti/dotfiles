# Neovim Config 2026 — Go · Rust · Python · TypeScript

A modern, batteries-included Neovim configuration built for 2026.

## Requirements

- **Neovim 0.10+** (0.11 recommended)
- **Git**
- A [Nerd Font](https://www.nerdfonts.com/) in your terminal
- `ripgrep` — for Telescope live grep (`brew install ripgrep` / `apt install ripgrep`)
- `fd` — for Telescope file finding (`brew install fd` / `apt install fd-find`)
- `make` — for building fzf-native

### Language toolchains (install before opening Neovim)

| Language   | Tools                                              |
|------------|----------------------------------------------------|
| Go         | `go`, `goimports` (`go install golang.org/x/tools/cmd/goimports@latest`) |
| Rust       | `rustup`, `rustfmt`, `rust-analyzer` (via rustup) |
| Python     | `python3`, `pip`                                   |
| TypeScript | `node`, `npm`, `prettierd` (`npm i -g @fsouza/prettierd`) |

## Installation

```bash
# Back up existing config (if any)
mv ~/.config/nvim ~/.config/nvim.bak

# Copy this config
cp -r /path/to/nvim ~/.config/nvim

# Open Neovim — lazy.nvim will auto-install on first launch
nvim
```

On first launch, lazy.nvim will:
1. Install itself
2. Download and build all plugins
3. Mason will auto-install LSP servers and formatters

Run `:checkhealth` after installation to verify everything is working.

## Structure

```
~/.config/nvim/
├── init.lua                  ← entry point
└── lua/
    ├── core/
    │   ├── options.lua       ← vim options
    │   ├── keymaps.lua       ← base keymaps
    │   ├── autocmds.lua      ← autocommands
    │   └── lazy.lua          ← lazy.nvim bootstrap
    └── plugins/
        ├── colorscheme.lua   ← Catppuccin Mocha
        ├── ui.lua            ← lualine, bufferline, noice, which-key...
        ├── lsp.lua           ← nvim-lspconfig + mason + rustaceanvim
        ├── completion.lua    ← blink.cmp + LuaSnip
        ├── treesitter.lua    ← treesitter + textobjects + context
        ├── telescope.lua     ← fuzzy finding
        ├── formatting.lua    ← conform.nvim (format on save)
        ├── git.lua           ← gitsigns + lazygit + diffview
        ├── editor.lua        ← neo-tree, flash, harpoon, mini.nvim...
        ├── debug.lua         ← nvim-dap + UI + adapters
        ├── testing.lua       ← neotest + adapters
        └── extras.lua        ← language extras, markdown, REST, etc.
```

## Key Bindings (Leader = `<Space>`)

### Navigation
| Key              | Action                    |
|------------------|---------------------------|
| `<Space><Space>` | Find files                |
| `<Space>/`       | Live grep                 |
| `<Space>bs`      | Switch buffer             |
| `s` + chars      | Flash jump                |
| `<Space>ha`      | Harpoon add file          |
| `<Space>1-4`     | Harpoon file 1-4          |

### LSP
| Key              | Action                    |
|------------------|---------------------------|
| `gd`             | Go to definition          |
| `gr`             | References                |
| `K`              | Hover documentation       |
| `<Space>cr`      | Rename symbol             |
| `<Space>ca`      | Code action               |
| `<Space>cf`      | Format buffer             |
| `]d` / `[d`      | Next/prev diagnostic      |

### Git
| Key              | Action                    |
|------------------|---------------------------|
| `<Space>gg`      | Lazygit                   |
| `<Space>gd`      | Diffview                  |
| `]h` / `[h`      | Next/prev hunk            |
| `<Space>ghs`     | Stage hunk                |
| `<Space>ghb`     | Blame line                |

### Testing
| Key              | Action                    |
|------------------|---------------------------|
| `<Space>tt`      | Run nearest test          |
| `<Space>tT`      | Run file tests            |
| `<Space>ts`      | Test summary              |
| `<Space>td`      | Debug nearest test        |

### Debug
| Key              | Action                    |
|------------------|---------------------------|
| `<F5>`           | Continue                  |
| `<F10>`          | Step over                 |
| `<F11>`          | Step into                 |
| `<leader>db`     | Toggle breakpoint         |
| `<leader>du`     | Toggle DAP UI             |

## Customization

- **Theme**: Change `flavour` in `plugins/colorscheme.lua` (`latte`/`frappe`/`macchiato`/`mocha`)
- **Copilot**: Uncomment the Copilot section in `plugins/extras.lua`
- **Format on save**: Toggle with `<leader>uf` or disable permanently via `vim.g.disable_autoformat = true` in `core/options.lua`
- **Inlay hints**: Toggle per-buffer with `<leader>uh`
