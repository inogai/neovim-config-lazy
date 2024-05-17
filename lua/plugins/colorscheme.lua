return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  {
    "inogai/gruvbox.nvim",
    opts = function()
      return {
        bold = false,
      }
    end,
  },
}
