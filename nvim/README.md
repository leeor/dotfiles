# Vim config

Lean mean Vim/Neovim machine, 15-30ms startup time.

Best with Neovim or Vim 7.4+ with +lua +python extensions enabled.

## Features

- Neovim-centric
- Fast startup time
- Robust, yet light weight
- Lazy-load 90% of plugins with [dein.vim]
- Modular configuration
- Unite centric work-flow
- Extensive Deoplete and Neocomplete setup
- Lightweight simple status/tabline
- Easy customizable theme
- Premium color-schemes
- Central location for tags

## Screenshot

![Vim screenshot](http://rafi.io/static/img/project/vim-config/features.png)

## Install

**_1._** Let's clone this repo! Clone to `~/.config/nvim`,
we'll also symlink it for Vim:

```sh
mkdir ~/.config
git clone git://github.com/rafi/vim-config.git ~/.config/nvim
ln -s ~/.vim ~/.config/nvim
```

* _Note:_ If your system sets `$XDG_CONFIG_HOME`,
use that instead of `~/.config` in the code above.
Nvim follows the XDG base-directories convention.

**_2._** Almost done! You'll need a YAML interpreter,
either install [yaml2json], or use PyYAML:

```sh
pip install --user PyYAML
```

**_3._** If you are a _first-time Neovim user_, you need the python-neovim
packages. Don't worry, just run the script provided:

```sh
cd ~/.config/nvim
./venv.sh
```

**_4._** Run `make test` to test your nvim/vim version and compatibility.

**_5._** Run `make` to install all plugins.

That's it, enjoy!

## Upgrade

Run `make update`

## Structure

- [config](./config)/ - Configuration
  - [plugins](./config/plugins)/ - Plugin configurations
  - [mappings.vim](./config/mappings.vim) - Key-mappings
  - [filetype.vim](./config/filetype.vim) - Language behavior
  - [general.vim](./config/general.vim) - General configuration
  - [init.vim](./config/init.vim) - `runtimepath` initialization
  - [neovim.vim](./config/neovim.vim) - Neovim specific setup
  - [plugins.vim](./config/plugins.vim) - Plugin bundles
  - [terminal.vim](./config/terminal.vim) - Terminal configuration
  - [theme.vim](./config/theme.vim) - Color-scheme and theme setup
  - [vimrc](./config/vimrc) - Initialization
- [ftplugin](./ftplugin)/ - Language specific custom settings
- [plugin](./plugin)/ - Customized small plugins
- [snippets](./snippets)/ - Personal code snippets
- [themes](./themes)/ - Themes! Combination of styles and color-scheme
- [filetype.vim](./filetype.vim) - Custom filetype detection

## Plugin Highlights

- Package management with caching enabled and lazy loading
- Project-aware tabs and label
- Vimfiler as file-manager + SSH connections
- Go completion via vim-go and gocode
- Javascript completion via Tern
- PHP completion, indent, folds, syntax
- Python jedi completion, pep8 convention
- Languages: Ansible, css3, csv, json, less, markdown, mustache
- Helpers: Undo tree, bookmarks, git, tmux navigation,
    hex editor, sessions, and much more.

_Note_ that 90% of the plugins are **[lazy-loaded]**.

## Non Lazy-Loaded Plugins

Name           | Description
-------------- | ----------------------
[dein.vim] | Dark powered Vim/Neovim plugin manager
[vimproc] | Interactive command execution
[colorschemes] | Awesome color-schemes
[file-line] | Allow opening a file in a given line
[neomru] | MRU source for Unite
[cursorword] | Underlines word under cursor
[gitbranch] | Lightweight git branch detection
[gitgutter] | Shows git diffs in the gutter
[tinyline] | Tiny great looking statusline
[tagabana] | Central location for all tags
[bookmarks] | Bookmarks, works independently from vim marks
[tmux-navigator] | Seamless navigation between tmux panes and vim splits

## Lazy-Loaded Plugins

### Language
Name           | Description
-------------- | ----------------------
[html5] | HTML5 omnicomplete and syntax
[mustache] | Mustache and handlebars syntax
[markdown] | Markdown syntax highlighting
[ansible-yaml] | Additional support for Ansible
[jinja] | Jinja support in vim
[less] | Syntax for LESS
[css3-syntax] | CSS3 syntax support to vim's built-in `syntax/css.vim`
[csv] | Handling column separated data
[pep8-indent] | Nicer Python indentation
[logstash] | Highlights logstash configuration files
[tmux] | vim plugin for tmux.conf
[json] | Better JSON support
[toml] | Syntax for TOML
[i3] | i3 window manager config syntax
[Dockerfile] | syntax and snippets for Dockerfile
[go] | Go development
[jedi-vim] | Python jedi autocompletion library
[ruby] | Ruby configuration files
[portfile] | Macports portfile configuration files
[javascript] | Enhanced Javascript syntax
[javascript-indent] | Javascript indent script
[tern] | Provides Tern-based JavaScript editing support
[php] | Up-to-date PHP syntax file
[phpfold] | PHP folding
[phpcomplete] | Improved PHP omnicompletion
[phpindent] | PHP official indenting
[phpspec] | PhpSpec integration

### Commands
Name           | Description
-------------- | ----------------------
[vimfiler] | Powerful file explorer
[tinycomment] | Robust but light-weight commenting
[vinarise] | Hex editor
[syntastic] | Syntax checking hacks
[gita] | An awesome git handling plugin
[gista] | Manipulate gists in Vim
[undotree] | Ultimate undo history visualizer
[incsearch] | Improved incremental searching
[expand-region] | Visually select increasingly larger regions of text
[open-browser] | Open URI with your favorite browser
[prettyprint] | Pretty-print vim variables
[quickrun] | Run commands quickly
[ref] | Integrated reference viewer
[dictionary] | Dictionary.app interface
[vimwiki] | Personal Wiki for Vim
[thesaurus] | Look up words in an online thesaurus

### Commands
Name           | Description
-------------- | ----------------------
[goyo] | Distraction-free writing
[limelight] | Hyperfocus-writing
[matchit] | Intelligent pair matching
[indentline] | Display vertical indention lines
[choosewin] | Choose window to use, like tmux's 'display-pane'

### Completion
Name           | Description
-------------- | ----------------------
[delimitmate] | Insert mode auto-completion for quotes, parens, brackets
[echodoc] | Print objects' documentation in echo area
[deoplete] | Neovim: Dark powered asynchronous completion framework
[neocomplete] | Next generation completion framework
[neosnippet] | Contains neocomplete snippets source

### Unite
Name           | Description
-------------- | ----------------------
[unite] | Unite and create user interfaces
[unite-colorscheme] | Browse colorschemes
[unite-filetype] | Select file type
[unite-history] | Browse history of command/search
[unite-build] | Build with Unite interface
[unite-outline] | File "outline" source for unite
[unite-tag] | Tags source for Unite
[unite-quickfix] | Quickfix source for Unite
[neossh] | SSH interface for plugins
[unite-pull-request] | GitHub pull-request source for Unite
[junkfile] | Create temporary files for memo and testing
[unite-issue] | Issue manager for JIRA and GitHub

### Operators & Text Objects
Name           | Description
-------------- | ----------------------
[operator-user] | Define your own operator easily
[operator-replace] | Operator to replace text with register content
[operator-surround] | Operator to enclose text objects
[textobj-user] | Create your own text objects
[textobj-multiblock] | Handle multiple brackets objects

[dein.vim]: https://github.com/Shougo/dein.vim
[vimproc]: https://github.com/Shougo/vimproc.vim
[colorschemes]: https://github.com/rafi/awesome-vim-colorschemes
[file-line]: https://github.com/bogado/file-line
[neomru]: https://github.com/Shougo/neomru.vim
[cursorword]: https://github.com/itchyny/vim-cursorword
[gitbranch]: https://github.com/itchyny/vim-gitbranch
[gitgutter]: https://github.com/airblade/vim-gitgutter
[bookmarks]: https://github.com/MattesGroeger/vim-bookmarks
[tmux-navigator]: https://github.com/christoomey/vim-tmux-navigator
[tinyline]: https://github.com/rafi/vim-tinyline
[tagabana]: https://github.com/rafi/vim-tagabana

[html5]: https://github.com/othree/html5.vim
[mustache]: https://github.com/mustache/vim-mustache-handlebars
[markdown]: https://github.com/rcmdnk/vim-markdown
[ansible-yaml]: https://github.com/chase/vim-ansible-yaml
[jinja]: https://github.com/mitsuhiko/vim-jinja
[less]: https://github.com/groenewege/vim-less
[css3-syntax]: https://github.com/hail2u/vim-css3-syntax
[csv]: https://github.com/chrisbra/csv.vim
[pep8-indent]: https://github.com/hynek/vim-python-pep8-indent
[logstash]: https://github.com/robbles/logstash.vim
[tmux]: https://github.com/tmux-plugins/vim-tmux
[json]: https://github.com/elzr/vim-json
[toml]: https://github.com/cespare/vim-toml
[i3]: https://github.com/PotatoesMaster/i3-vim-syntax
[Dockerfile]: https://github.com/ekalinin/Dockerfile.vim
[go]: https://github.com/fatih/vim-go
[jedi-vim]: https://github.com/davidhalter/jedi-vim
[ruby]: https://github.com/vim-ruby/vim-ruby
[portfile]: https://github.com/jstrater/mpvim

[javascript]: https://github.com/jelera/vim-javascript-syntax
[javascript-indent]: https://github.com/jiangmiao/simple-javascript-indenter
[tern]: https://github.com/marijnh/tern_for_vim

[php]: https://github.com/StanAngeloff/php.vim
[phpfold]: https://github.com/rayburgemeestre/phpfolding.vim
[phpcomplete]: https://github.com/shawncplus/phpcomplete.vim
[phpindent]: https://github.com/2072/PHP-Indenting-for-VIm
[phpspec]: https://github.com/rafi/vim-phpspec

[vimfiler]: https://github.com/Shougo/vimfiler.vim
[tinycomment]: https://github.com/rafi/vim-tinycomment
[vinarise]: https://github.com/Shougo/vinarise.vim
[syntastic]: https://github.com/scrooloose/syntastic
[gita]: https://github.com/lambdalisue/vim-gita
[gista]: https://github.com/lambdalisue/vim-gista
[undotree]: https://github.com/mbbill/undotree
[incsearch]: https://github.com/haya14busa/incsearch.vim
[expand-region]: https://github.com/terryma/vim-expand-region
[open-browser]: https://github.com/tyru/open-browser.vim
[prettyprint]: https://github.com/thinca/vim-prettyprint
[quickrun]: https://github.com/thinca/vim-quickrun
[ref]: https://github.com/thinca/vim-ref
[dictionary]: https://github.com/itchyny/dictionary.vim
[vimwiki]: https://github.com/vimwiki/vimwiki
[thesaurus]: https://github.com/beloglazov/vim-online-thesaurus

[goyo]: https://github.com/junegunn/goyo.vim
[limelight]: https://github.com/junegunn/limelight.vim
[matchit]: http://www.vim.org/scripts/script.php?script_id=39
[indentline]: https://github.com/Yggdroot/indentLine
[choosewin]: https://github.com/t9md/vim-choosewin

[delimitmate]: https://github.com/Raimondi/delimitMate
[echodoc]: https://github.com/Shougo/echodoc.vim
[deoplete]: https://github.com/Shougo/deoplete.nvim
[neocomplete]: https://github.com/Shougo/neocomplete.vim
[neosnippet]: https://github.com/Shougo/neosnippet.vim

[unite]: https://github.com/Shougo/unite.vim
[unite-colorscheme]: https://github.com/ujihisa/unite-colorscheme
[unite-filetype]: https://github.com/osyo-manga/unite-filetype
[unite-history]: https://github.com/thinca/vim-unite-history
[unite-build]: https://github.com/Shougo/unite-build
[unite-outline]: https://github.com/h1mesuke/unite-outline
[unite-tag]: https://github.com/tsukkee/unite-tag
[unite-quickfix]: https://github.com/osyo-manga/unite-quickfix
[neossh]: https://github.com/Shougo/neossh.vim
[unite-pull-request]: https://github.com/joker1007/unite-pull-request
[junkfile]: https://github.com/Shougo/junkfile.vim
[unite-issue]: https://github.com/rafi/vim-unite-issue

[operator-user]: https://github.com/kana/vim-operator-user
[operator-replace]: https://github.com/kana/vim-operator-replace
[operator-surround]: https://github.com/rhysd/vim-operator-surround
[textobj-user]: https://github.com/kana/vim-textobj-user
[textobj-multiblock]: https://github.com/osyo-manga/vim-textobj-multiblock

## Custom Key-mappings

Key   | Mode | Action
----- |:----:| ------------------
`Space` | Normal | **Leader**
Arrows | Normal | Resize splits (* Enable `g:elite_mode` in `.vault.vim`)
`Backspace` | Normal | Match bracket (%)
`K` | Normal | Open Zeal or Dash on many file types (except Python+Vim script)
`Y` | Normal | Yank to the end of line (y$)
`<Return>` | Normal | Toggle fold (za)
`S`+`<Return>` | Insert | Start new line from any cursor position (\<C-o>o)
`S`+`<Return>` | Normal | Focus the current fold by closing all others
`hjkl` | Normal | Smart cursor movements (g/hjkl)
`Ctrl`+`f` | Normal | Smart page forward (C-f/C-d)
`Ctrl`+`b` | Normal | Smart page backwards (C-b/C-u)
`Ctrl`+`e` | Normal | Smart scroll down (3C-e/j)
`Ctrl`+`y` | Normal | Smart scroll up (3C-y/k)
`Ctrl`+`q` | Normal | `Ctrl`+`w`
`Ctrl`+`x` | Normal | Switch buffer and placement
`F2` | _All_ | Toggle paste mode
`}` | Normal | After paragraph motion go to first non-blank char (}^)
`<` | Visual/Normal | Indent to left and re-select
`>` | Visual/Normal | Indent to right and re-select
`Tab` | Visual | Indent to right and re-select
`Shift`+`Tab` | Visual | Indent to left and re-select
`gh` | Normal | Show highlight group that matches current cursor
`gp` | Normal | Select last paste
`Q`/`gQ` | Normal | Disable EX-mode (\<Nop>)
`s` | Visual | Replace within selected area
`Ctrl`+`a` | Command | Navigation in command line
`Ctrl`+`b` | Command | Move cursor backward in command line
`Ctrl`+`f` | Command | Move cursor forward in command line
`Ctrl`+`r` | Visual | Replace selection with step-by-step confirmation
`,`+`Space` | Normal | Remove all spaces at EOL
`,`+`d` | Normal | Toggle diff
`<leader>`+`os` | Normal | Load last session
`<leader>`+`se` | Normal | Save current workspace as last session
`<leader>`+`d` | Normal/Visual | Duplicate line or selection
`<leader>`+`S` | Normal/visual | Source selection
`<leader>`+`ml` | Normal | Append modeline

### File Operations

Key   | Mode | Action
----- |:----:| ------------------
`<leader>`+`cd` | Normal | Switch to the directory of opened buffer (:cd %:p:h)
`<leader>`+`w` | Normal/visual | Write (:w)
`<leader>`+`y` | Normal | Copy file-path to X11 clipboard
`Ctrl`+`s` | _All_ | Write (:w)
`W!!` | Command | Write as root

### Editor UI

Key   | Mode | Action
----- |:----:| ------------------
`<leader>`+`ts` | Normal | Toggle spell-checker (:setlocal spell!)
`<leader>`+`tn` | Normal | Toggle line numbers (:setlocal nonumber!)
`<leader>`+`tl` | Normal | Toggle hidden characters (:setlocal nolist!)
`<leader>`+`th` | Normal | Toggle highlighted search (:set hlsearch!)
`<leader>`+`tw` | Normal | Toggle wrap (:setlocal wrap! breakindent!)
`g0` | Normal | Go to first tab (:tabfirst)
`g$` | Normal | Go to last tab (:tablast)
`gr` | Normal | Go to preview tab (:tabprevious)
`Ctrl`+`j` | Normal | Move to split below (<C-w>j)
`Ctrl`+`k` | Normal | Move to upper split (<C-w>k)
`Ctrl`+`h` | Normal | Move to left split (<C-w>h)
`Ctrl`+`l` | Normal | Move to right split (<C-w>l)
`*` | Visual | Search selection forwards
`#` | Visual | Search selection backwards
`<leader>`+`j` | Normal | Next on location list
`<leader>`+`k` | Normal | Previous on location list

### Window Management

Key   | Mode | Action
----- |:----:| ------------------
`q` | Normal | Smart buffer close
`s`+`p` | Normal | Split nicely
`s`+`v` | Normal | :split
`s`+`g` | Normal | :vsplit
`s`+`t` | Normal | Open new tab (:tabnew)
`s`+`o` | Normal | Close other windows (:only)
`s`+`x` | Normal | Remove buffer, leave blank window
`s`+`q` | Normal | Closes current buffer (:close)
`s`+`Q` | Normal | Removes current buffer (:bdelete)
`Tab` | Normal | Next window or tab
`Shift`+`Tab` | Normal | Previous window or tab
`<leader>`+`sv` | Normal | Split with previous buffer
`<leader>`+`sg` | Normal | Vertical split with previous buffer

### Plugin: Unite

Key   | Mode | Action
----- |:----:| ------------------
`;`+`r` | Normal | Resumes Unite window
`;`+`f` | Normal | Opens Unite file recursive search
`;`+`i` | Normal | Opens Unite git file search
`;`+`g` | Normal | Opens Unite grep with ag (the_silver_searcher)
`;`+`u` | Normal | Opens Unite source
`;`+`t` | Normal | Opens Unite tag
`;`+`T` | Normal | Opens Unite tag/include
`;`+`l` | Normal | Opens Unite location list
`;`+`q` | Normal | Opens Unite quick fix
`;`+`e` | Normal | Opens Unite register
`;`+`j` | Normal | Opens Unite jump, change
`;`+`h` | Normal | Opens Unite history/yank
`;`+`s` | Normal | Opens Unite session
`;`+`o` | Normal | Opens Unite outline
`;`+`ma` | Normal | Opens Unite mapping
`;`+`me` | Normal | Opens Unite output messages
`<leader>`+`b` | Normal | Opens Unite buffers, mru, bookmark
`<leader>`+`ta` | Normal | Opens Unite tab
`<leader>`+`gf` | Normal | Opens Unite file with word at cursor
`<leader>`+`gt` | Normal/visual | Opens Unite tag with word at cursor
`<leader>`+`gg` | Visual | Opens Unite navigate with word at cursor
| **Within _Unite_ buffers** |||
`Ctrl`+`h/k/l/r` | Normal | Un-map
`Ctrl`+`r` | Normal | Redraw
`Ctrl`+`j` | Insert | Select next line
`Ctrl`+`k` | Insert | Select previous line
`jj` | Insert | Leave Insert mode
`'` | Normal | Toggle mark current candidate, up
`e` | Normal | Run default action
`gr` | Normal | Grep with Unite on current directory
`gf` | Normal | Find files with Unite on current directory
`gd` | Normal | Change directory for all windows in current tab
`sv` | Normal | Open in a split
`sg` | Normal | Open in a vertical split
`st` | Normal | Open in a new tab
`r` | Normal | Replace ('search' profile) or rename
`Tab` | Normal | Move to other window (`Ctrl`+`w`+`w`)
`Tab` | Insert | Unite auto-completion
`Escape` | Normal | Exit unite
`Ctrl`+`z` | Normal/insert | Toggle transpose window
`Ctrl`+`w` | Insert | Delete backward path

### Plugin: VimFiler

Key   | Mode | Action
----- |:----:| ------------------
`;`+`e` | Normal | Toggle file explorer
`;`+`a` | Normal | Toggle file explorer on current file
| **Within _VimFiler_ buffers** |||
`sv` | Normal | Split edit
`sg` | Normal | Vertical split edit
`p` | Normal | Preview
`i` | Normal | Switch to directory history
`Ctrl`+`r` | Normal | Redraw
`Ctrl`+`q` | Normal | Quick look
`Ctrl`+`j` | Normal | Un-mapped
`Ctrl`+`l` | Normal | Un-mapped
`E` | Normal | Un-mapped

### Plugin: deoplete / neocomplete

Key   | Mode | Action
----- |:----:| ------------------
`Enter` | Insert | Smart snippet expansion
`Ctrl`+`space` | Insert | Autocomplete with Unite
`Tab` | Insert/select | Smart tab movement or completion
`Ctrl`+`j/k/f/b` | Insert | Movement in popup
`Ctrl`+`g` | Insert | Undo completion
`Ctrl`+`l` | Insert | Complete common string
`Ctrl`+`o` | Insert | Expand snippet
`Ctrl`+`y` | Insert | Close pop-up
`Ctrl`+`e` | Insert | Close pop-up
`Ctrl`+`l` | Insert | Complete common string
`Ctrl`+`d` | Insert | Scroll down
`Ctrl`+`u` | Insert | Scroll up

### Plugin: Caw

Key   | Mode | Action
----- |:----:| ------------------
`<leader>`+`v` | Normal/visual | Toggle single-line comments
`<leader>`+`V` | Normal/visual | Toggle comment block

### Plugin: Goyo and Limelight

Key   | Mode | Action
----- |:----:| ------------------
`<leader>`+`G` | Normal | Toggle distraction-free writing

### Plugin: ChooseWin

Key   | Mode | Action
----- |:----:| ------------------
`-` | Normal | Choose a window to edit
`<leader>`+`-` | Normal | Switch editing window with selected

### Plugin: Bookmarks

Key   | Mode | Action
----- |:----:| ------------------
`m`+`a` | Normal | Show list of all bookmarks
`m`+`m` | Normal | Toggle bookmark in current line
`m`+`n` | Normal | Jump to next bookmark
`m`+`p` | Normal | Jump to previous bookmark
`m`+`i` | Normal | Annotate bookmark

### Plugin: Gita

Key   | Mode | Action
----- |:----:| ------------------
`<leader>`+`gs` | Normal | Git status
`<leader>`+`gd` | Normal | Git diff
`<leader>`+`gc` | Normal | Git commit
`<leader>`+`gb` | Normal | Git blame
`<leader>`+`gB` | Normal | Open in browser
`<leader>`+`gp` | Normal | Git push

### Plugin: GitGutter

Key   | Mode | Action
----- |:----:| ------------------
`<leader>`+`hj` | Normal | Jump to next hunk
`<leader>`+`hk` | Normal | Jump to previous hunk
`<leader>`+`hs` | Normal | Stage hunk
`<leader>`+`hr` | Normal | Revert hunk
`<leader>`+`hp` | Normal | Preview hunk

### Misc Plugins

Key   | Mode | Action
----- |:----:| ------------------
`<leader>`+`gu` | Normal | Open undo tree
`<leader>`+`i` | Normal | Toggle indentation lines
`<leader>`+`r` | Normal | Quickrun
`<leader>`+`?` | Normal | Dictionary
`<leader>`+`W` | Normal | Wiki
`<leader>`+`K` | Normal | Thesaurus

## Credits & Contribution

Big thanks to the dark knight [Shougo].

[Shougo]: https://github.com/Shougo
[lazy-loaded]: ./config/plugins.vim
[yaml2json]: https://github.com/koraa/large-yaml2json-json2yaml
