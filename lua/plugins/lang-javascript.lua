return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = { eslint = {} },
      setup = {
        eslint = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "vtsls" or client.name == "volar" or client.name == "jsonls" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      local customizations = {
        --   { rule = "style/*", severity = "info", fixable = true },
        --   { rule = "format/*", severity = "info", fixable = true },
        --   { rule = "*-indent", severity = "info", fixable = true },
        --   { rule = "*-spacing", severity = "info", fixable = true },
        --   { rule = "*-spaces", severity = "info", fixable = true },
        --   { rule = "*-order", severity = "info", fixable = true },
        --   { rule = "*-dangle", severity = "info", fixable = true },
        --   { rule = "*-newline", severity = "info", fixable = true },
        --   { rule = "*quotes", severity = "info", fixable = true },
        --   { rule = "*semi", severity = "info", fixable = true },
      }

      local lspconfig = require("lspconfig")
      -- Enable eslint for all supported languages
      lspconfig.eslint.setup({
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
          "vue",
          "html",
          "markdown",
          "json",
          "jsonc",
          "yaml",
          "toml",
          "xml",
          "gql",
          "graphql",
          "astro",
          "svelte",
          "css",
          "less",
          "scss",
          "pcss",
          "postcss",
        },
        settings = {
          -- Silent the stylistic rules in you IDE, but still auto fix them
          rulesCustomizations = customizations,
        },
      })
    end,
    opts = {
      servers = {
        vtsls = {
          settings = {
            typescript = {
              preferences = {
                importModuleSpecifier = "non-relative",
                importModuleSpecifierEnding = "js",
              },
            },
          },
        },
      },
    },
  },
}
