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
      local default_colors = {
        "#b5a165",
        "#528f77",
        "#8e7395",
        "#5a7aaa",
      }

      function prepare_hl_groups()
        local rd1_id = vim.api.nvim_get_hl(0, { name = "RainbowDelimiter1", create = false })

        if rd1_id == 0 then
          for i, color in ipairs(default_colors) do
            vim.nvim_set_hl(0, "RainbowDelimiter" .. i, { guifg = color })
          end
        end
      end

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = prepare_hl_groups,
      })

      prepare_hl_groups()

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
