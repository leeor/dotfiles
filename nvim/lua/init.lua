local map = vim.keymap.set

vim.g.mapleader = " "
vim.opt.laststatus = 2

-- bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- theme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.background = 'dark'
            vim.cmd.colorscheme("catppuccin-mocha")
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            theme = 'auto',
            sections = {
                lualine_c = { 'filename', 'lsp_status' }
            }
        }
    },
    'nvim-tree/nvim-web-devicons',
    {
        'xiyaowong/transparent.nvim',
        lazy = false,
    },

    -- movement
    --'easymotion/vim-easymotion',
    {
        'smoka7/hop.nvim',
        version = "*",
        opts = {
            keys = 'etovxqpdygfblzhckisuran',
            quit_key = '<SPC>',
        }
    },
    'kana/vim-operator-user',
    'tpope/vim-unimpaired',
    { 'haya14busa/vim-operator-flashy', dependencies = { 'kana/vim-operator-user' } },
    { 'rhysd/vim-textobj-anyblock',     dependencies = { 'kana/vim-textobj-user' } },
    'arthurxavierx/vim-caser',
    'bkad/CamelCaseMotion',
    't9md/vim-choosewin',
    {
        "3rd/image.nvim",
        event = "VeryLazy",
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter",
                build = ":TSUpdate",
                config = function()
                    require("nvim-treesitter.configs").setup({
                        ensure_installed = { "markdown" },
                        highlight = { enable = true },
                    })
                end,
            },
        },
        opts = {
            backend = "kitty",
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
                },
                neorg = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "norg" },
                },
            },
            max_width = nil,
            max_height = nil,
            max_width_window_percentage = nil,
            max_height_window_percentage = 50,
            kitty_method = "normal",
        },
    },
    {
        "3rd/diagram.nvim",
        dependencies = {
            "3rd/image.nvim",
        },
        opts = { -- you can just pass {}, defaults below
            events = {
                render_buffer = { "InsertLeave", "BufWinEnter", "TextChanged" },
                clear_buffer = {"BufLeave"},
            },
            integrations = {
                --require("diagram.integrations.markdown"),
                --require("diagram.integrations.neorg"),
            },
            renderer_options = {
                mermaid = {
                    background = nil, -- nil | "transparent" | "white" | "#hex"
                    theme = 'forest', -- nil | "default" | "dark" | "forest" | "neutral"
                    scale = 1, -- nil | 1 (default) | 2  | 3 | ...
                    width = nil, -- nil | 800 | 400 | ...
                    height = nil, -- nil | 600 | 300 | ...
                },
                plantuml = {
                    charset = 'utf-8',
                },
                d2 = {
                    theme_id = 1,
                    dark_theme_id = nil,
                    scale = nil,
                    layout = nil,
                    sketch = nil,
                },
                gnuplot = {
                    size = '800,600', -- nil | "800,600" | ...
                    font = nil, -- nil | "Arial,12" | ...
                    theme = "dark", -- nil | "light" | "dark" | custom theme string
                },
            }
        },
    },
    -- GIT
    'tpope/vim-fugitive',
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {
                numhl = true,
                signcolumn = true,
                current_line_blame = true,
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    map('n', '<leader>hj', function()
                        if vim.wo.diff then return '<leader>hj' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, { expr = true })

                    map('n', '<leader>hk', function()
                        if vim.wo.diff then return '<leader>hk' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, { expr = true })

                    map('n', '<leader>hr', gs.reset_hunk)
                    map('n', '<leader>hp', gs.preview_hunk)
                end
            }
        end
    },

    'cohama/lexima.vim',
    'tpope/vim-vinegar',
    'tpope/vim-abolish',
    'tpope/vim-sleuth',
    'junegunn/fzf',
    'nvim-telescope/telescope-ui-select.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzf-native.nvim', 'nvim-treesitter/nvim-treesitter' },
        config = function()
            local ts = require('telescope')

            ts.setup {
                defaults = {
                    sorting_strategy = 'ascending',
                    path_display = { 'filename_first' },
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                        },
                        vertical = {
                            prompt_position = "top",
                        }
                    },
                    mappings = {
                        i = {
                            ['<C-j>'] = require('telescope.actions').move_selection_next,
                            ['<C-k>'] = require('telescope.actions').move_selection_previous,
                            ['<C-q>'] = require('telescope.actions').send_selected_to_qflist,
                            ['<C-w>'] = require('telescope.actions').delete_buffer,
                        },
                        n = {
                            ['<C-j>'] = require('telescope.actions').move_selection_next,
                            ['<C-k>'] = require('telescope.actions').move_selection_previous,
                            ['<C-q>'] = require('telescope.actions').send_selected_to_qflist,
                            ['<C-w>'] = require('telescope.actions').delete_buffer,
                        },
                    }
                },
                pickers = {
                    buffers = {
                        ignore_current_buffer = true,
                        sort_mru = true,
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require('telescope.themes').get_dropdown({});
                    }
                }
            }
        end
    },
    {
        "nvim-telescope/telescope-frecency.nvim",
        -- install the latest stable version
        version = "*",
        config = function()
            require("telescope").load_extension "frecency"
        end,
    },
    'kevinhwang91/nvim-bqf',
    'tpope/vim-surround',
    { 'simnalamburt/vim-mundo', cmd = 'MundoToggle' },
    'stefandtw/quickfix-reflector.vim',

    -- languages
    --{ 'Vigemus/iron.nvim' },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            "rescript-lang/tree-sitter-rescript"
        },
        build = ':TSUpdate',
        config = function()
            local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
            parser_config.rescript = {
                install_info = {
                    url = "https://github.com/rescript-lang/tree-sitter-rescript",
                    branch = "main",
                    files = { "src/scanner.c" },
                    generate_requires_npm = false,
                    requires_generate_from_grammar = true,
                    use_makefile = true, -- macOS specific instruction
                },
            }
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "cmake",
                    "css",
                    "csv",
                    "diff",
                    "dockerfile",
                    "elixir",
                    "git_config",
                    "git_rebase",
                    "gitcommit",
                    "gitignore",
                    "go",
                    "haskell",
                    "html",
                    "java",
                    "javascript",
                    "jsdoc",
                    "json",
                    "json5",
                    "lua",
                    "make",
                    "markdown",
                    "markdown_inline",
                    "ocaml",
                    "python",
                    "query",
                    "rescript",
                    "ruby",
                    "rust",
                    "scala",
                    "sql",
                    "toml",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "yaml",
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            completions = { blink = { enabled = true} },
            code = { disable_background = true, language = false },
            heading = { width = 'block' }
        },
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {},
        config = function()
            require("typescript-tools").setup({
                --capabilities = require('cmp_nvim_lsp').default_capabilities(),
                root_dir = function(startpath)
                    return require('lspconfig.util').root_pattern("package.json")(startpath)
                end,
                settings = {
                    -- spawn additional tsserver instance to calculate diagnostics on it
                    separate_diagnostic_server = true,
                    -- "change"|"insert_leave" determine when the client asks the server about diagnostic
                    publish_diagnostic_on = "insert_leave",
                    -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
                    -- "remove_unused_imports"|"organize_imports") -- or string "all"
                    -- to include all supported code actions
                    -- specify commands exposed as code_actions
                    expose_as_code_action = {},
                    -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
                    -- not exists then standard path resolution strategy is applied
                    tsserver_path = nil,
                    -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
                    -- (see 💅 `styled-components` support section)
                    tsserver_plugins = {
                        "@monodon/typescript-nx-imports-plugin",
                    },
                    -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
                    -- memory limit in megabytes or "auto"(basically no limit)
                    tsserver_max_memory = "auto",
                    -- described below
                    tsserver_format_options = { },
                    tsserver_file_preferences = {},
                    -- locale of all tsserver messages, supported locales you can find here:
                    -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
                    tsserver_locale = "en",
                    -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
                    complete_function_calls = false,
                    include_completions_with_insert_text = true,
                    -- CodeLens
                    -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
                    -- possible values: ("off"|"all"|"implementations_only"|"references_only")
                    code_lens = "off",
                    -- by default code lenses are displayed on all referencable values and for some of you it can
                    -- be too much this option reduce count of them by removing member references from lenses
                    disable_member_code_lens = true,
                    -- JSXCloseTag
                    -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-auto-tag,
                    -- that maybe have a conflict if enable this feature. )
                    jsx_close_tag = {
                        enable = false,
                        filetypes = { "javascriptreact", "typescriptreact" },
                    }
                },
            })
        end
    },
    --'leafgarland/typescript-vim',
    'MaxMEllon/vim-jsx-pretty',

    -- LSP
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'saghen/blink.cmp' },
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            vim.lsp.config('gopls', {
                cmd = { 'gopls' },
                filetypes = { 'go', 'gomod' },
                root_markers = { 'go.mod', '.git' },
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                        },
                        staticcheck = true,
                    },
                }
            })

            vim.lsp.config('lua_ls', {
                on_init = function(client)
                    if not client.workspace_folders or not client.workspace_folders[1] then
                        return true
                    end
                    local path = client.workspace_folders[1].name
                    if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                        client.config.settings = vim.tbl_deep_extend('force', client.config.settings or {}, {
                            Lua = {
                                runtime = {
                                    version = 'LuaJIT'
                                },
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        vim.env.VIMRUNTIME
                                    }
                                }
                            }
                        })

                        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                    end
                    return true
                end,
            })

            vim.lsp.config('eslint', {
                cmd = { 'vscode-eslint-language-server', '--stdio' },
                filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
                root_markers = { '.eslintrc', '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.json', '.eslintrc.yaml', '.eslintrc.yml', 'eslint.config.js', 'eslint.config.mjs', 'eslint.config.cjs', 'package.json' },
                settings = {
                    workingDirectories = { mode = 'auto' },
                },
            })

            -- Enable the LSP servers
            vim.lsp.enable('gopls')
            vim.lsp.enable('lua_ls')
            vim.lsp.enable('eslint')
        end
    },
    'ckipp01/stylua-nvim',
    'elzr/vim-json',
    'folke/noice.nvim',
    --{
    --    'rust-lang/rust.vim',
    --    config = function()
    --        vim.g.rustfmt_autosave = 1
    --    end
    --},
    --{
    --    'mrcjkb/rustaceanvim',
    --    version = '^4', -- Recommended
    --    lazy = false, -- This plugin is already lazy
    --},
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true },
    'tpope/vim-dadbod',
    'kristijanhusak/vim-dadbod-completion',
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod', lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },

    -- autocomplete
    {
        'saghen/blink.cmp',
        lazy = false, -- lazy loading handled internally
        -- optional: provides snippets for the snippet source
        dependencies = 'rafamadriz/friendly-snippets',

        -- use a release tag to download pre-built binaries
        version = 'v0.*',
        -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- see the "default configuration" section below for full documentation on how to define
            -- your own keymap.
            keymap = {
                preset = 'enter',
                ['<Tab>'] = {
                    function(cmp)
                        if cmp.snippet_active() then return cmp.snippet_forward()
                        elseif require('blink.cmp.completion.windows.menu').win:is_open() then return cmp.select_next()
                        end
                    end,
                    'fallback'
                },
                ['<S-Tab>'] = {
                    function(cmp)
                        if cmp.snippet_active() then return cmp.snippet_backward()
                        elseif require('blink.cmp.completion.windows.menu').win:is_open() then return cmp.select_prev()
                        end
                    end,
                    'fallback'
                },
            },

            completion = {
                keyword = {
                    range = 'full',
                },
                list = {
                    selection = { preselect = false, auto_insert = false },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
                ghost_text = {
                    enabled = true,
                },
                trigger = { prefetch_on_insert = false },
            },

            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, via `opts_extend`
            sources = {
                default = { 'lsp', 'buffer', 'path', 'snippets' },
                -- optionally disable cmdline completions
                -- cmdline = {},
                per_filetype = {
                    sql = { 'snippets', 'dadbod', 'buffer' },
                },

                providers = {
                    parrot = {
                        module = "parrot.completion.blink",
                        name = "parrot",
                        score_offset = 20,
                        opts = {
                            show_hidden_files = false,
                            max_items = 50,
                        }
                    },
                    dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
                },
            },

            -- experimental signature help support
            signature = { enabled = true }
        },
        -- allows extending the providers array elsewhere in your config
        -- without having to redefine it
        opts_extend = { "sources.default" }
    },
    -- AI
    {
        "ravitemer/mcphub.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",  -- Required for Job and HTTP requests
        },
        -- uncomment the following line to load hub lazily
        --cmd = "MCPHub",  -- lazy load 
        build = "npm install -g mcp-hub@latest",  -- Installs required mcp-hub npm module
        -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
        -- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
        config = function()
            require("mcphub").setup()
        end,
    },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            --"hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
            "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
            { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } }, -- Optional: For prettier markdown rendering
            { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves `vim.ui.select`
            {
                "saghen/blink.cmp",
                lazy = false,
                version = "*",
            }
        },
        config = true,
        opts = {
            extensions = {
                mcphub = {
                    callback = "mcphub.extensions.codecompanion",
                    opts = {
                        show_result_in_chat = true, -- Show the mcp tool result in the chat buffer
                        make_vars = true, -- make chat #variables from MCP server resources
                        make_slash_commands = true, -- make /slash_commands from MCP server prompts
                    },
                }
            }
        }
    },
})
require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")

-- Configure borders for LSP floating windows
vim.o.winborder = 'rounded'

local code_companion = require("codecompanion")
code_companion.setup({
    strategies = {
        chat = {
            adapter = 'anthropic'
        },
        inline = {
            adapter = 'anthropic'
        }
    },
    prompt_library = {
        ["senior"] = {
            strategy = "chat",
            description = "Get help from a senior developer",
            opts = {
                is_slash_cmd = true,
                short_name = "senior",
            },
            references = {},
            prompts = {
                {
                    role = "user",
                    content = [[
When writing code, it's important to keep in mind the following:
- Take into account: Open-closed principle, Clean code principles, SOLID principles, Composition over Inheritance, DRY, KISS, YAGNI.
- Where it makes sense, use design patterns, such as: Factory, Builder, Adapter, Decorator, Observer, Strategy, Command, Visitor, etc.
- Prefer 'tell, don't ask' and 'command-query separation'.
]]
                }
            }
        }
    }
})
map("n", "<leader>cc", code_companion.actions)

--local capabilities = require('cmp_nvim_lsp').default_capabilities
local configs = require('lspconfig.configs')

--local cmp = require("cmp")
--
--cmp.setup.cmdline({ '/', '?' }, {
--    mapping = cmp.mapping.preset.cmdline(),
--    sources = {
--        { name = 'buffer' }
--    },
--    view = {
--        entries = { name = 'custom' }
--    },
--})
--
--cmp.setup.cmdline({ ':' }, {
--    mapping = cmp.mapping.preset.cmdline(),
--    sources = cmp.config.sources({
--        { name = 'path' }
--    }, {
--            { name = 'cmdline' }
--        }),
--    view = {
--        entries = { name = 'custom' }
--    },
--})

-- gopls config moved to vim.lsp.config() + vim.lsp.enable() in nvim-lspconfig plugin block

--if not configs.tsserver then
--   configs.tsserver = {
--      default_config = {
--         cmd = { 'typescript-language-server', '--stdio' },
--         filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'javascriptreact', 'javascript.jsx' },
--         root_dir = lspconfig.util.find_git_ancestor,
--         settings = {
--            tsserver_plugins = {  "@monodon/typescript-nx-imports-plugin" },
--         },
--         capabilities = capabilities,
--      }
--   }
--end
--lspconfig['tsserver'].setup {}

--lspconfig['rust_analyzer'].setup({
--   on_attach = function(client, bufnr)
--      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
--   end,
--   settings = {
--      ["rust-analyzer"] = {
--         imports = {
--            granularity = {
--               group = "module",
--            },
--            prefix = "self",
--         },
--         cargo = {
--            buildScripts = {
--               enable = true,
--            },
--         },
--         procMacro = {
--            enable = true
--         },
--      }
--   }
--})

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
    group = vim.api.nvim_create_augroup('MyAutocmdsJavaScripFormatting', {}),
    callback = function()
        vim.lsp.buf.code_action({
            context = { only = { 'source.fixAll.eslint' } },
            apply = true,
        })
    end,
})

-- LSP mappings
map("n", "<leader>ld", vim.lsp.buf.definition)
map("n", "<leader>ly", vim.lsp.buf.type_definition)
map("n", "<leader>lt", vim.lsp.buf.hover)
map("n", "<leader>li", vim.lsp.buf.implementation)
map("n", "<leader>lR", vim.lsp.buf.references)
map("n", "<leader>lds", vim.lsp.buf.document_symbol)
map("n", "<leader>lws", vim.lsp.buf.workspace_symbol)
map("n", "<leader>lc", vim.lsp.codelens.run)
map("n", "<leader>sh", vim.lsp.buf.signature_help)
map("n", "<leader>lr", vim.lsp.buf.rename)
map("n", "<leader>f", vim.lsp.buf.format)
map("n", "<leader>la", vim.lsp.buf.code_action)
map("v", "<leader>la", vim.lsp.buf.code_action)

map("n", "<leader>ws", function()
    require("metals").hover_worksheet()
end)

-- all workspace diagnostics
map("n", "<leader>aa", vim.diagnostic.setqflist)

-- all workspace errors
map("n", "<leader>ae", function()
    vim.diagnostic.setqflist({ severity = "E" })
end)

-- all workspace warnings
map("n", "<leader>aw", function()
    vim.diagnostic.setqflist({ severity = "W" })
end)

-- buffer diagnostics only
map("n", "<leader>d", vim.diagnostic.setloclist)

map("n", "[c", function()
    vim.diagnostic.goto_prev({ wrap = false })
end)

map("n", "]c", function()
    vim.diagnostic.goto_next({ wrap = false })
end)

--
-- copilot
--
--vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")', {
--    expr = true,
--    replace_keycodes = false
--})
--vim.g.copilot_no_tab_map = true
--vim.keymap.set('i', '<C-x>', '<Plug>(copilot-dismiss)')
--vim.keymap.set('i', '<C-]>', '<Plug>(copilot-next)')
--vim.keymap.set('i', '<C-[>', '<Plug>(copilot-previous)')
--vim.keymap.set('i', '<C-l>', '<Plug>(copilot-accept-word)')
--vim.keymap.set('n', '<M-CR>', ':Copilot panel<CR>')

--
-- set up iron
--
--local iron = require("iron.core")
--
--iron.setup {
--    config = {
--        -- Whether a repl should be discarded or not
--        scratch_repl = true,
--        -- Your repl definitions come here
--        repl_definition = {
--            sh = {
--                -- Can be a table or a function that
--                -- returns a table (see below)
--                command = { "zsh" }
--            }
--        },
--        -- How the repl window will be displayed
--        -- See below for more information
--        repl_open_cmd = require('iron.view').bottom(40),
--    },
--    -- Iron doesn't set keymaps by default anymore.
--    -- You can set them here or manually add keymaps to the functions in iron.core
--    keymaps = {
--        send_motion = "<space>sc",
--        visual_send = "<space>sc",
--        send_file = "<space>sf",
--        send_line = "<space>sl",
--        send_until_cursor = "<space>su",
--        send_mark = "<space>sm",
--        mark_motion = "<space>mc",
--        mark_visual = "<space>mc",
--        remove_mark = "<space>md",
--        cr = "<space>s<cr>",
--        interrupt = "<space>s<space>",
--        exit = "<space>sq",
--        clear = "<space>cl",
--    },
--    -- If the highlight is on, you can change how it looks
--    -- For the available options, check nvim_set_hl
--    highlight = {
--        italic = true
--    },
--    ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
--}
--
---- iron also has a list of commands, see :h iron-commands for all available commands
--vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
--vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
--vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
--vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')

-- Hop maps {{{
local hop = require("hop")
local directions = require("hop.hint").HintDirection
local hint_position = require("hop.hint").HintPosition
vim.keymap.set({ "n", "v", "o" }, "<leader><leader>k", function()
    hop.hint_lines_skip_whitespace({ direction = directions.BEFORE_CURSOR })
end, { silent = true })
vim.keymap.set({ "n", "v", "o" }, "<leader><leader>j", function()
    hop.hint_lines_skip_whitespace({ direction = directions.AFTER_CURSOR })
end, { silent = true })
vim.keymap.set({ "n", "v", "o" }, "<leader><leader>s", function()
    hop.hint_patterns({})
end, { silent = true })
vim.keymap.set({ "n", "v", "o" }, "<leader><leader>w", function()
    hop.hint_words({ direction = directions.AFTER_CURSOR })
end, { silent = true })
vim.keymap.set({ "n", "v", "o" }, "<leader><leader>b", function()
    hop.hint_words({ direction = directions.BEFORE_CURSOR })
end, { silent = true })
vim.keymap.set({ "n", "v", "o" }, "<leader><leader>e", function()
    hop.hint_words({ direction = directions.AFTER_CURSOR, hint_position = hint_position.END })
end, { silent = true })
vim.keymap.set({ "n", "v", "o" }, "<leader><leader>ge", function()
    hop.hint_words({ direction = directions.BEFORE_CURSOR, hint_position = hint_position.END })
end, { silent = true })
vim.keymap.set({ "n", "v", "o" }, "<leader><leader>f", function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { silent = true })
vim.keymap.set({ "n", "v", "o" }, "<leader><leader>F", function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { silent = true })
vim.keymap.set({ "n", "v", "o" }, "<leader><leader>t", function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, hint_offset = -1, current_line_only = true })
end, { silent = true })
vim.keymap.set({ "n", "v", "o" }, "<leader><leader>T", function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, hint_offset = -1, current_line_only = true })
end, { silent = true })
-- }}}

-- FZF {{{
vim.keymap.set("n", "[File]r", "<cmd>Telescope resume<CR>", { silent = true })
vim.keymap.set("n", "[File]R", "<cmd>Telescope registers<CR>", { silent = true })
vim.keymap.set("n", "[File]f", "<cmd>Telescope find_files<CR>", { silent = true })
vim.keymap.set("n", "[File]b", "<cmd>Telescope buffers<CR>", { silent = true })
vim.keymap.set("n", "[File]h", "<cmd>Telescope oldfiles<CR>", { silent = true })
vim.keymap.set("n", "[File]H", "<cmd>Telescope helptags<CR>", { silent = true })
vim.keymap.set("n", "[File]c", "<cmd>Telescope git_bcommits<CR>", { silent = true })
vim.keymap.set("n", "[File]C", "<cmd>Telescope git_commits<CR>", { silent = true })

vim.keymap.set("n", "[File]g", "<cmd>Telescope live_grep<CR>", { silent = true })
vim.keymap.set("n", "<leader>gg", "<cmd>Telescope grep_string<CR>", { silent = true })
vim.keymap.set("v", "<leader>gg", "<cmd>Telescope grep_string<CR>", { silent = true })
vim.keymap.set("n", "[File]l", "<cmd>Telescope currecnt_buffer_fuzzy_find<CR>", { silent = true })

vim.keymap.set("n", "[File]q", "<cmd>Telescope quickfix<CR>", { silent = true })
vim.keymap.set("n", "[File]Q", "<cmd>Telescope quickfixhistory<CR>", { silent = true })

--let g:fzf_action = {
--  \ 'ctrl-q': function('s:build_quickfix_list'),
--  \ 'ctrl-t': 'tab split',
--  \ 'ctrl-x': 'split',
--  \ 'ctrl-v': 'vsplit' }
-- }}}

-- vsnip {{{
vim.keymap.set("i", "<c-k>", "<Plug>(vsnip-expand-or-jump)", { silent = true })
vim.keymap.set("s", "<c-k>", "<Plug>(vsnip-expand-or-jump)", { silent = true })
vim.keymap.set("i", "<c-s-k>", "<Plug>(vsnip-jump-prev)", { silent = true })
-- }}}

-- highlights {{{
vim.api.nvim_set_hl(0, 'WinSeparator', { bg='#1e1e2f', fg='SlateBlue' })
-- }}}

-- cursorline {{{
local cursorline_group = vim.api.nvim_create_augroup('CursorLineByFiletype', { clear = true })
vim.api.nvim_set_hl(0, 'CursorLine', { bold = true })
vim.opt.cursorline = false

vim.api.nvim_create_autocmd('FileType', {
    group = cursorline_group,
    pattern = { 'fugitive' },  -- Add filetypes as needed
    callback = function()
        vim.opt_local.cursorline = true
    end,
})

vim.api.nvim_create_autocmd('BufEnter', {
    group = cursorline_group,
    callback = function()
        local buftype = vim.bo.buftype
        -- Enable for non-file buffers (quickfix, help, etc.)
        if buftype == 'quickfix' or buftype == 'help' then
            vim.opt_local.cursorline = true
        end
    end,
})
-- }}}
