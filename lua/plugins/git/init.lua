local M = require("plugins.git.utils")

return {
  require("plugins.git.conflict"),
  require("plugins.git.diffview"),
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
        "<leader>gn",
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
      { "<leader>gl", LazyVim.lazygit.open, "[L]azyGit" },
    },
  },
}