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

-- source: @lukasx_ https://www.reddit.com/r/neovim/comments/1dymqgv/open_dashboard_after_last_buffer_has_been_closed
autocmd("BufDelete", {
  callback = function()
    local buffers = vim.api.nvim_list_bufs()
    local actual = {}

    -- Filter out nofile buffers created by plugins
    for i = 1, #buffers, 1 do
      local current = buffers[i]
      local buftype = vim.bo[current].buftype

      if buftype ~= "nofile" then
        table.insert(actual, current)
      end
    end

    -- Return if theres more than 1 buffer
    -- For some reason I see 1 extra buffer, so I added one for this
    if #actual > 2 then
      return
    end

    -- Get name of last buffer
    -- And also this +1 too
    local last_buf = actual[2]
    local bufname = vim.api.nvim_buf_get_name(last_buf)

    if bufname == "" then
      vim.cmd("Dashboard")
    end
  end,
})
