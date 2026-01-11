-- Options configuration
local opt = vim.opt

-- General
opt.mouse = "nvi"
opt.modeline = true
opt.report = 0
opt.errorbells = true
opt.visualbell = true
opt.hidden = true
opt.fileformats = { "unix", "dos", "mac" }
opt.magic = true
opt.path:append({ ".", "**" })
opt.virtualedit = "block"
opt.synmaxcol = 1000
opt.gdefault = true
opt.equalalways = true
opt.fixendofline = false

-- Format options
opt.formatoptions:append("1")
opt.formatoptions:remove("2")
opt.formatoptions:remove("t")
opt.formatoptions:remove("l")
opt.formatoptions:append("qcnroj")

-- Encoding
opt.encoding = "utf-8"

-- Views and Sessions
opt.viewoptions:remove("options")
opt.viewoptions:append({ "slash", "unix" })
opt.sessionoptions:remove({ "blank", "options", "globals", "folds", "help", "buffers" })
opt.sessionoptions:append("tabpages")

-- Wildmenu
opt.wildmenu = false
opt.wildmode = { "list:longest", "full" }
opt.wildoptions = "tagfile"
opt.wildignorecase = true
opt.wildignore:append({
    ".git", ".hg", ".svn", ".stversions", "*.pyc", "*.spl", "*.o", "*.out", "*~", "%*",
    "*.jpg", "*.jpeg", "*.png", "*.gif", "*.zip", "**/tmp/**", "*.DS_Store",
    "**/node_modules/**", "**/bower_modules/**", "*/.sass-cache/*", "**/dist/*",
})

-- Directories
local cache_dir = vim.fn.expand(vim.env.XDG_CACHE_HOME or "~/.cache") .. "/nvim"
opt.undofile = true
opt.swapfile = true
opt.backup = false
opt.directory = cache_dir .. "/swap//"
opt.undodir = cache_dir .. "/undo//"
opt.backupdir = cache_dir .. "/backup//"

-- Create directories if they don't exist
for _, dir in ipairs({ "swap", "undo", "backup" }) do
    local path = cache_dir .. "/" .. dir
    if vim.fn.isdirectory(path) == 0 then
        vim.fn.mkdir(path, "p")
    end
end

-- History
opt.history = 2000
opt.shada = { "'300", "<10", "@50", "s100", "h" }

-- Tabs and Indents
opt.textwidth = 100
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true
opt.shiftround = true

-- Timing
opt.timeout = true
opt.ttimeout = true
opt.timeoutlen = 750
opt.ttimeoutlen = 250
opt.updatetime = 500

-- Searching
opt.ignorecase = true
opt.smartcase = true
opt.infercase = true
opt.incsearch = true
opt.hlsearch = true
opt.wrapscan = true
opt.showmatch = true
opt.matchpairs:append("<:>")
opt.matchtime = 1
opt.cpoptions:remove("m")

-- Behavior
opt.wrap = false
opt.linebreak = true
opt.breakat = " \t;:,!?"
opt.startofline = false
opt.whichwrap:append("h,l,<,>,[,],~")
opt.splitbelow = true
opt.splitright = true
opt.switchbuf = { "useopen", "usetab" }
opt.backspace = { "indent", "eol", "start" }
opt.diffopt = { "filler", "iwhiteall", "vertical", "algorithm:patience", "indent-heuristic" }
opt.showfulltag = true
opt.complete = "."
opt.completeopt = { "noinsert", "menuone", "noselect" }
opt.inccommand = "nosplit"

-- Netrw
vim.g.netrw_altfile = 1
vim.g.netrw_liststyle = 3

-- Editor UI
opt.termguicolors = true
opt.showmode = false
opt.shortmess:append("aoOTIcF")
opt.scrolloff = 5
opt.sidescrolloff = 5
opt.relativenumber = true
opt.number = true
opt.ruler = false
opt.list = true
opt.showtabline = 2
opt.tabpagemax = 10
opt.pumheight = 20
opt.helpheight = 12
opt.previewheight = 8
opt.showcmd = false
opt.cmdheight = 1
opt.cmdwinheight = 5
opt.laststatus = 3
opt.colorcolumn = "120"
opt.display = "lastline"
opt.showbreak = "↪"
opt.fillchars = { vert = "│", fold = "─" }
opt.listchars = { tab = "⋮ ", extends = "⟫", precedes = "⟪", nbsp = "␣", trail = "·" }
opt.conceallevel = 2
opt.concealcursor = "niv"
opt.winborder = "rounded"

-- Folds (disabled by default, toggle with zi)
opt.foldenable = false
opt.foldlevelstart = 99
opt.foldnestmax = 10

-- Cursorline (disabled by default, enabled for specific filetypes via autocmds)
opt.cursorline = false
