local M = require("plugins.compat-git.utils")

local M2 = {}

---@param line string
---@return string
function M2.extract_filename(line)
  local start = line:find("%s") or 1
  local terminal = line:find("%s", start + 1) or start
  terminal = line:find("%s", terminal + 1) or -1

  local ret = line:sub(start, terminal)
  return ret
end

---@param target string -  Target filename
---@return number | nil - an 1-based index of the 1st-matched line, or nil if not found
function M2.find_filename_line(target)
  local lines = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
  for i, line in ipairs(lines) do
    local cont = M2.extract_filename(line)
    if cont == target then
      return i
    end
  end

  return nil
end

function M2.toggle_stage_entry_follow()
  local actions = require("diffview.actions")
  local current_line = vim.api.nvim_get_current_line()
  local current_file = M2.extract_filename(current_line)
  actions.toggle_stage_entry()

  local timer = vim.uv.new_timer()
  if timer == nil then
    return
  end
  timer:start(
    100,
    0,
    vim.schedule_wrap(function()
      local line_nr = M2.find_filename_line(current_file)

      if line_nr ~= nil then
        vim.api.nvim_win_set_cursor(0, { line_nr, 1 })
        actions.select_entry()
      end
    end)
  )
end

return {
  "sindrets/diffview.nvim",

  opts = function()
    local actions = require("diffview.actions")
    local unpack = unpack or table.unpack

    local km = {
      { { "n" }, "q", "<Cmd>DiffviewClose<CR>", { desc = "[Q]uit Diffview" } },
      { { "n" }, "c", M.commit, { desc = "Git [C]ommit" } },
    }

    vim.api.nvim_set_hl(0, "MyDiffDeletedLines", { link = "NonText" })
    vim.api.nvim_set_hl(0, "MyDiffTextFrom", { bg = "#6d4443" })
    vim.api.nvim_set_hl(0, "MyDiffChangeFrom", { bg = "#4a3433" })
    vim.api.nvim_set_hl(0, "MyDiffTextTo", { bg = "#3a5247" })
    vim.api.nvim_set_hl(0, "MyDiffChangeTo", { bg = "#2e3b36" })

    return {
      enhanced_diff_hl = true,

      file_panel = {
        listing_style = "list",
        win_config = {
          width = 30,
        },
      },

      keymaps = {
        disable_defaults = false,
        view = {
          unpack(km),
        },
        file_panel = {
          { "n", "<down>", actions.select_next_entry },
          { "n", "<up>", actions.select_prev_entry },
          { "n", "j", actions.select_next_entry },
          { "n", "k", actions.select_prev_entry },
          { "n", "s", M2.toggle_stage_entry_follow, { desc = "Stage File" } },
          unpack(km),
        },
        file_history_panel = {
          unpack(km),
        },
      },

      hooks = {
        -- diff_buf_read = function()
        --   vim.opt_local.wrap = false
        -- end,
        ---@diagnostic disable-next-line: unused-local
        diff_buf_win_enter = function(bufnr, winid, ctx)
          -- Highlight 'DiffChange' as 'DiffDelete' on the left, and 'DiffAdd' on
          -- the right.
          if ctx.layout_name:match("^diff2") then
            if ctx.symbol == "a" then
              vim.opt_local.winhl = table.concat({
                "DiffAdd:MyDiffTextFrom",
                "DiffDelete:MyDiffDeletedLines",
                "DiffChange:MyDiffChangeFrom",
                "DiffText:MyDiffTextFrom",
              }, ",")
            elseif ctx.symbol == "b" then
              vim.opt_local.winhl = table.concat({
                "DiffAdd:MyDiffChangeTo",
                "DiffDelete:MyDiffDeletedLines",
                "DiffChange:MyDiffChangeTo",
                "DiffText:MyDiffTextTo",
              }, ",")
            end
          end
        end,
      },
    }
  end,

  keys = {
    { "<leader>gg", "<cmd>DiffviewOpen<CR>", desc = "[G]it Diffview" },
  },
}
