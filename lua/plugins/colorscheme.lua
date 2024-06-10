return {
  {
    "rktjmp/lush.nvim",
    priority = 999,
    config = function()
      require("lush")(require("plugins.lush.moegi"))
    end,
  },
}
