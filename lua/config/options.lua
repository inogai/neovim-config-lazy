-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = true

local function __diffview_detector_recursive(bufnr, depth)
  local bufname = vim.fn.bufname(bufnr)
  local is_diffview = string.match(bufname, "^diffview://")

  if is_diffview == nil then
    return {}
  end

  local git_root = string.match(bufname, "^diffview://(/.*)/%.git/")

  if git_root ~= nil and vim.fn.isdirectory(git_root) == 1 then
    return { git_root }
  end

  if depth ~= 0 then
    return {}
  end

  for _, other_bufnr in pairs(vim.api.nvim_list_bufs()) do
    -- NOTE: here we assumed that only one diffview is open at a time
    local ret = __diffview_detector_recursive(other_bufnr, 1)
    if next(ret) ~= nil then
      return ret
    end
  end
end

---@type LazyRootFn
local function diffview_detector(bufnr)
  return __diffview_detector_recursive(bufnr, 0)
end

---@type LazyRootSpec[]
vim.g.root_spec = { "lsp", { ".git", "lua", ".obsidian" }, diffview_detector, "cwd" }

vim.g.lazyvim_python_lsp = "basedpyright"

if vim.g.vscode then
  vim.g.lazyvim_python_lsp = "disabled"
  vim.g.lazyvim_python_ruff = "disabled"
end
