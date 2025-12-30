-- Testing configuration
return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            -- Adapters
            "fredrikaverpil/neotest-golang",
            "marilari88/neotest-vitest",
        },
        keys = {
            { "<Leader>tn", function() require("neotest").run.run() end, desc = "Run nearest test" },
            { "<Leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
            { "<Leader>ts", function() require("neotest").run.run({ suite = true }) end, desc = "Run test suite" },
            { "<Leader>tl", function() require("neotest").run.run_last() end, desc = "Run last test" },
            { "<Leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
            { "<Leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show test output" },
            { "<Leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
            { "<Leader>tS", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
            { "<Leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle watch mode" },
            { "<Leader>tx", function() require("neotest").run.stop() end, desc = "Stop test" },
            { "[t", function() require("neotest").jump.prev({ status = "failed" }) end, desc = "Previous failed test" },
            { "]t", function() require("neotest").jump.next({ status = "failed" }) end, desc = "Next failed test" },
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-golang")({
                        go_test_args = { "-v", "-race", "-count=1" },
                        dap_go_enabled = true,
                    }),
                    require("neotest-vitest")({
                        filter_dir = function(name)
                            return name ~= "node_modules"
                        end,
                    }),
                },
                status = {
                    virtual_text = true,
                    signs = true,
                },
                output = {
                    enabled = true,
                    open_on_run = false,
                },
                quickfix = {
                    enabled = true,
                    open = false,
                },
                floating = {
                    border = "rounded",
                    max_height = 0.6,
                    max_width = 0.8,
                },
                summary = {
                    animated = true,
                    enabled = true,
                    expand_errors = true,
                    follow = true,
                    mappings = {
                        attach = "a",
                        clear_marked = "M",
                        clear_target = "T",
                        debug = "d",
                        debug_marked = "D",
                        expand = { "<CR>", "<2-LeftMouse>" },
                        expand_all = "e",
                        jumpto = "i",
                        mark = "m",
                        next_failed = "J",
                        output = "o",
                        prev_failed = "K",
                        run = "r",
                        run_marked = "R",
                        short = "O",
                        stop = "u",
                        target = "t",
                        watch = "w",
                    },
                },
                icons = {
                    passed = "",
                    running = "",
                    failed = "",
                    skipped = "",
                    unknown = "",
                },
            })
        end,
    },
}
