-- This file specifies the disabled plugins for vscode-neovim.
-- For other configurations, use lua/config/*.lua
if vim.g.vscode then
  return {
    {
      "inogai/indent-blankline.nvim",
      enabled = false,
    },
    {
      "echasnovski/mini.indentscope",
      enabled = false,
    },
    {
      "inogai/ultimate-autopair.nvim",
      enabled = false,
    },
    {
      "HiPhish/rainbow-delimiters.nvim",
      enabled = false,
    },
    {
      "nvim-lspconfig",
      enabled = false,
    },
    {
      "hrsh7th/nvim-cmp",
      enabled = false,
    },
    {
      "gorbit99/codewindow.nvim",
      enabled = false,
    },
  }
end

return {}
