return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    -- stylua: ignore
    keys = {
      { "<c-/>", function ()
        require("toggleterm").toggle(1,8, LazyVim.root())
      end, desc = "ToggleTerm" },
    },

    opts = {
      shade_terminals = false,
    },
  },
}
