return {
  {
    "sindrets/diffview.nvim",
    config = function()
      local actions = require("diffview.actions")
      local unpack = unpack or table.unpack

      local km = {
        { { "n", "x" }, "q", "<Cmd>DiffviewClose<CR>", { desc = "[Q]uit Diffview" } },
        { { "n", "x" }, "c", "<cmd>Gcommit<CR>", { desc = "Git [C]ommit" } },
      }

      require("diffview").setup({
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
            { "n", "<space>", actions.toggle_stage_entry, { desc = "Stage File" } },
            unpack(km),
          },
          file_history_panel = {
            unpack(km),
          },
        },

        hooks = {
          diff_buf_read = function()
            vim.opt_local.wrap = false
          end,
          ---@diagnostic disable-next-line: unused-local
          diff_buf_win_enter = function(bufnr, winid, ctx)
            -- Highlight 'DiffChange' as 'DiffDelete' on the left, and 'DiffAdd' on
            -- the right.
            if ctx.layout_name:match("^diff2") then
              if ctx.symbol == "a" then
                vim.opt_local.winhl = table.concat({
                  "DiffAdd:MyDiffTextFrom",
                  -- "DiffDelete:DiffDelete",
                  "DiffChange:MyDiffChangeFrom",
                  "DiffText:MyDiffTextFrom",
                }, ",")
              elseif ctx.symbol == "b" then
                vim.opt_local.winhl = table.concat({
                  "DiffDelete:DiffDelete",
                  "DiffChange:MyDiffChangeTo",
                  "DiffText:MyDiffTextTo",
                }, ",")
              end
            end
          end,
        },
      })
    end,
    keys = {
      { "<leader>gg", "<cmd>DiffviewOpen<CR>", desc = "Open Diffview" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>gc",
        function()
          require("telescope.builtin").git_commits({ cwd = LazyVim.root() })
        end,
        desc = "[C]ommits",
      },
      {
        "<leader>gf",
        function()
          require("telescope.builtin").git_bcommits({ cwd = LazyVim.root() })
        end,
        desc = "[F]ile History",
      },
    },
  },
}
