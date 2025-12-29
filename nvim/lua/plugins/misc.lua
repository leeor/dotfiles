-- Miscellaneous plugins
return {
    -- Undo tree visualization
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
        keys = {
            { "<Leader>gu", "<cmd>UndotreeToggle<CR>", desc = "Toggle undo tree" },
        },
        config = function()
            vim.g.undotree_WindowLayout = 2
            vim.g.undotree_SplitWidth = 40
            vim.g.undotree_SetFocusWhenToggle = 1
        end,
    },

    -- Database client
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
        },
        cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },

    -- JSON syntax (enhanced)
    { "elzr/vim-json", ft = "json" },

    -- JSX syntax
    { "MaxMEllon/vim-jsx-pretty", ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" } },

    -- Highlights
    {
        "NvChad/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            filetypes = { "*" },
            user_default_options = {
                RGB = true,
                RRGGBB = true,
                names = false,
                RRGGBBAA = true,
                css = true,
                css_fn = true,
                mode = "background",
            },
        },
    },
}
