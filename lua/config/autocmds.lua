-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local autocmd = vim.api.nvim_create_autocmd

require("config.snippets.mini-files_git_integration")

autocmd("LspTokenUpdate", {
  callback = function(args)
    local token = args.data.token

    if token.type == "variable" and not token.modifiers.readonly then
      vim.lsp.semantic_tokens.highlight_token(token, args.buf, args.data.client_id, "MyMutableVariableHighlight")
    end
  end,
})

autocmd("BufEnter", {
  callback = function()
    LazyVim.info("cwd: " .. LazyVim.root())
    vim.api.nvim_set_current_dir(LazyVim.root())
  end,
})
