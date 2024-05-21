return {
  {
    "echasnovski/mini.animate",
    opts = function(_, opts)
      local animate = require("mini.animate")

      opts.cursor = opts.cursor or {}
      opts.cursor.timing = animate.gen_timing.cubic({ easing = "in-out", duration = 150, unit = "total" })
      opts.cursor.path = animate.gen_path.line({
        predicate = function()
          return true
        end,
        first_direction = "horizontal",
      })

      return opts
    end,
  },
}
