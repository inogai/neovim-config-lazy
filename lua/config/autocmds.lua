-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local autocmd = vim.api.nvim_create_autocmd

require("config.snippets.mini-files_git_integration")

vim.api.nvim_set_hl(0, "MyMutableVariableHighlight", {
  underline = true,
})

autocmd("LspTokenUpdate", {
  callback = function(args)
    local token = args.data.token

    if token.type == "variable" and not token.modifiers.readonly then
      vim.lsp.semantic_tokens.highlight_token(token, args.buf, args.data.client_id, "MyMutableVariableHighlight")
    end
  end,
})

autocmd("BufEnter", {
  callback = function(args)
    if vim.bo[args.buf].buftype == "nofile" then
      return
    end

    local cwd = LazyVim.root(args.buf)

    if not vim.fn.isdirectory(cwd) then
      return
    end

    local current_cwd = vim.fn.getcwd()

    if cwd == current_cwd or cwd == current_cwd .. "/" then
      return
    end

    LazyVim.info("cwd: " .. cwd)
    vim.api.nvim_set_current_dir(cwd)
  end,
})
