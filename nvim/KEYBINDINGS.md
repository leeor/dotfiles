# Neovim Keybindings Cheatsheet

> Leader key: `<Space>`
> Local leader: `,`
> Press `<Space>?` for interactive which-key help

---

## Navigation & Motion

### Flash (Motion Plugin)
| Binding | Mode | Description |
|---------|------|-------------|
| `s` | n, x, o | Flash jump (type chars to jump) |
| `S` | n, x, o | Flash treesitter (select nodes) |
| `r` | o | Remote flash (operator pending) |
| `R` | o, x | Treesitter search |
| `<C-s>` | c | Toggle flash in search |
| `<Leader><Leader>w` | n, x, o | Flash to line start |
| `<Leader><Leader>j` | n, x, o | Flash lines down |
| `<Leader><Leader>k` | n, x, o | Flash lines up |

### Windows
| Binding | Mode | Description |
|---------|------|-------------|
| `-` | n | Choose window (pick with letter) |
| `_` | n | Swap windows |
| `sh` | n | Split horizontal + previous buffer |
| `sv` | n | Split vertical + previous buffer |
| `<Up>` | n | Increase window height |
| `<Down>` | n | Decrease window height |
| `<Left>` | n | Increase window width |
| `<Right>` | n | Decrease window width |

### Scrolling
| Binding | Mode | Description |
|---------|------|-------------|
| `<C-f>` | n, x | Page down (smart) |
| `<C-b>` | n, x | Page up (smart) |
| `<C-e>` | n, x | Scroll down 3 lines |
| `<C-y>` | n, x | Scroll up 3 lines |
| `zz` | n | Smart center (cycles zt/zz/zb) |

### Tabs
| Binding | Mode | Description |
|---------|------|-------------|
| `g0` | n | First tab |
| `g$` | n | Last tab |
| `gr` | n | Previous tab |

---

## File Operations (`;` prefix)

| Binding | Mode | Description |
|---------|------|-------------|
| `;f` | n | Find files |
| `;b` | n | Buffers |
| `;h` | n | Recent files (oldfiles) |
| `;H` | n | Help tags |
| `;r` | n | Resume last search |
| `;R` | n | Registers |
| `;F` | n | Frecency (frequently used) |
| `;g` | n | Live grep |
| `;l` | n | Buffer lines (fuzzy find) |
| `;c` | n | Buffer git commits |
| `;C` | n | All git commits |
| `;q` | n | Quickfix list |
| `;Q` | n | Quickfix history |

---

## LSP (`<Leader>l` prefix)

| Binding | Mode | Description |
|---------|------|-------------|
| `<Leader>ld` | n | Go to definition |
| `<Leader>ly` | n | Go to type definition |
| `<Leader>lt` | n | Hover info |
| `<Leader>li` | n | Go to implementation |
| `<Leader>lR` | n | Find references |
| `<Leader>lr` | n | Rename symbol |
| `<Leader>la` | n, v | Code action |
| `<Leader>lds` | n | Document symbols |
| `<Leader>lws` | n | Workspace symbols |
| `<Leader>ls` | n | Document symbols (Telescope) |
| `<Leader>lS` | n | Workspace symbols (Telescope) |
| `<Leader>lc` | n | Run codelens |
| `<Leader>sh` | n | Signature help |
| `<Leader>f` | n | Format buffer |

---

## Diagnostics

### Quick Access (`<Leader>a/d` prefix)
| Binding | Mode | Description |
|---------|------|-------------|
| `<Leader>aa` | n | All diagnostics to quickfix |
| `<Leader>ae` | n | Errors to quickfix |
| `<Leader>aw` | n | Warnings to quickfix |
| `<Leader>d` | n | Buffer diagnostics to loclist |
| `[c` | n | Previous diagnostic |
| `]c` | n | Next diagnostic |

### Trouble (`<Leader>x` prefix)
| Binding | Mode | Description |
|---------|------|-------------|
| `<Leader>xx` | n | Toggle all diagnostics |
| `<Leader>xX` | n | Buffer diagnostics |
| `<Leader>xs` | n | Symbols |
| `<Leader>xl` | n | LSP references/definitions |
| `<Leader>xL` | n | Location list |
| `<Leader>xQ` | n | Quickfix list |

---

## Git (`<Leader>g/h` prefix)

### Fugitive
| Binding | Mode | Description |
|---------|------|-------------|
| `<Leader>gs` | n | Git status (vertical) |
| `<Leader>gw` | n | Git write (stage file) |
| `<Leader>go` | n | Git checkout file |
| `<Leader>gd` | n | Git diff |
| `<Leader>gb` | n | Git blame |
| `<Leader>gc` | n | Git commit |
| `<Leader>ga` | n | Git amend |
| `<Leader>gB` | n | Git browse (open in browser) |
| `<Leader>ge` | n | Git edit |

### Gitsigns (Hunks)
| Binding | Mode | Description |
|---------|------|-------------|
| `]h` | n | Next hunk |
| `[h` | n | Previous hunk |
| `<Leader>hs` | n, v | Stage hunk |
| `<Leader>hr` | n, v | Reset hunk |
| `<Leader>hS` | n | Stage buffer |
| `<Leader>hu` | n | Undo stage hunk |
| `<Leader>hR` | n | Reset buffer |
| `<Leader>hp` | n | Preview hunk |
| `<Leader>hb` | n | Blame line (full) |
| `<Leader>hd` | n | Diff this |
| `<Leader>hD` | n | Diff this ~ |
| `<Leader>htb` | n | Toggle blame |
| `<Leader>htd` | n | Toggle deleted |
| `ih` | o, x | Select hunk (text object) |

---

## Editing

### Surround
| Binding | Mode | Description |
|---------|------|-------------|
| `ys{motion}{char}` | n | Add surround |
| `ds{char}` | n | Delete surround |
| `cs{old}{new}` | n | Change surround |
| `S{char}` | v | Surround selection |

### Yank (Yanky)
| Binding | Mode | Description |
|---------|------|-------------|
| `y` | n, x | Yank (with highlight) |
| `p` | n, x | Put after |
| `P` | n, x | Put before |
| `gp` | n, x | Put after cursor |
| `gP` | n, x | Put before cursor |
| `<C-p>` | n | Previous yank (cycle history) |
| `<C-n>` | n | Next yank (cycle history) |
| `]p` | n | Put indented after |
| `[p` | n | Put indented before |

### Autopairs
| Binding | Mode | Description |
|---------|------|-------------|
| `<M-e>` | i | FastWrap (wrap with pair) |

### Indentation
| Binding | Mode | Description |
|---------|------|-------------|
| `<Tab>` | v | Indent right |
| `<S-Tab>` | v | Indent left |
| `>` | n | Indent line right |
| `<` | n | Indent line left |
| `<` | x | Indent left + reselect |
| `>` | x | Indent right + reselect |

### Misc Editing
| Binding | Mode | Description |
|---------|------|-------------|
| `<CR>` | n | Toggle fold |
| `<BS>` | n, x | Go to matching bracket |
| `,<Space>` | n | Remove trailing whitespace |
| `,d` | n | Toggle diff mode |
| `gp` | n | Select last paste |
| `<Leader>m` | n | Edit macro |
| `<Leader>ml` | n | Append modeline |
| `<Leader>S` | n | Source current line |
| `<Leader>S` | v | Source selection |

---

## Treesitter Text Objects

### Selection
| Binding | Mode | Description |
|---------|------|-------------|
| `af` | o, x | Outer function |
| `if` | o, x | Inner function |
| `ac` | o, x | Outer class |
| `ic` | o, x | Inner class |
| `aa` | o, x | Outer parameter |
| `ia` | o, x | Inner parameter |
| `ab` | o, x | Outer block |
| `ib` | o, x | Inner block |

### Movement
| Binding | Mode | Description |
|---------|------|-------------|
| `]f` | n | Next function start |
| `]F` | n | Next function end |
| `[f` | n | Previous function start |
| `[F` | n | Previous function end |
| `]c` | n | Next class start |
| `]C` | n | Next class end |
| `[c` | n | Previous class start |
| `[C` | n | Previous class end |
| `]a` | n | Next parameter |
| `[a` | n | Previous parameter |

### Swap
| Binding | Mode | Description |
|---------|------|-------------|
| `<Leader>sa` | n | Swap parameter with next |
| `<Leader>sA` | n | Swap parameter with previous |

### Incremental Selection
| Binding | Mode | Description |
|---------|------|-------------|
| `<C-Space>` | n | Start/expand selection |
| `<BS>` | x | Shrink selection |

---

## Completion (Blink)

| Binding | Mode | Description |
|---------|------|-------------|
| `<CR>` | i | Accept completion |
| `<Tab>` | i | Next item / snippet forward |
| `<S-Tab>` | i | Previous item / snippet back |
| `<C-Space>` | i | Trigger completion |
| `<C-e>` | i | Cancel completion |

---

## AI (`<Leader>c` prefix)

| Binding | Mode | Description |
|---------|------|-------------|
| `<Leader>cc` | n, v | CodeCompanion actions |
| `<Leader>ca` | v | Add selection to chat |
| `<Leader>ct` | n | Toggle chat |

---

## Toggles (`<Leader>t` prefix)

| Binding | Mode | Description |
|---------|------|-------------|
| `<Leader>ts` | n | Toggle spell |
| `<Leader>th` | n | Clear search highlight |
| `<Leader>tw` | n | Toggle wrap |

---

## Misc

| Binding | Mode | Description |
|---------|------|-------------|
| `<Leader>gu` | n | Toggle undo tree |
| `<Leader>gg` | n, v | Grep word under cursor |
| `<Leader>y` | n | Copy file path to clipboard |
| `<Leader>?` | n | Show buffer keymaps |
| `gh` | n | Show highlight groups |
| `!` | n | Start shell command |
| `Q` | n | Disabled (was Ex mode) |
| `*` | v | Search selection forward |
| `#` | v | Search selection backward |

---

## Quickfix Buffer

| Binding | Mode | Description |
|---------|------|-------------|
| `<CR>` | n | Open + center + return |
| `sv` | n | Open in split |
| `sg` | n | Open in vertical split |
| `st` | n | Open in new tab |
| `dd` / `x` | n | Delete entry |
| `d` / `x` | v | Delete entries |
| `u` | n | Undo delete |

---

## Command Line

| Binding | Mode | Description |
|---------|------|-------------|
| `<C-j>` | c | Move left |
| `<C-k>` | c | Move right |
| `<C-h>` | c | Go to start |
| `<C-l>` | c | Go to end |
| `<C-d>` | c | Delete word |
| `W!!` | c | Save with sudo |

---

## Abbreviations (Command Mode)

| Type | Expands To |
|------|------------|
| `qw` | `wq` |
| `Wq` | `wq` |
| `WQ` | `wq` |
| `Q` | `q` |
| `Qa` | `qa` |
| `Bd` | `bd` |
| `bD` | `bd` |
| `t` | `tabe` |
| `T` | `tabe` |
