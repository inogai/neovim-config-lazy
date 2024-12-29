local M = require("plugins.compat-git.utils")

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
          { "n", "s", actions.toggle_stage_entry, { desc = "Stage File" } },
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
