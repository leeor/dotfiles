-- Formatting configuration
return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<Leader>cf",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = { "n", "v" },
                desc = "Format buffer",
            },
        },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                go = { "gofumpt", "goimports" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                rust = { "rustfmt" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
            -- Customize formatters
            formatters = {
                prettier = {
                    prepend_args = { "--tab-width", "4" },
                },
            },
        },
        init = function()
            -- Use conform for gq
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },
}
