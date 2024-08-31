return {
  { "echasnovski/mini.pairs", enabled = false },
  {
    "inogai/ultimate-autopair.nvim",
    dir = os.getenv("HOME") .. "/Workspaces/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    -- branch = "v0.6",
    config = function()
      local ua = require("ultimate-autopair")
      local configs = {
        ua.extend_default({
          extensions = {
            surroundtsnode = { p = 20 },
            suround = { p = 0 },
          },
        }),
      }
      ua.init(configs)
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",

    config = function()
      ---@module "rainbow-delimiters"
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
