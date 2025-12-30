-- Git plugins
return {
    -- Diffview for comprehensive diffs
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
        keys = {
            { "<Leader>gv", "<cmd>DiffviewOpen<CR>", desc = "Diffview open" },
            { "<Leader>gV", "<cmd>DiffviewClose<CR>", desc = "Diffview close" },
            { "<Leader>gf", "<cmd>DiffviewFileHistory %<CR>", desc = "File history" },
            { "<Leader>gF", "<cmd>DiffviewFileHistory<CR>", desc = "Branch history" },
        },
        opts = {
            enhanced_diff_hl = true,
            view = {
                default = { layout = "diff2_horizontal" },
                merge_tool = { layout = "diff3_mixed" },
            },
            file_panel = {
                listing_style = "tree",
                win_config = { position = "left", width = 35 },
            },
        },
    },

    -- Git conflict resolution
    {
        "akinsho/git-conflict.nvim",
        version = "*",
        event = "BufReadPre",
        opts = {
            default_mappings = {
                ours = "co",
                theirs = "ct",
                none = "c0",
                both = "cb",
                next = "]x",
                prev = "[x",
            },
            disable_diagnostics = true,
            highlights = {
                incoming = "DiffAdd",
                current = "DiffText",
            },
        },
    },

    -- Fugitive
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "Gwrite", "Gread", "Gdiff", "Gcommit", "Gbrowse", "Gedit" },
        keys = {
            { "<Leader>gs", "<cmd>vertical Git<CR>", desc = "Git status" },
            { "<Leader>gw", "<cmd>Gwrite<CR>", desc = "Git write (stage)" },
            { "<Leader>go", "<cmd>Gread<CR>", desc = "Git checkout file" },
            { "<Leader>gd", "<cmd>Gdiff<CR>", desc = "Git diff" },
            { "<Leader>gb", "<cmd>Git blame<CR>", desc = "Git blame" },
            { "<Leader>gc", "<cmd>Gcommit<CR>", desc = "Git commit" },
            { "<Leader>ga", "<cmd>Gcommit --amend<CR>", desc = "Git amend" },
            { "<Leader>gB", "<cmd>GBrowse<CR>", desc = "Git browse" },
            { "<Leader>ge", "<cmd>Gedit<CR>", desc = "Git edit" },
            { "<Leader>gE", ":Gedit ", desc = "Git edit (prompt)" },
        },
    },

    -- Gitsigns
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            numhl = true,
            signcolumn = true,
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 500,
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]h", function()
                    if vim.wo.diff then return "]h" end
                    vim.schedule(function() gs.next_hunk() end)
                    return "<Ignore>"
                end, { expr = true, desc = "Next hunk" })

                map("n", "[h", function()
                    if vim.wo.diff then return "[h" end
                    vim.schedule(function() gs.prev_hunk() end)
                    return "<Ignore>"
                end, { expr = true, desc = "Previous hunk" })

                -- Actions
                map("n", "<Leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
                map("n", "<Leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
                map("v", "<Leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage hunk" })
                map("v", "<Leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset hunk" })
                map("n", "<Leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
                map("n", "<Leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
                map("n", "<Leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
                map("n", "<Leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
                map("n", "<Leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })
                map("n", "<Leader>hd", gs.diffthis, { desc = "Diff this" })
                map("n", "<Leader>hD", function() gs.diffthis("~") end, { desc = "Diff this ~" })
                map("n", "<Leader>htb", gs.toggle_current_line_blame, { desc = "Toggle blame" })
                map("n", "<Leader>htd", gs.toggle_deleted, { desc = "Toggle deleted" })

                -- Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
            end,
        },
    },
}
