-- Editor enhancement plugins
return {
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
            { "<Leader><Leader>j", mode = { "n", "x", "o" }, function() require("flash").jump({ search = { mode = "search", max_length = 0 }, label = { after = { 0, 0 } }, pattern = "^", search = { forward = true, wrap = false } }) end, desc = "Flash lines down" },
            { "<Leader><Leader>k", mode = { "n", "x", "o" }, function() require("flash").jump({ search = { mode = "search", max_length = 0 }, label = { after = { 0, 0 } }, pattern = "^", search = { forward = false, wrap = false } }) end, desc = "Flash lines up" },
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

    -- Text objects
    {
        "kana/vim-textobj-user",
        event = "VeryLazy",
        dependencies = {
            "rhysd/vim-textobj-anyblock",
        },
    },
}
