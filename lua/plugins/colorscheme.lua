return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "moegi",
    },
  },
  {
    "inogai/moegi.nvim",
    dir = os.getenv("HOME") .. "/Workspaces/moegi.nvim",
    dependencies = {
      "rktjmp/lush.nvim",
    },
    priority = 999,
  },
  {
    "ellisonleao/gruvbox.nvim",
  },
}
