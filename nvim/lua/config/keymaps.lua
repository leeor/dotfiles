-- Keymaps configuration
local map = vim.keymap.set

-- Release keys for plugins
map({ "n", "x" }, ";", "<Nop>")
map({ "n", "x" }, "<Space>", "<Nop>")
map({ "n", "x" }, ",", "<Nop>")

-- Window-control prefix (s)
map("n", "s", "<Nop>")

-- Disable arrow keys in normal mode (resize windows instead)
map("n", "<Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<Left>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })
map("n", "<Right>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })

-- Toggle fold with Enter
map("n", "<CR>", "za", { desc = "Toggle fold" })

-- Use backspace for matchit
map({ "n", "x" }, "<BS>", "%", { desc = "Go to matching bracket" })

-- Start external command with single bang
map("n", "!", ":!", { desc = "Start external command" })

-- Allow misspellings
vim.cmd([[
cnoreabbrev qw wq
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev Bd bd
cnoreabbrev bD bd
cnoreabbrev t tabe
cnoreabbrev T tabe
]])

-- Quick substitute in visual mode
map("x", "s", ":s//", { desc = "Substitute in selection" })

-- Improved scroll
map("n", "zz", function()
    local winline = vim.fn.winline()
    local winheight = vim.fn.winheight(0)
    if winline == math.floor((winheight + 1) / 2) then
        return "zt"
    elseif winline == 1 then
        return "zb"
    else
        return "zz"
    end
end, { expr = true, desc = "Smart zz" })

map({ "n", "x" }, "<C-f>", function()
    return math.max(vim.fn.winheight(0) - 2, 1) .. "<C-d>" .. (vim.fn.line("w$") >= vim.fn.line("$") and "L" or "M")
end, { expr = true, desc = "Page down" })

map({ "n", "x" }, "<C-b>", function()
    return math.max(vim.fn.winheight(0) - 2, 1) .. "<C-u>" .. (vim.fn.line("w0") <= 1 and "H" or "M")
end, { expr = true, desc = "Page up" })

map({ "n", "x" }, "<C-e>", function()
    return vim.fn.line("w$") >= vim.fn.line("$") and "j" or "3<C-e>"
end, { expr = true, desc = "Scroll down" })

map({ "n", "x" }, "<C-y>", function()
    return vim.fn.line("w0") <= 1 and "k" or "3<C-y>"
end, { expr = true, desc = "Scroll up" })

-- Keep selection after indenting
map("x", "<", "<gv", { desc = "Indent left and reselect" })
map("x", ">", ">gv|", { desc = "Indent right and reselect" })

-- Use tab for indenting in visual mode
map("v", "<Tab>", ">gv|", { desc = "Indent right" })
map("v", "<S-Tab>", "<gv", { desc = "Indent left" })
map("n", ">", ">>_", { desc = "Indent right" })
map("n", "<", "<<_", { desc = "Indent left" })

-- Select last paste
map("n", "gp", "'`[' . strpart(getregtype(), 0, 1) . '`]'", { expr = true, desc = "Select last paste" })

-- Disable EX-mode
map("n", "Q", "<Nop>")
map("n", "gQ", "<Nop>")

-- Command line navigation
map("c", "<C-j>", "<Left>", { desc = "Move left" })
map("c", "<C-k>", "<Right>", { desc = "Move right" })
map("c", "<C-h>", "<Home>", { desc = "Go to start" })
map("c", "<C-l>", "<End>", { desc = "Go to end" })
map("c", "<C-f>", "<Right>", { desc = "Move right" })
map("c", "<C-b>", "<Left>", { desc = "Move left" })
map("c", "<C-d>", "<C-w>", { desc = "Delete word" })

-- Save with sudo
map("c", "W!!", "w !sudo tee % >/dev/null", { desc = "Save with sudo" })

-- Show highlight names under cursor
map("n", "gh", function()
    local result = vim.treesitter.get_captures_at_cursor(0)
    if #result == 0 then
        vim.notify("No treesitter captures", vim.log.levels.INFO)
    else
        vim.notify(vim.inspect(result), vim.log.levels.INFO)
    end
end, { desc = "Show highlight groups" })

-- Toggle options
map("n", "<Leader>ts", "<cmd>setlocal spell!<CR>", { desc = "Toggle spell" })
map("n", "<Leader>th", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<Leader>tw", "<cmd>setlocal wrap! breakindent!<CR>", { desc = "Toggle wrap" })

-- Visual search
map("v", "*", [[y/\V<C-R>=escape(@", '/\')<CR><CR>]], { desc = "Search forward" })
map("v", "#", [[y?\V<C-R>=escape(@", '?\')<CR><CR>]], { desc = "Search backward" })

-- Tabs
map("n", "g0", "<cmd>tabfirst<CR>", { desc = "First tab" })
map("n", "g$", "<cmd>tablast<CR>", { desc = "Last tab" })
map("n", "gr", "<cmd>tabprevious<CR>", { desc = "Previous tab" })

-- Remove trailing whitespace
map("n", ",<Space>", [[<cmd>keeppatterns %s/\s\+$//e<CR>]], { desc = "Remove trailing whitespace" })

-- Diff toggle
map("n", ",d", function()
    if vim.wo.diff then
        vim.cmd("diffoff")
    else
        vim.cmd("diffthis")
    end
end, { desc = "Toggle diff" })

-- Source line/selection
map("v", "<Leader>S", "y:execute @@<CR>:echo 'Sourced selection.'<CR>", { desc = "Source selection" })
map("n", "<Leader>S", "^vg_y:execute @@<CR>:echo 'Sourced line.'<CR>", { desc = "Source line" })

-- Yank buffer path to clipboard
map("n", "<Leader>y", '<cmd>let @+=expand("%")<CR>:echo "Copied path to clipboard"<CR>', { desc = "Copy file path" })

-- Append modeline
map("n", "<Leader>ml", function()
    local modeline = string.format(
        " vim: set ts=%d sw=%d tw=%d %set :",
        vim.bo.tabstop,
        vim.bo.shiftwidth,
        vim.bo.textwidth,
        vim.bo.expandtab and "" or "no"
    )
    modeline = vim.bo.commentstring:gsub("%%s", modeline)
    vim.api.nvim_buf_set_lines(0, -1, -1, false, { modeline })
end, { desc = "Append modeline" })

-- Edit macro
map("n", "<Leader>m", [[:<C-u><C-r><C-r>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-f><Left>]], { desc = "Edit macro" })

-- Window splits with previous buffer
map("n", "sh", "<cmd>split<CR><cmd>wincmd p<CR><cmd>e#<CR>", { desc = "Split horizontal with prev buffer" })
map("n", "sv", "<cmd>vsplit<CR><cmd>wincmd p<CR><cmd>e#<CR>", { desc = "Split vertical with prev buffer" })

-- LSP mappings
map("n", "<Leader>ld", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "<Leader>ly", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
map("n", "<Leader>lt", vim.lsp.buf.hover, { desc = "Hover info" })
map("n", "<Leader>li", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "<Leader>lR", vim.lsp.buf.references, { desc = "Find references" })
map("n", "<Leader>lds", vim.lsp.buf.document_symbol, { desc = "Document symbols" })
map("n", "<Leader>lws", vim.lsp.buf.workspace_symbol, { desc = "Workspace symbols" })
map("n", "<Leader>lc", vim.lsp.codelens.run, { desc = "Run codelens" })
map("n", "<Leader>sh", vim.lsp.buf.signature_help, { desc = "Signature help" })
map("n", "<Leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<Leader>f", vim.lsp.buf.format, { desc = "Format buffer" })
map({ "n", "v" }, "<Leader>la", vim.lsp.buf.code_action, { desc = "Code action" })

-- Diagnostics
map("n", "<Leader>aa", vim.diagnostic.setqflist, { desc = "All diagnostics to quickfix" })
map("n", "<Leader>ae", function() vim.diagnostic.setqflist({ severity = "E" }) end, { desc = "Errors to quickfix" })
map("n", "<Leader>aw", function() vim.diagnostic.setqflist({ severity = "W" }) end, { desc = "Warnings to quickfix" })
map("n", "<Leader>d", vim.diagnostic.setloclist, { desc = "Buffer diagnostics" })

-- Quickfix helpers
vim.api.nvim_create_user_command("Qargs", function()
    local buffer_numbers = {}
    for _, item in ipairs(vim.fn.getqflist()) do
        buffer_numbers[item.bufnr] = vim.fn.bufname(item.bufnr)
    end
    vim.cmd("args " .. table.concat(vim.tbl_values(buffer_numbers), " "))
end, { desc = "Populate args from quickfix" })
