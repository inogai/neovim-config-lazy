local MiniMap = function()
  return require("mini.map")
end

return {
  {
    "gorbit99/codewindow.nvim",
    event = "BufEnter",
    opts = {
      auto_enable = true,
      width_multiplier = 4,
      minimap_width = 6,
      screen_bounds = "background",
      window_border = "none",
    },
    -- stylua: ignore
    keys = {
      { "<leader>um", function() require("codewindow").toggle_minimap() end },
    },
  },
  -- {
  --   "echasnovski/mini.map",
  --   version = false,
  --   dependencies = {
  --     "echasnovski/mini.diff",
  --   },
  --   opts = function(_, opts)
  --     local map = require("mini.map")
  --
  --     opts = vim.tbl_deep_extend("force", opts or {}, {
  --       symbols = {
  --         encode = map.gen_encode_symbols.block("3x2"),
  --       },
  --       integrations = {
  --         map.gen_integration.builtin_search(),
  --         map.gen_integration.diff(),
  --         map.gen_integration.diagnostic(),
  --       },
  --       window = {
  --         focusable = true,
  --         show_integration_count = false,
  --         width = 8,
  --       },
  --     })
  --
  --     return opts
  --   end,
  --   -- stylua: ignore
  --   keys = {
  --     { "<leader>um", function() MiniMap().toggle() end },
  --   },
  --   init = function()
  --     vim.api.nvim_create_autocmd("BufAdd", {
  --       callback = function()
  --         MiniMap().open()
  --       end,
  --     })
  --   end,
  -- },
  {
    "inogai/indent-blankline.nvim",
    opts = function(_, old_opts)
      local highlight = {
        "RainbowDelimiter1",
        "RainbowDelimiter2",
        "RainbowDelimiter3",
        "RainbowDelimiter4",
      }

      local opts = {
        scope = {
          highlight = highlight,
        },
        exclude = old_opts.exclude,
      }

      local hooks = require("ibl.hooks")

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

      return opts
    end,
  },

  -- {
  --   "echasnovski/mini.indentscope",
  --   opts = function()
  --     return {
  --       draw = {
  --         animation = function()
  --           return 40
  --         end,
  --       },
  --       symbol = "▏",
  --     }
  --   end,
  --   config = function(_, opts)
  --     local MiniIndentscope = require("mini.indentscope")
  --     MiniIndentscope.setup(opts)
  --
  --     -- remove the builtin autocmds of mini.indentscope
  --     vim.api.nvim_create_augroup("MiniIndentscope", {
  --       clear = true,
  --     })
  --
  --     local hooks = require("ibl.hooks")
  --
  --     -- draw the mini.indentscope based on the indent-blankline scope
  --     local last_id, last_row = nil, nil
  --
  --     local instant_draw_opts = {
  --       animation_fun = MiniIndentscope.gen_animation.none(),
  --     }
  --
  --     hooks.register(hooks.type.SCOPE_NOT_FOUND, function(tick, bufnr)
  --       if bufnr ~= vim.api.nvim_get_current_buf() then
  --         return
  --       end
  --
  --       MiniIndentscope.undraw()
  --     end)
  --
  --     hooks.register(hooks.type.SCOPE_HIGHLIGHT, function(tick, bufnr, scope_node, scope_index)
  --       if bufnr ~= vim.api.nvim_get_current_buf() then
  --         return scope_index
  --       end
  --
  --       local row, col = scope_node:start()
  --
  --       local id = scope_node:id()
  --       local draw_opts = {}
  --
  --       -- if the scope is the same, draw instantly
  --       if id == last_id or (row == last_row) then
  --         draw_opts = instant_draw_opts
  --       end
  --
  --       local scope = MiniIndentscope.get_scope(row + 2, col + 2, { bufnr = bufnr })
  --
  --       MiniIndentscope.draw(scope, draw_opts)
  --
  --       last_id, last_row = id, row
  --
  --       return scope_index
  --     end)
  --   end,
  -- },
}
