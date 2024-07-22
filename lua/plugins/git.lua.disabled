local M = {}

function M.cwd()
  return LazyVim.root()
end

function M.commit()
  local neogit = require("neogit")
  neogit.open({ cwd = M.cwd() })
  neogit.action("commit", "commit", {})()
end

return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = { "Neogit", "Gcommit" },
    config = function()
      local neogit = require("neogit")

      neogit.setup({})

      vim.api.nvim_create_user_command("Gcommit", M.commit, {})
    end,
    keys = {
      {
        "<leader>gg",
        function()
          require("neogit").open({ cwd = M.cwd() })
        end,
        desc = "Open Neogit",
      },
      {
        "<leader>gc",
        M.commit,
        desc = "Git [C]ommit",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      local actions = require("diffview.actions")
      local unpack = unpack or table.unpack

      local km = {
        { { "n" }, "q", "<Cmd>DiffviewClose<CR>", { desc = "[Q]uit Diffview" } },
        {
          { "n" },
          "c",
          M.commit,
          { desc = "Git [C]ommit" },
        },
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
                  "DiffDelete:MyDiffDeletedLines",
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
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "[D]iffview" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>gc", false },
      {
        "<leader>gh",
        function()
          require("telescope.builtin").git_commits({ cwd = LazyVim.root() })
        end,
        desc = "[H]istory",
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
