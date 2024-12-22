-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

map({ "i", "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map({ "i" }, "<D-v>", "<esc>pi", { desc = "Paste" })
map({ "t" }, "<D-v>", "<C-\\><C-n>pi", { desc = "Paste" })

map({ "i", "x", "n", "s" }, "<F2>", vim.lsp.buf.rename, { desc = "Rename Symbol" })

vim.keymap.set("x", "p", function()
  return 'pgv"' .. vim.v.register .. "y"
end, { remap = false, expr = true })

vim.keymap.del("n", "<C-K>")
