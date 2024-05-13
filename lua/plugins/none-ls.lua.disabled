return {
  {
    "nvimtools/none-ls.nvim",

    dependencies = {
      "gbprod/none-ls-shellcheck.nvim",
    },

    opts = function(_, opts)
      local null_ls = require("null-ls")

      opts.sources = vim.list_extend(opts.sources or {}, {
        null_ls.builtins.formatting.stylua,
        require("none-ls-shellcheck.diagnostics"),
        require("none-ls-shellcheck.code_actions"),
      })
    end,
  },
}
