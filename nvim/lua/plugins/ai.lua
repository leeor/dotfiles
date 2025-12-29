-- AI assistant plugins
return {
    -- MCP Hub
    {
        "ravitemer/mcphub.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        build = "npm install -g mcp-hub@latest",
        config = function()
            require("mcphub").setup()
        end,
    },

    -- CodeCompanion
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim",
            "MeanderingProgrammer/render-markdown.nvim",
            { "stevearc/dressing.nvim", opts = {} },
        },
        cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
        keys = {
            { "<Leader>cc", "<cmd>CodeCompanionActions<CR>", mode = { "n", "v" }, desc = "CodeCompanion actions" },
            { "<Leader>ca", "<cmd>CodeCompanionChat Add<CR>", mode = "v", desc = "Add to chat" },
            { "<Leader>ct", "<cmd>CodeCompanionChat Toggle<CR>", desc = "Toggle chat" },
        },
        config = function()
            require("codecompanion").setup({
                strategies = {
                    chat = { adapter = "anthropic" },
                    inline = { adapter = "anthropic" },
                },
                extensions = {
                    mcphub = {
                        callback = "mcphub.extensions.codecompanion",
                        opts = {
                            show_result_in_chat = true,
                            make_vars = true,
                            make_slash_commands = true,
                        },
                    },
                },
                prompt_library = {
                    ["senior"] = {
                        strategy = "chat",
                        description = "Get help from a senior developer",
                        opts = {
                            is_slash_cmd = true,
                            short_name = "senior",
                        },
                        prompts = {
                            {
                                role = "user",
                                content = [[
When writing code, it's important to keep in mind the following:
- Take into account: Open-closed principle, Clean code principles, SOLID principles, Composition over Inheritance, DRY, KISS, YAGNI.
- Where it makes sense, use design patterns, such as: Factory, Builder, Adapter, Decorator, Observer, Strategy, Command, Visitor, etc.
- Prefer 'tell, don't ask' and 'command-query separation'.
]],
                            },
                        },
                    },
                },
            })
        end,
    },
}
