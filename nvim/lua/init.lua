local map = vim.keymap.set

vim.g.mapleader = " "

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

   -- movement
   'easymotion/vim-easymotion',
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
   'tpope/vim-surround',
   { 'simnalamburt/vim-mundo', cmd = 'MundoToggle' },
   'stefandtw/quickfix-reflector.vim',
   'anuvyklack/hydra.nvim',
   { 'jbyuki/venn.nvim', config = function() require('venn') end },

   -- languages
   'leafgarland/typescript-vim',
   'MaxMEllon/vim-jsx-pretty',

   -- LSP
   {
      'neovim/nvim-lspconfig',
   },
   'ckipp01/stylua-nvim',
   'elzr/vim-json',
   {
      'Exafunction/codeium.vim',
      config = function()
         vim.keymap.set('i', '<C-enter>', function() return vim.fn['codeium#Accept']() end, { expr = true })
         vim.keymap.set('i', '<c-]>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
         vim.keymap.set('i', '<c-[>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
         vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
      end
   },
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

   -- autocomplete
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
               { name = "codeium" }
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
local nvim_lsp = require('lspconfig')

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

nvim_lsp['gopls'].setup {
   cmd = { 'gopls' },
   -- on_attach = on_attach,
   capabilities = capabilities,
   settings = {
      gopls = {
         analyses = {
            unusedparams = true,
            shadow = true,
         },
         staticcheck = true,
      },
   },
   init_options = {
      usePlaceholders = true,
   }
}

nvim_lsp['eslint'].setup {}
nvim_lsp['tsserver'].setup {
   cmd = { 'typescript-language-server', '--stdio' },
   capabilities = capabilities,
}

nvim_lsp['lua_ls'].setup {
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
map("n", "<leader>la", vim.lsp.buf.code_action)

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
