-- Completion configuration
return {
    {
        "saghen/blink.cmp",
        lazy = false,
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        version = "v0.*",
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "enter",
                ["<Tab>"] = {
                    function(cmp)
                        if cmp.snippet_active() then
                            return cmp.snippet_forward()
                        elseif cmp.is_menu_visible() then
                            return cmp.select_next()
                        end
                    end,
                    "fallback",
                },
                ["<S-Tab>"] = {
                    function(cmp)
                        if cmp.snippet_active() then
                            return cmp.snippet_backward()
                        elseif cmp.is_menu_visible() then
                            return cmp.select_prev()
                        end
                    end,
                    "fallback",
                },
            },

            completion = {
                keyword = { range = "full" },
                list = {
                    selection = { preselect = false, auto_insert = false },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
                ghost_text = { enabled = true },
                trigger = { prefetch_on_insert = false },
            },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
            },

            sources = {
                default = { "lsp", "buffer", "path", "snippets" },
                per_filetype = {
                    sql = { "snippets", "dadbod", "buffer" },
                },
                providers = {
                    dadbod = {
                        name = "Dadbod",
                        module = "vim_dadbod_completion.blink",
                    },
                },
            },

            signature = { enabled = true },
        },
        opts_extend = { "sources.default" },
    },
}
