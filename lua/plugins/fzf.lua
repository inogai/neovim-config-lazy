return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end,
    cmd = "FzfLua",
    -- stylua: ignore
    keys = {
      { "<leader><space>", function() require("fzf-lua").files({ cwd = LazyVim.root() }) end, desc = "FzfLua Files (Root Dir)", },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
  },
}
