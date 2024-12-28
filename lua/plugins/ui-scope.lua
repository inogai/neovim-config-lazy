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

local function get_hl_group_names()
  local ret = {}

  for i, _ in ipairs(default_colors) do
    table.insert(ret, "RainbowDelimiter" .. i)
  end

  return ret
end

return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = prepare_hl_groups,
      })

      prepare_hl_groups()

      ---@module "rainbow-delimiters"
      ---@type rainbow_delimiters.config
      vim.g.rainbow_delimiters = {
        highlight = get_hl_group_names(),
      }
    end,
  },

  {
    "snacks.nvim",
    opts = {
      indent = { enabled = false },
    },
  },

  {
    "echasnovski/mini.indentscope",
    opts = function(_, opts)
      vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#c79652" })
      return {
        draw = { priority = 2 },
        symbol = "▎",
      }
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = function()
      local highlight = {
        "RainbowDelimiter1",
        "RainbowDelimiter2",
        "RainbowDelimiter3",
        "RainbowDelimiter4",
      }

      local opts = {
        indent = {
          priority = 1,
        },
        scope = {
          priority = 1024,
          highlight = highlight,
        },
        exclude = {
          filetypes = {
            "Trouble",
            "alpha",
            "dashboard",
            "help",
            "lazy",
            "mason",
            "neo-tree",
            "notify",
            "snacks_dashboard",
            "snacks_notif",
            "snacks_terminal",
            "snacks_win",
            "toggleterm",
            "trouble",
          },
        },
      }

      local hooks = require("ibl.hooks")

      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        prepare_hl_groups()
      end)

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

      return opts
    end,
  },
}
