local map = vim.keymap.set

vim.g.mapleader = " "
vim.opt.laststatus = 3

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
    'vim-airline/vim-airline',
    'nvim-tree/nvim-web-devicons',

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
    'junegunn/fzf.vim',
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- calling `setup` is optional for customization
            require("fzf-lua").setup({})
        end
    },
    'kevinhwang91/nvim-bqf',
    'tpope/vim-surround',
    { 'simnalamburt/vim-mundo', cmd = 'MundoToggle' },
    'stefandtw/quickfix-reflector.vim',
    'anuvyklack/hydra.nvim',
    { 'jbyuki/venn.nvim',       config = function() require('venn') end },

    -- languages
    { 'Vigemus/iron.nvim' },
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
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {},
        config = function()
            local lspconfig = require('lspconfig')
            require("typescript-tools").setup({
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
                root_dir = lspconfig.util.find_git_ancestor,
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
                    tsserver_format_options = {},
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
    },
    'ckipp01/stylua-nvim',
    'elzr/vim-json',
    'github/copilot.vim',
    --{
    --   'Exafunction/codeium.vim',
    --   config = function()
    --      vim.keymap.set('i', '<C-enter>', function() return vim.fn['codeium#Accept']() end, { expr = true })
    --      vim.keymap.set('i', '<c-]>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
    --      vim.keymap.set('i', '<c-[>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
    --      vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    --   end
    --},
    {
        "scalameta/nvim-metals",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "mfussenegger/nvim-dap",
                config = function(self, opts)
                    -- Debug settings if you're using nvim-dap
                    local dap = require("dap")

                    dap.configurations.scala = {
                        {
                            type = "scala",
                            request = "launch",
                            name = "RunOrTest",
                            metals = {
                                runType = "runOrTestFile",
                                --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
                            },
                        },
                        {
                            type = "scala",
                            request = "launch",
                            name = "Test Target",
                            metals = {
                                runType = "testTarget",
                            },
                        },
                    }
                end
            },
        },
        ft = { "scala", "sbt", "java" },
        opts = function()
            local metals_config = require("metals").bare_config()

            -- Example of settings
            metals_config.settings = {
                showImplicitArguments = true,
                excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
            }

            -- *READ THIS*
            -- I *highly* recommend setting statusBarProvider to true, however if you do,
            -- you *have* to have a setting to display this in your statusline or else
            -- you'll not see any messages from metals. There is more info in the help
            -- docs about this
            -- metals_config.init_options.statusBarProvider = "on"

            -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
            metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

            metals_config.on_attach = function(client, bufnr)
                require("metals").setup_dap()

                -- Example mappings for usage with nvim-dap. If you don't use that, you can
                -- skip these
                map("n", "<leader>dc", function()
                    require("dap").continue()
                end)

                map("n", "<leader>dr", function()
                    require("dap").repl.toggle()
                end)

                map("n", "<leader>dK", function()
                    require("dap.ui.widgets").hover()
                end)

                map("n", "<leader>dt", function()
                    require("dap").toggle_breakpoint()
                end)

                map("n", "<leader>dso", function()
                    require("dap").step_over()
                end)

                map("n", "<leader>dsi", function()
                    require("dap").step_into()
                end)

                map("n", "<leader>dl", function()
                    require("dap").run_last()
                end)
            end

            return metals_config
        end,
        config = function(self, metals_config)
            local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = self.ft,
                callback = function()
                    require("metals").initialize_or_attach(metals_config)
                end,
                group = nvim_metals_group,
            })
        end
    },
    {
        'rust-lang/rust.vim',
        config = function()
            vim.g.rustfmt_autosave = 1
        end
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        lazy = false, -- This plugin is already lazy
    },
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

    -- autocomplete
    {
        'madox2/vim-ai',
        config = function()
            vim.g.vim_ai_chat = { options = { model = "gpt-4-turbo-preview" } }
        end
    },
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-vsnip" },
            { "hrsh7th/vim-vsnip" }
        },
        opts = function()
            local cmp = require("cmp")
            local conf = {
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "vsnip" },
                    --{ name = "codeium" }
                }, { name = "buffer" }),
                snippet = {
                    expand = function(args)
                        -- Comes from vsnip
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    -- None of this made sense to me when first looking into this since there
                    -- is no vim docs, but you can't have select = true here _unless_ you are
                    -- also using the snippet stuff. So keep in mind that if you remove
                    -- snippets you need to remove this select
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    -- I use tabs... some say you should stick to ins-completion but this is just here as an example
                    ["<Tab>"] = function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end,
                    ["<S-Tab>"] = function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end,
                }),
            }
            return conf
        end
    },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

local cmp = require("cmp")

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    },
    view = {
        entries = { name = 'custom' }
    },
})

cmp.setup.cmdline({ ':' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
    view = {
        entries = { name = 'custom' }
    },
})

if not configs.gopls then
    configs.gopls = {
        default_config = {
            cmd = { 'gopls' },
            filetypes = { 'go', 'gomod' },
            root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                        shadow = true,
                    },
                    staticcheck = true,
                },
            }
        }
    }
end
lspconfig['gopls'].setup {}

lspconfig['eslint'].setup {}

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

lspconfig['lua_ls'].setup {
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using
                        -- (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT'
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME
                            -- "${3rd}/luv/library"
                            -- "${3rd}/busted/library",
                        }
                        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                        -- library = vim.api.nvim_get_runtime_file("", true)
                    }
                }
            })

            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
        return true
    end,
    command = {
        Format = { function() require('stylua-nvim').format_file() end }
    }
}

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
    command = 'silent! EslintFixAll',
    group = vim.api.nvim_create_augroup('MyAutocmdsJavaScripFormatting', {}),
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
--map("n", "<leader>la", vim.lsp.buf.code_action)
--map("v", "<leader>la", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>la", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", { silent = true })
vim.keymap.set("v", "<leader>la", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", { silent = true })

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
vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false
})
vim.g.copilot_no_tab_map = true
vim.keymap.set('i', '<C-x>', '<Plug>(copilot-dismiss)')
vim.keymap.set('i', '<C-]>', '<Plug>(copilot-next)')
vim.keymap.set('i', '<C-[>', '<Plug>(copilot-previous)')
vim.keymap.set('i', '<C-l>', '<Plug>(copilot-accept-word)')

--
-- set up iron
--
local iron = require("iron.core")

iron.setup {
    config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        -- Your repl definitions come here
        repl_definition = {
            sh = {
                -- Can be a table or a function that
                -- returns a table (see below)
                command = { "zsh" }
            }
        },
        -- How the repl window will be displayed
        -- See below for more information
        repl_open_cmd = require('iron.view').bottom(40),
    },
    -- Iron doesn't set keymaps by default anymore.
    -- You can set them here or manually add keymaps to the functions in iron.core
    keymaps = {
        send_motion = "<space>sc",
        visual_send = "<space>sc",
        send_file = "<space>sf",
        send_line = "<space>sl",
        send_until_cursor = "<space>su",
        send_mark = "<space>sm",
        mark_motion = "<space>mc",
        mark_visual = "<space>mc",
        remove_mark = "<space>md",
        cr = "<space>s<cr>",
        interrupt = "<space>s<space>",
        exit = "<space>sq",
        clear = "<space>cl",
    },
    -- If the highlight is on, you can change how it looks
    -- For the available options, check nvim_set_hl
    highlight = {
        italic = true
    },
    ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

-- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')

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
vim.keymap.set("n", "[File]r", "<cmd>lua require('fzf-lua').resume()<CR>", { silent = true })
vim.keymap.set("n", "[File]R", "<cmd>lua require('fzf-lua').registers()<CR>", { silent = true })
vim.keymap.set("n", "[File]f", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
vim.keymap.set("n", "[File]b", "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
vim.keymap.set("n", "[File]h", "<cmd>lua require('fzf-lua').oldfiles()<CR>", { silent = true })
vim.keymap.set("n", "[File]H", "<cmd>lua require('fzf-lua').helptags()<CR>", { silent = true })
vim.keymap.set("n", "[File]c", "<cmd>lua require('fzf-lua').git_bcommits()<CR>", { silent = true })
vim.keymap.set("n", "[File]C", "<cmd>lua require('fzf-lua').git_commits()<CR>", { silent = true })

vim.keymap.set("n", "[File]g", "<cmd>lua require('fzf-lua').grep()<CR>", { silent = true })
vim.keymap.set("n", "<leader>gg", "<cmd>lua require('fzf-lua').grep_cword()<CR>", { silent = true })
vim.keymap.set("v", "<leader>gg", "<cmd>lua require('fzf-lua').grep_visual()<CR>", { silent = true })
vim.keymap.set("n", "[File]l", "<cmd>lua require('fzf-lua').blines()<CR>", { silent = true })
vim.keymap.set("n", "[File]L", "<cmd>lua require('fzf-lua').lines()<CR>", { silent = true })

vim.keymap.set("n", "[File]q", "<cmd>lua require('fzf-lua').quickfix()<CR>", { silent = true })
vim.keymap.set("n", "[File]Q", "<cmd>lua require('fzf-lua').quickfix_stack()<CR>", { silent = true })

--let g:fzf_action = {
--  \ 'ctrl-q': function('s:build_quickfix_list'),
--  \ 'ctrl-t': 'tab split',
--  \ 'ctrl-x': 'split',
--  \ 'ctrl-v': 'vsplit' }
-- }}}
