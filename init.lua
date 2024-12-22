vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    if vim.g.neovide then
      print("Neovide detected, setting focus")
      vim.defer_fn(function()
        vim.cmd("NeovideFocus")
      end, 500)
    end
  end,
})

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
