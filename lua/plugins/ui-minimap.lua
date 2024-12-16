return {
  {
    "gorbit99/codewindow.nvim",
    event = "BufEnter",
    opts = {
      auto_enable = true,
      width_multiplier = 4,
      minimap_width = 6,
      show_cursor = false,
      screen_bounds = "background",
      window_border = "none",
    },
    -- stylua: ignore
    keys = {
      { "<leader>um", function() require("codewindow").toggle_minimap() end },
    },
  },
}
