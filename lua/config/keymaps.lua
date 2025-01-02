-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

map({ "i", "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map({ "i", "c" }, "<D-v>", "<C-r>+", { desc = "Paste" })
map({ "t" }, "<D-v>", '<C-\\><C-o>"+p', { desc = "Paste" })

map({ "i", "x", "n", "s" }, "<F2>", vim.lsp.buf.rename, { desc = "Rename Symbol" })

map({ "t" }, "<Esc><Esc>", "<C-\\><C-N>")

vim.keymap.set("x", "p", function()
  return 'pgv"' .. vim.v.register .. "y"
end, { remap = false, expr = true })
