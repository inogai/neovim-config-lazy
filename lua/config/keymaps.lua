-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

map({ "i", "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map({ "i", "x", "n", "s" }, "<D-v>", "<cmd>p<cr><esc>", { desc = "Paste" })
map({ "i", "x", "n", "s" }, "<F2>", vim.lsp.buf.rename, { desc = "Rename Symbol" })

vim.keymap.set("x", "p", function()
  return 'pgv"' .. vim.v.register .. "y"
end, { remap = false, expr = true })

vim.keymap.del("n", "<C-K>")
