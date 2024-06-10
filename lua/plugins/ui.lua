return {
  {
    "inogai/indent-blankline.nvim",
    opts = function(_, old_opts)
      local color = { "Yellow", "Green", "Purple", "Blue", "Cyan" }

      local opts = {
        indent = {
          highlight = {},
        },
        scope = {
          highlight = { "BasedRed" },
        },
        exclude = old_opts.exclude,
      }

      for _, c in ipairs(color) do
        table.insert(opts.indent.highlight, "Faded" .. c)
      end

      return opts
    end,
  },

  {
    "echasnovski/mini.indentscope",
    opts = function()
      return {
        draw = {
          animation = function()
            return 40
          end,
        },
        symbol = "▏",
      }
    end,
    config = function(_, opts)
      local MiniIndentscope = require("mini.indentscope")
      MiniIndentscope.setup(opts)

      -- remove the builtin autocmds of mini.indentscope
      vim.api.nvim_create_augroup("MiniIndentscope", {
        clear = true,
      })

      local hooks = require("ibl.hooks")

      -- draw the mini.indentscope based on the indent-blankline scope
      local last_id, last_row = nil, nil

      local instant_draw_opts = {
        animation_fun = MiniIndentscope.gen_animation.none(),
      }

      hooks.register(hooks.type.SCOPE_NOT_FOUND, function(tick, bufnr)
        if bufnr ~= vim.api.nvim_get_current_buf() then
          return
        end

        MiniIndentscope.undraw()
      end)

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, function(tick, bufnr, scope_node, scope_index)
        if bufnr ~= vim.api.nvim_get_current_buf() then
          return scope_index
        end

        local row, col = scope_node:start()

        local id = scope_node:id()
        local draw_opts = {}

        -- if the scope is the same, draw instantly
        if id == last_id or (row == last_row) then
          draw_opts = instant_draw_opts
        end

        local scope = MiniIndentscope.get_scope(row + 2, col + 2, { bufnr = bufnr })

        MiniIndentscope.draw(scope, draw_opts)

        last_id, last_row = id, row

        return scope_index
      end)
    end,
  },
}
