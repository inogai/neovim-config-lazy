-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = true

local function parent_dir_detector(bufnr)
  local bufname = vim.fn.bufname(bufnr)
  return vim.fn.fnamemodify(bufname, ":h")
end

---@type LazyRootSpec[]
vim.g.root_spec = {
  ".obsidian",
  "lsp",
  { ".git", "lua" },
  parent_dir_detector,
  "cwd",
}

vim.g.lazyvim_python_lsp = "basedpyright"

if vim.g.vscode then
  vim.g.lazyvim_python_lsp = "disabled"
  vim.g.lazyvim_python_ruff = "disabled"
end

-- Enable the option to require a Prettier config file
-- If no prettier config file is found, the formatter will not be used
vim.g.lazyvim_prettier_needs_config = true
