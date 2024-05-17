-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local autocmd = vim.api.nvim_create_autocmd

autocmd("User", {
  pattern = "DashboardLoaded",
  callback = function()
    vim.cmd("setlocal scrolloff=999")
    vim.cmd("setlocal mouse=")
  end,
})

autocmd("BufLeave", {
  pattern = "<buffer>",
  group = vim.api.nvim_create_augroup("dashboard_no_scroll", { clear = true }),
  callback = function(opts)
    if vim.bo[opts.buf].filetype ~= "dashboard" then
      return
    end
    vim.cmd("setlocal scrolloff=0")
    vim.cmd("setlocal mouse=a")
  end,
})

require("config.snippets.mini-files_git_integration")
