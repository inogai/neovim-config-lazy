return {
  -- requires tinymist
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "tinymist",
      },
    },
  },
  -- add tinymist to lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        tinymist = {
          --- todo: these configuration from lspconfig maybe broken
          single_file_support = true,
          root_dir = function()
            return vim.fn.getcwd()
          end,
          --- See [Tinymist Server Configuration](https://github.com/Myriad-Dreamin/tinymist/blob/main/Configuration.md) for references.
          settings = {},
        },
      },
    },
  },
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "1.*",
    opts = {
      dependencies_bin = { ["tinymist"] = "tinymist" },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        typst = { "typstyle" },
      },
      formatter = {
        typstyle = {
          prepend_arg = {
            "-c",
            "60",
          },
        },
      },
    },
  },
}