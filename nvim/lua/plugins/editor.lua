-- Editor enhancement plugins
return {
    -- Word motion (CamelCase and underscore aware w/b/e)
    {
        "chaoren/vim-wordmotion",
        event = "VeryLazy",
        init = function()
            -- Use default w/b/e/ge (not <Leader>w etc.)
            vim.g.wordmotion_prefix = ""
        end,
    },

    -- Flash (modern motion plugin, replaces hop/easymotion)
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            labels = "etovxqpdygfblzhckisuran",
            modes = {
                search = { enabled = false },
                char = { enabled = true },
            },
        },
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<C-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
            -- Hop-like bindings
            { "<Leader><Leader>w", mode = { "n", "x", "o" }, function() require("flash").jump({ search = { mode = "search", max_length = 0 }, label = { after = { 0, 0 } }, pattern = "^" }) end, desc = "Flash line start" },
            { "<Leader><Leader>j", mode = { "n", "x", "o" }, function() require("flash").jump({ search = { mode = "search", max_length = 0, forward = true, wrap = false }, label = { after = { 0, 0 } }, pattern = "^" }) end, desc = "Flash lines down" },
            { "<Leader><Leader>k", mode = { "n", "x", "o" }, function() require("flash").jump({ search = { mode = "search", max_length = 0, forward = false, wrap = false }, label = { after = { 0, 0 } }, pattern = "^" }) end, desc = "Flash lines up" },
        },
    },

    -- Surround (Lua native)
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },

    -- Autopairs (Lua native)
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            check_ts = true,
            ts_config = {
                lua = { "string" },
                javascript = { "template_string" },
            },
            fast_wrap = {
                map = "<M-e>",
                chars = { "{", "[", "(", '"', "'" },
                pattern = [=[[%'%"%>%]%)%}%,]]=],
                end_key = "$",
                before_key = "h",
                after_key = "l",
                cursor_pos_before = true,
                keys = "qwertyuiopzxcvbnmasdfghjkl",
                manual_position = true,
                highlight = "Search",
                highlight_grey = "Comment",
            },
        },
    },

    -- Yanky (better yank/paste with history, flash on yank)
    {
        "gbprod/yanky.nvim",
        dependencies = { "kkharji/sqlite.lua" },
        opts = {
            ring = {
                storage = "sqlite",
            },
            highlight = {
                on_put = true,
                on_yank = true,
                timer = 200,
            },
        },
        keys = {
            { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank" },
            { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put after" },
            { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put before" },
            { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put after cursor" },
            { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put before cursor" },
            { "<C-p>", "<Plug>(YankyPreviousEntry)", desc = "Previous yank" },
            { "<C-n>", "<Plug>(YankyNextEntry)", desc = "Next yank" },
            { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after" },
            { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before" },
        },
    },

    -- Case conversion
    { "arthurxavierx/vim-caser", event = "VeryLazy" },

    -- Window picker
    {
        "t9md/vim-choosewin",
        keys = {
            { "-", "<Plug>(choosewin)", desc = "Choose window" },
            { "_", "<cmd>ChooseWinSwapStay<CR>", desc = "Swap window" },
        },
    },

    -- Tim Pope essentials
    { "tpope/vim-unimpaired", event = "VeryLazy" },
    { "tpope/vim-abolish", event = "VeryLazy" },
    { "tpope/vim-sleuth", event = "VeryLazy" },
    { "tpope/vim-vinegar", event = "VeryLazy" },

    -- Enhanced text objects (replaces textobj-user)
    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().googletag<googletag./%1>" },
                    d = { "%f[%d]%d+" }, -- digits
                    e = { -- Word with case
                        { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
                        "^().*googletag",
                    },
                    u = ai.gen_spec.function_call(), -- function calls
                    U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot
                },
            }
        end,
    },

    -- Oil file explorer
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "Oil",
        keys = {
            { "<Leader>o", "<cmd>Oil<CR>", desc = "Open Oil (parent dir)" },
            { "<Leader>O", "<cmd>Oil .<CR>", desc = "Open Oil (cwd)" },
        },
        opts = {
            default_file_explorer = true,
            columns = { "icon" },
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-v>"] = "actions.select_vsplit",
                ["<C-s>"] = "actions.select_split",
                ["<C-t>"] = "actions.select_tab",
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["<C-r>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
            view_options = {
                show_hidden = false,
            },
            float = {
                padding = 2,
                max_width = 120,
                max_height = 40,
            },
        },
    },

    -- Search and replace
    {
        "MagicDuck/grug-far.nvim",
        cmd = "GrugFar",
        keys = {
            {
                "<Leader>sr",
                function()
                    require("grug-far").open({ transient = true })
                end,
                desc = "Search and replace",
            },
            {
                "<Leader>sr",
                function()
                    require("grug-far").open({ transient = true, prefills = { search = vim.fn.expand("<cword>") } })
                end,
                mode = "v",
                desc = "Search and replace (selection)",
            },
            {
                "<Leader>sR",
                function()
                    require("grug-far").open({ transient = true, prefills = { paths = vim.fn.expand("%") } })
                end,
                desc = "Search and replace (current file)",
            },
        },
        opts = {
            headerMaxWidth = 80,
        },
    },
}
