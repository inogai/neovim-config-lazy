return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        layout_config = {
          horizontal = {
            width = 0.95,
            preview_width = 0.6,
          },
          vertical = {
            width = 0.95,
            preview_height = 0.5,
          },
        },
      })
      return opts
    end,
  },
}
