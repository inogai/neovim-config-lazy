-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

map({ "i", "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map({ "i", "x", "n", "s" }, "<F2>", vim.lsp.buf.rename, { desc = "Rename Symbol" })

local command = vim.api.nvim_create_user_command

command("Gcommit", function()
  pcall(function()
    local Terminal = require("toggleterm.terminal").Terminal

    Terminal:new({
      cmd = "git commit",
      dir = LazyVim.root(),
      close_on_exit = true,
      on_exit = function(_, _, exit_code)
        if exit_code == 0 then
          vim.cmd("DiffviewRefresh")
        end
      end,
      on_stderr = function(_, _, data)
        if data then
          vim.notify(vim.fn.join(data, "\n"), vim.log.levels.ERROR)
        end
      end,
    }):open()

    vim.cmd("DiffviewRefresh")
  end)
end, {})
