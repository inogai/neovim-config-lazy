return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "moegi",
    },
  },
  {
    "inogai/moegi.nvim",
    dependencies = {
      "rktjmp/lush.nvim",
    },
    priority = 999,
  },
}
