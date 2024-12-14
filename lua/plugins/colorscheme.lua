return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
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

    opts = {
      overrides = {
        SnacksDashboardIcon = { link = "Normal" },
        SnacksDashboardDesc = { link = "Conceal" },
      },
    },
  },
}
