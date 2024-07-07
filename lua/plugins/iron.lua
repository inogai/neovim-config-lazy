--- Ensure that the repl is opened before running callback
--- @param callback fun()
local function ensure_opened(callback)
  return function()
    vim.cmd([[IronRepl]])
    callback()
  end
end

return {
  {
    "Vigemus/iron.nvim",
    cmd = "IronRepl",
    config = function()
      local iron = require("iron.core")

      -- check dap.lua for conflicts before modifying
      local prefix = "<leader>d"

      local keymaps = {
        -- send_motion = "<space>sc",
        visual_send = prefix .. "d",
        send_file = prefix .. "f",
        send_line = prefix .. "l",
        send_paragraph = prefix .. "p",
        send_until_cursor = prefix .. "u",
        -- send_mark = "<space>sm",
        -- mark_motion = "<space>mc",
        -- mark_visual = "<space>mc",
        -- remove_mark = "<space>md",
        -- cr = "<space>s<cr>",
        -- interrupt = "<space>s<space>",
        -- exit = "<space>sq",
        -- clear = "<space>cl",
      }

      iron.setup({
        config = {
          repl_definitions = {
            python = {
              command = function()
                return require("venv-selector").venv() .. "/bin/ipython"
              end,
            },
          },

          repl_open_cmd = require("iron.view").right(60),
          visibility = require("iron.visibility").focus,
        },

        keymaps = keymaps,

        highlight = {
          underdashed = true,
        },
      })
    end,
    keys = function()
      local iron = require("iron.core")

      -- stylua: ignore
      local keys =  {
        { "<leader>df", function() iron.send_file() end, desc = "Iron File" },
        { "<leader>dd", function() iron.send_line() end, desc = "Iron Line" },
        { "<leader>dp", function() iron.send_paragraph() end, desc = "Iron Paragraph" },
        { "<leader>du", function() iron.send_until_cursor() end, desc = "Iron Above" },
        { "<leader>d", function() iron.visual_send() end, desc = "Iron Viusal", mode = "v" },
      }

      for _, keymap in ipairs(keys) do
        keymap[2] = ensure_opened(keymap[2])
      end

      return keys
    end,
  },
}
