-- Neovim Configuration
-- Pure Lua rewrite - December 2025

-- Enable faster loading
vim.loader.enable()

-- Set leader keys before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Load configuration modules
require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
