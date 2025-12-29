-- Markdown and documentation plugins
return {
    -- Render markdown in buffer
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        ft = { "markdown", "codecompanion" },
        opts = {
            completions = { blink = { enabled = true } },
            code = {
                disable_background = true,
                language_pad = 1,
            },
            heading = {
                width = "block",
                icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
            },
        },
    },

    -- Image rendering (for Kitty terminal)
    {
        "3rd/image.nvim",
        ft = { "markdown", "norg" },
        build = false, -- Don't build the rock, use magick_cli
        opts = {
            backend = "kitty",
            processor = "magick_cli", -- Use CLI instead of luarock
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "markdown", "vimwiki" },
                },
            },
            max_width = nil,
            max_height = nil,
            max_width_window_percentage = nil,
            max_height_window_percentage = 50,
            kitty_method = "normal",
        },
    },

    -- Diagram rendering (mermaid, plantuml, etc.)
    {
        "3rd/diagram.nvim",
        ft = { "markdown" },
        dependencies = { "3rd/image.nvim" },
        config = function()
            require("diagram").setup({
                integrations = {
                    require("diagram.integrations.markdown"),
                },
                renderer_options = {
                    mermaid = {
                        background = "transparent",
                        theme = "dark",
                        scale = 2,
                    },
                    plantuml = {
                        charset = "utf-8",
                    },
                    d2 = {
                        theme_id = 1,
                    },
                },
            })
        end,
    },
}
