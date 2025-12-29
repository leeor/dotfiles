-- LSP configuration
return {
    -- LSP config
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "saghen/blink.cmp",
        },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            -- Go
            lspconfig.gopls.setup({
                capabilities = capabilities,
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                        },
                        staticcheck = true,
                        gofumpt = true,
                    },
                },
            })

            -- Lua
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_init = function(client)
                    if not client.workspace_folders or not client.workspace_folders[1] then
                        return true
                    end
                    local path = client.workspace_folders[1].name
                    if not vim.uv.fs_stat(path .. "/.luarc.json") and not vim.uv.fs_stat(path .. "/.luarc.jsonc") then
                        client.config.settings = vim.tbl_deep_extend("force", client.config.settings or {}, {
                            Lua = {
                                runtime = { version = "LuaJIT" },
                                workspace = {
                                    checkThirdParty = false,
                                    library = { vim.env.VIMRUNTIME },
                                },
                            },
                        })
                        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                    end
                    return true
                end,
            })

            -- ESLint
            lspconfig.eslint.setup({
                capabilities = capabilities,
                settings = {
                    workingDirectories = { mode = "auto" },
                },
            })

            -- Rust
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        imports = {
                            granularity = { group = "module" },
                            prefix = "self",
                        },
                        cargo = { buildScripts = { enable = true } },
                        procMacro = { enable = true },
                        checkOnSave = { command = "clippy" },
                    },
                },
            })
        end,
    },

    -- TypeScript (enhanced)
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        opts = {
            settings = {
                separate_diagnostic_server = true,
                publish_diagnostic_on = "insert_leave",
                tsserver_plugins = {
                    "@monodon/typescript-nx-imports-plugin",
                },
                tsserver_max_memory = "auto",
                complete_function_calls = false,
                include_completions_with_insert_text = true,
                code_lens = "off",
                jsx_close_tag = { enable = false },
            },
        },
    },

    -- Lua development
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true },

    -- Stylua for Lua formatting
    {
        "ckipp01/stylua-nvim",
        ft = "lua",
    },
}
