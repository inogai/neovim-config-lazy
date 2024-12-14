return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      local default_colors = {
        "#b5a165",
        "#528f77",
        "#8e7395",
        "#5a7aaa",
      }

      local function prepare_hl_groups()
        for i, color in ipairs(default_colors) do
          vim.api.nvim_set_hl(0, "RainbowDelimiter" .. i, { fg = color })
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
