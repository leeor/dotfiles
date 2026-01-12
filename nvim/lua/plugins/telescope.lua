-- Telescope and fuzzy finding
return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
            },
            "nvim-telescope/telescope-ui-select.nvim",
        },
        cmd = "Telescope",
        keys = {
            -- Files
            { ";f", "<cmd>Telescope find_files<CR>", desc = "Find files" },
            { ";b", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
            { ";h", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
            { ";H", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
            { ";r", "<cmd>Telescope resume<CR>", desc = "Resume search" },
            { ";R", "<cmd>Telescope registers<CR>", desc = "Registers" },

            -- Git
            { ";c", "<cmd>Telescope git_bcommits<CR>", desc = "Buffer commits" },
            { ";C", "<cmd>Telescope git_commits<CR>", desc = "Commits" },

            -- Grep
            { ";g", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
            {
                "<Leader>gg",
                function()
                    local mode = vim.fn.mode()
                    if mode == "v" or mode == "V" or mode == "\22" then
                        -- Get visual selection
                        vim.cmd('noau normal! "vy')
                        local text = vim.fn.getreg("v")
                        text = text:gsub("\n", "")
                        require("telescope.builtin").grep_string({ search = text })
                    else
                        require("telescope.builtin").grep_string()
                    end
                end,
                mode = { "n", "v" },
                desc = "Grep word/selection",
            },
            { ";l", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Buffer lines" },

            -- Quickfix
            { ";q", "<cmd>Telescope quickfix<CR>", desc = "Quickfix" },
            { ";Q", "<cmd>Telescope quickfixhistory<CR>", desc = "Quickfix history" },

            -- LSP
            { "<Leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document symbols" },
            { "<Leader>lS", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "Workspace symbols" },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {
                    sorting_strategy = "ascending",
                    path_display = { "filename_first" },
                    layout_config = {
                        horizontal = { prompt_position = "top" },
                        vertical = { prompt_position = "top" },
                    },
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                            ["<C-w>"] = actions.delete_buffer,
                        },
                        n = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                            ["<C-w>"] = actions.delete_buffer,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                    live_grep = {
                        additional_args = { "--hidden" },
                    },
                    grep_string = {
                        additional_args = { "--hidden" },
                    },
                    buffers = {
                        ignore_current_buffer = true,
                        sort_mru = true,
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            })

            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")
        end,
    },

    -- Frecency (frequently/recently used files)
    {
        "nvim-telescope/telescope-frecency.nvim",
        version = "*",
        config = function()
            require("telescope").load_extension("frecency")
        end,
        keys = {
            { ";F", "<cmd>Telescope frecency<CR>", desc = "Frecency files" },
        },
    },
}
