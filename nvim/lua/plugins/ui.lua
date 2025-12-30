-- UI plugins
return {
    -- Indent guides (subtle)
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            indent = {
                char = "│",
                tab_char = "│",
            },
            scope = {
                enabled = true,
                show_start = false,
                show_end = false,
                highlight = { "Function", "Label" },
            },
            exclude = {
                filetypes = {
                    "help", "dashboard", "lazy", "mason", "notify", "toggleterm",
                    "lazyterm", "trouble", "Trouble", "neo-tree", "oil",
                },
            },
        },
        config = function(_, opts)
            -- Make it subtle - use a dim color
            vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3b4261", nocombine = true })
            vim.api.nvim_set_hl(0, "IblScope", { fg = "#565f89", nocombine = true })
            require("ibl").setup(opts)
        end,
    },

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "auto",
                globalstatus = true,
            },
            sections = {
                lualine_c = { "filename", "lsp_status" },
            },
        },
    },

    -- Icons
    { "nvim-tree/nvim-web-devicons", lazy = true },

    -- Noice (better UI for messages, cmdline, popupmenu)
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = true,
            },
        },
    },

    -- Which-key for keybinding hints
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
            spec = {
                { "<Leader>g", group = "git" },
                { "<Leader>h", group = "hunks" },
                { "<Leader>l", group = "lsp" },
                { "<Leader>a", group = "diagnostics" },
                { "<Leader>t", group = "toggle" },
                { "<Leader>c", group = "code/ai" },
                { ";", group = "files" },
                { "s", group = "window" },
                { "<Leader><Leader>", group = "hop/motion" },
            },
        },
        keys = {
            {
                "<Leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer keymaps",
            },
        },
    },

    -- Trouble for diagnostics
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        opts = {},
        keys = {
            { "<Leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
            { "<Leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics (Trouble)" },
            { "<Leader>xs", "<cmd>Trouble symbols toggle focus=false<CR>", desc = "Symbols (Trouble)" },
            { "<Leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", desc = "LSP (Trouble)" },
            { "<Leader>xL", "<cmd>Trouble loclist toggle<CR>", desc = "Location List (Trouble)" },
            { "<Leader>xQ", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix List (Trouble)" },
        },
    },

    -- Better quickfix
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        opts = {},
    },

    -- Quickfix reflector (edit quickfix and apply changes)
    { "stefandtw/quickfix-reflector.vim", ft = "qf" },
}
