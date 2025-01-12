return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    lazy = false,
    init = function()
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      vim.cmd([[
        hi default link UfoPreviewSbar PmenuSbar
        hi default link UfoPreviewThumb PmenuThumb
        hi default link UfoPreviewWinBar UfoFoldedBg
        hi default link UfoPreviewCursorLine Visual
        hi default link UfoFoldedEllipsis Comment
        hi default link UfoCursorFoldedLine CursorLine
      ]])
    end,
    opts = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
      for _, ls in ipairs(language_servers) do
        require("lspconfig")[ls].setup({
          capabilities = capabilities,
        })
      end

      return {}
    end,
    -- stylua: ignore
    keys = {
      { 'zz', function () require('ufo').openAllFolds() end, "Open All Folds" },
      { 'zz', function () require('ufo').closeAllFolds() end, "Close All Folds" },
    },
  },
}
