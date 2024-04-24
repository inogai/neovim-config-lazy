return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({
        winopts = {
          width = 0.9,
        },
      })
    end,
    cmd = "FzfLua",
    -- stylua: ignore
    keys = {
      { "<leader><space>", function() require("fzf-lua").files({ cwd = LazyVim.root() }) end, desc = "FzfLua Files (Root Dir)"  , },
      { "<leader>,"      , "<cmd>FzfLua buffers<cr>"                                        , desc = "FzF Buffer"               , },
      { "<leader>ff"     , "<cmd>FzfLua live_grep<cr>"                                      , desc = "Find in Files (Root Dir)" , },
      { "/"              , "<cmd>FzfLua lines<cr>"                                          , desc = "FzF Line"                 , },
      { "s"              , "<cmd>FzfLua grep_cword<cr>"                                     , desc = "FzF Grep (cword)"         , },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
  },
  {
    "folke/flash.nvim",
    keys = {
      { "s", false },
    },
  },
}
