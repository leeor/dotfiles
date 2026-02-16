-- Autocommands configuration
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- General autocommands
local general = augroup("GeneralAutoCmd", { clear = true })

-- Automatically set read-only for files being edited elsewhere
autocmd("SwapExists", {
    group = general,
    callback = function()
        vim.v.swapchoice = "o"
    end,
})

-- Check if file changed when window gains focus
autocmd("WinEnter", {
    group = general,
    command = "checktime",
})

-- Optimize syntax for large files
autocmd("Syntax", {
    group = general,
    callback = function()
        if vim.fn.line("$") > 5000 then
            vim.cmd("syntax sync minlines=200")
        end
    end,
})

-- Update filetype on save if empty
autocmd("BufWritePost", {
    group = general,
    callback = function()
        if vim.bo.filetype == "" or vim.b.ftdetect then
            vim.b.ftdetect = nil
            vim.cmd("filetype detect")
        end
    end,
})

-- Jump to last position when opening a file
autocmd("BufReadPost", {
    group = general,
    callback = function()
        local ft = vim.bo.filetype
        if ft:match("^git") or vim.wo.diff then
            return
        end
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local line = mark[1]
        if line > 0 and line <= vim.api.nvim_buf_line_count(0) then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
            vim.cmd("normal! zvzz")
        end
    end,
})

-- Disable paste mode and update diff on leaving insert
autocmd("InsertLeave", {
    group = general,
    callback = function()
        if vim.o.paste then
            vim.o.paste = false
            vim.o.mouse = "nvi"
            vim.notify("nopaste")
        end
        if vim.wo.diff then
            vim.cmd("diffupdate")
        end
    end,
})

-- Open quickfix window automatically
autocmd("QuickFixCmdPost", {
    group = general,
    pattern = "[^l]*",
    callback = function()
        vim.cmd("botright copen | wincmd p | redraw!")
    end,
})

autocmd("QuickFixCmdPost", {
    group = general,
    pattern = "l*",
    callback = function()
        vim.cmd("botright lopen | wincmd p | redraw!")
    end,
})

-- Fix help window position
autocmd("FileType", {
    group = general,
    pattern = "help",
    callback = function()
        if vim.bo.buftype == "help" then
            vim.cmd("wincmd L")
        end
    end,
})

-- Cursorline for specific buffers
local cursorline_group = augroup("CursorLineByFiletype", { clear = true })

vim.api.nvim_set_hl(0, "CursorLine", { bold = true })

autocmd("FileType", {
    group = cursorline_group,
    pattern = { "fugitive", "qf", "help", "gitrebase" },
    callback = function()
        vim.opt_local.cursorline = true
    end,
})

autocmd("BufEnter", {
    group = cursorline_group,
    callback = function()
        local buftype = vim.bo.buftype
        if buftype == "quickfix" or buftype == "help" then
            vim.opt_local.cursorline = true
        end
    end,
})

-- Filetype-specific settings
local filetype_group = augroup("FiletypeSettings", { clear = true })

autocmd("FileType", {
    group = filetype_group,
    pattern = "help",
    callback = function()
        vim.opt_local.iskeyword:append({ ":", "#", "-" })
    end,
})

autocmd("FileType", {
    group = filetype_group,
    pattern = "crontab",
    callback = function()
        vim.opt_local.backup = false
        vim.opt_local.writebackup = false
    end,
})

autocmd("FileType", {
    group = filetype_group,
    pattern = "gitcommit",
    callback = function()
        vim.opt_local.spell = true
    end,
})

autocmd("FileType", {
    group = filetype_group,
    pattern = { "gitcommit", "qfreplace" },
    callback = function()
        vim.opt_local.foldenable = false
    end,
})

autocmd("FileType", {
    group = filetype_group,
    pattern = { "html", "css", "jsx", "javascript", "typescript", "typescriptreact", "javascriptreact" },
    callback = function()
        vim.opt_local.backupcopy = "yes"
    end,
})

autocmd("FileType", {
    group = filetype_group,
    pattern = { "jsx", "javascript", "typescript", "typescriptreact", "javascriptreact" },
    callback = function()
        vim.opt_local.formatprg = "prettier --stdin-filepath " .. vim.fn.expand("%")
    end,
})

autocmd("FileType", {
    group = filetype_group,
    pattern = "json",
    callback = function()
        vim.opt_local.formatprg = "prettier --parser json --stdin-filepath " .. vim.fn.expand("%")
    end,
})

autocmd("FileType", {
    group = filetype_group,
    pattern = "zsh",
    callback = function()
        vim.opt_local.foldenable = true
        vim.opt_local.foldmethod = "marker"
    end,
})

autocmd("FileType", {
    group = filetype_group,
    pattern = "markdown",
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.expandtab = true
        vim.opt_local.autoindent = true
        vim.opt_local.smartindent = false
        vim.opt_local.wrap = true
        vim.opt_local.comments = "n:>"
        vim.opt_local.formatoptions = "1jcqnt"
        -- Pattern for markdown lists: bullets (-, *, +) and numbered (1., 2), etc.)
        vim.opt_local.formatlistpat = [[^\s*\(\d\+[.)]\|[-*+]\)\s\+]]
    end,
})

autocmd("FileType", {
    group = filetype_group,
    pattern = "go",
    callback = function()
        vim.opt_local.foldmethod = "syntax"
        -- Highlight err
        vim.cmd("highlight default link goErr WarningMsg")
        vim.cmd("match goErr /\\<err\\>/")
    end,
})

autocmd("FileType", {
    group = filetype_group,
    pattern = { "typescript", "typescriptreact" },
    callback = function()
        vim.opt_local.foldmethod = "indent"
        vim.opt_local.foldnestmax = 10
    end,
})

-- ESLint auto-fix on save for JS/TS files (synchronous to prevent corruption)
autocmd("BufWritePre", {
    group = filetype_group,
    pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
    callback = function(args)
        local clients = vim.lsp.get_clients({ bufnr = args.buf, name = "eslint" })
        if #clients == 0 then
            return
        end
        local client = clients[1]
        local result = client:request_sync("textDocument/codeAction", {
            textDocument = vim.lsp.util.make_text_document_params(args.buf),
            range = {
                start = { line = 0, character = 0 },
                ["end"] = { line = vim.api.nvim_buf_line_count(args.buf), character = 0 },
            },
            context = {
                only = { "source.fixAll.eslint" },
                diagnostics = {},
            },
        }, 1000, args.buf)
        if not result or not result.result then
            return
        end
        for _, action in ipairs(result.result) do
            if action.edit then
                vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
            end
        end
    end,
})

-- Quickfix buffer mappings
autocmd("FileType", {
    group = filetype_group,
    pattern = "qf",
    callback = function()
        local opts = { buffer = true, silent = true }
        vim.opt_local.winheight = 3
        vim.opt_local.wrap = false
        vim.opt_local.relativenumber = false
        vim.opt_local.number = true
        vim.opt_local.linebreak = true
        vim.opt_local.list = false
        vim.opt_local.cursorline = true
        vim.opt_local.buflisted = false

        vim.keymap.set("n", "<CR>", "<CR>zz", opts)
        vim.keymap.set("n", "sv", "<C-w><CR>", opts)
        vim.keymap.set("n", "sg", "<C-w><Enter><C-w>L", opts)
        vim.keymap.set("n", "st", "<C-w><CR><C-w>T", opts)

        -- Delete entries from quickfix
        local function del_entry()
            local qf = vim.fn.getqflist()
            local history = vim.w.qf_history or {}
            table.insert(history, vim.deepcopy(qf))
            vim.w.qf_history = history

            local start_line = vim.fn.line("'<") > 0 and vim.fn.line("'<") or vim.fn.line(".")
            local end_line = vim.fn.line("'>") > 0 and vim.fn.line("'>") or vim.fn.line(".")

            for i = end_line, start_line, -1 do
                table.remove(qf, i)
            end
            vim.fn.setqflist(qf, "r")
            vim.cmd(tostring(start_line))
        end

        local function undo_entry()
            local history = vim.w.qf_history or {}
            if #history > 0 then
                local prev = table.remove(history)
                vim.fn.setqflist(prev, "r")
                vim.w.qf_history = history
            end
        end

        vim.keymap.set("n", "dd", del_entry, opts)
        vim.keymap.set("n", "x", del_entry, opts)
        vim.keymap.set("v", "d", del_entry, opts)
        vim.keymap.set("v", "x", del_entry, opts)
        vim.keymap.set("n", "u", undo_entry, opts)
    end,
})

-- Vault protection (don't backup/swap sensitive files)
local vault_group = augroup("VaultProtection", { clear = true })
local sensitive_patterns = {
    "/tmp/*",
    "*/shm/*",
    "/private/var/*",
    ".vault.vim",
    ".env",
    ".env.*",
    "*credentials*",
}

autocmd({ "BufNewFile", "BufReadPre" }, {
    group = vault_group,
    pattern = sensitive_patterns,
    callback = function()
        vim.opt_local.swapfile = false
        vim.opt_local.undofile = false
        vim.opt_local.backup = false
        vim.opt_local.writebackup = false
    end,
})
