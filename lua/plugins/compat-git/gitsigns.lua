local M = {}

function M.stage_hunk()
  require("gitsigns").stage_hunk()
end

function M.stage_visual()
  local first_line = vim.fn.line("v")
  local last_line = vim.fn.line(".")
  require("gitsigns").stage_hunk({ first_line, last_line })
  LazyVim.info("Staged " .. (last_line - first_line + 1) .. " lines")
end

function M.reset_visual()
  local first_line = vim.fn.line("v")
  local last_line = vim.fn.line(".")
  require("gitsigns").reset_hunk({ first_line, last_line })
  LazyVim.info("Reset" .. (last_line - first_line + 1) .. " lines")
end

return {
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      { "gh", M.stage_visual, desc = "Stage Line" },
      { "gh", M.stage_visual, desc = "Stage Visual", mode = "v" },
      { "gH", M.reset_visual, desc = "Reset Line" },
      { "gH", M.reset_visual, desc = "Reset Visual", mode = "v" },
      {
        "gp",
        function()
          require("gitsigns").preview_hunk()
        end,
        desc = "Preview Hunk",
      },
      {
        "gj",
        function()
          require("gitsigns").undo_stage_hunk()
        end,
        desc = "Undo Stage Hunk",
      },
    },
  },
}
