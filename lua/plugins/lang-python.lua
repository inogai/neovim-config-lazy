return {
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python", --optional
    },
    ft = "python",
    branch = "regexp", -- This is the regexp branch, use this for the new version
    opts = {
      settings = {
        search = {
          root_venv = {
            command = "fd /bin/python$ ~/.venv --full-path -d2 -I",
          },
        },
      },
    },
  },
}
