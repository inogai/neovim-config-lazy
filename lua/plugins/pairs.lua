return {
  { "echasnovski/mini.pairs", enabled = false },
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6",
    config = function()
      require("ultimate-autopair").setup()
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",

    config = function()
      ---@type rainbow_delimiters.config
      vim.g.rainbow_delimiters = {
        highlight = {
          "RainbowDelimiter1",
          "RainbowDelimiter2",
          "RainbowDelimiter3",
          "RainbowDelimiter4",
        },
      }
    end,
  },
}
