return {
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          kind = "error",
          any = {
            { find = "Node ComputedPropertyName was unexpected." }, -- maybe this works for presence.nvim
          },
        },
        opts = { skip = true },
      })
    end,
  },
}
