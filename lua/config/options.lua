-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = false

vim.g.root_spec = { "lsp", { ".git", "lua", ".obsidian" }, "cwd" }

vim.g.lazyvim_python_lsp = "basedpyright"
