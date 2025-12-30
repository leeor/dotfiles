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
| `<Leader>cf` | n, v | Format buffer (conform) |

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

### Diffview
| Binding | Mode | Description |
|---------|------|-------------|
| `<Leader>gv` | n | Open diffview |
| `<Leader>gV` | n | Close diffview |
| `<Leader>gf` | n | File history (current file) |
| `<Leader>gF` | n | Branch history |

### Git Conflict (in conflict markers)
| Binding | Mode | Description |
|---------|------|-------------|
| `co` | n | Choose ours |
| `ct` | n | Choose theirs |
| `c0` | n | Choose none |
| `cb` | n | Choose both |
| `]x` | n | Next conflict |
| `[x` | n | Previous conflict |

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

## Text Objects (mini.ai + Treesitter)

### Selection
| Binding | Mode | Description |
|---------|------|-------------|
| `af` / `if` | o, x | Outer/inner function |
| `ac` / `ic` | o, x | Outer/inner class |
| `aa` / `ia` | o, x | Outer/inner parameter |
| `ab` / `ib` | o, x | Outer/inner block |
| `ao` / `io` | o, x | Outer/inner block/conditional/loop |
| `at` / `it` | o, x | Outer/inner HTML tag |
| `ad` / `id` | o, x | Digits |
| `ae` / `ie` | o, x | Word with case (camelCase parts) |
| `au` / `iu` | o, x | Function call |
| `aU` / `iU` | o, x | Function call (without dot) |
| `a"` / `i"` | o, x | Double quotes |
| `a'` / `i'` | o, x | Single quotes |
| `` a` `` / `` i` `` | o, x | Backticks |
| `a(` / `i(` | o, x | Parentheses |
| `a{` / `i{` | o, x | Braces |
| `a[` / `i[` | o, x | Brackets |

### Movement
| Binding | Mode | Description |
|---------|------|-------------|
| `]f` / `[f` | n | Next/previous function start |
| `]F` / `[F` | n | Next/previous function end |
| `]c` / `[c` | n | Next/previous class start |
| `]C` / `[C` | n | Next/previous class end |
| `]a` / `[a` | n | Next/previous parameter |
| `[x` | n | Jump to treesitter context |

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

## File Explorer (Oil)

| Binding | Mode | Description |
|---------|------|-------------|
| `<Leader>o` | n | Open Oil (parent directory) |
| `<Leader>O` | n | Open Oil (cwd) |

### Inside Oil
| Binding | Description |
|---------|-------------|
| `<CR>` | Open file/directory |
| `-` | Go to parent directory |
| `<C-v>` | Open in vertical split |
| `<C-s>` | Open in horizontal split |
| `<C-t>` | Open in new tab |
| `<C-p>` | Preview |
| `g.` | Toggle hidden files |
| `g?` | Show help |

---

## Search & Replace (Grug-far)

| Binding | Mode | Description |
|---------|------|-------------|
| `<Leader>sr` | n | Search and replace |
| `<Leader>sr` | v | Search and replace (selection) |
| `<Leader>sR` | n | Search and replace (current file) |

---

## Testing (Neotest)

| Binding | Mode | Description |
|---------|------|-------------|
| `<Leader>tn` | n | Run nearest test |
| `<Leader>tf` | n | Run file tests |
| `<Leader>ts` | n | Run test suite |
| `<Leader>tl` | n | Run last test |
| `<Leader>td` | n | Debug nearest test |
| `<Leader>to` | n | Show test output |
| `<Leader>tO` | n | Toggle output panel |
| `<Leader>tS` | n | Toggle test summary |
| `<Leader>tw` | n | Toggle watch mode |
| `<Leader>tx` | n | Stop test |
| `]t` / `[t` | n | Next/previous failed test |

---

## Misc

| Binding | Mode | Description |
|---------|------|-------------|
| `<Leader>gu` | n | Toggle undo tree |
| `<Leader>gg` | n, v | Grep word/selection |
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
