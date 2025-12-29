-- Colorscheme plugins
return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = false,
                integrations = {
                    blink_cmp = true,
                    flash = true,
                    gitsigns = true,
                    markdown = true,
                    noice = true,
                    telescope = { enabled = true },
                    treesitter = true,
                    which_key = true,
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        opts = {
            extra_groups = {
                "NormalFloat",
                "FloatBorder",
            },
        },
    },
}
