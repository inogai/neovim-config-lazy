---@class MyHeirline.Unit<Self>: { hl: HeirlineHighlight | fun(self: Self): HeirlineHighlight; provider: string | fun(self: Self): string; init: fun(self: Self) }

return {
  {
    "skwee357/nvim-prose",
    config = function()
      require("nvim-prose").setup({
        placeholders = {
          words = "",
          minutes = "",
        },
      })
    end,
  },
  {
    "SmiteshP/nvim-navic",
    opts = function(_, opts)
      opts.lazy_update_context = false
      return opts
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    enabled = false,
  },
  {
    "rebelot/heirline.nvim",
    config = function()
      local utils = require("heirline.utils")
      local conditions = require("heirline.conditions")

      local function setup_colors()
        return {
          fg = utils.get_highlight("Normal").fg,
          bg = utils.get_highlight("Normal").bg,

          bg1 = utils.get_highlight("StatusLine").bg,
          fg1 = utils.get_highlight("Normal").fg,

          fg3 = utils.get_highlight("StatusLine").fg,

          bright_bg = utils.get_highlight("Folded").bg,
          bright_fg = utils.get_highlight("Folded").fg,
          red = utils.get_highlight("DiagnosticError").fg,
          dark_red = utils.get_highlight("DiffDelete").bg,
          green = utils.get_highlight("String").fg,
          blue = utils.get_highlight("Directory").fg,
          gray = utils.get_highlight("NonText").fg,
          yellow = utils.get_highlight("DiagnosticWarn").fg,
          orange = utils.get_highlight("Constant").fg,
          purple = utils.get_highlight("Statement").fg,
          cyan = utils.get_highlight("Special").fg,
          diag_warn = utils.get_highlight("DiagnosticWarn").fg,
          diag_error = utils.get_highlight("DiagnosticError").fg,
          diag_hint = utils.get_highlight("DiagnosticHint").fg,
          diag_info = utils.get_highlight("DiagnosticInfo").fg,
          git_del = utils.get_highlight("diffDeleted").fg,
          git_add = utils.get_highlight("diffAdded").fg,
          git_change = utils.get_highlight("diffChanged").fg,
        }
      end

      utils.on_colorscheme(setup_colors)

      vim.api.nvim_create_augroup("Heirline", { clear = true })

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          utils.on_colorscheme(setup_colors)
        end,
        group = "Heirline",
      })

      vim.api.nvim_create_autocmd("OptionSet", {
        pattern = "background",
        callback = function()
          utils.on_colorscheme(setup_colors)
        end,
        group = "Heirline",
      })

      local Mode = require("plugins.heirline.Mode")
      local Icon = require("plugins.heirline.Icon")
      local Filename = require("plugins.heirline.Filename")
      local Diagnostics = require("plugins.heirline.Diagnostics")
      local Prose = require("plugins.heirline.Prose")
      local Navic = require("plugins.heirline.Navic")

      local ModifiedIndicator = {
        condition = function()
          return vim.bo.modifiable and vim.bo.modified
        end,
        update = { "InsertLeave", "TextChanged" },
        provider = "*",
      }

      local Align = { provider = "%=" }
      local Space = { provider = " " }

      local StatusLine = {
        Mode,
        Space,
        Icon,
        ModifiedIndicator,
        Filename,
        Space,
        Diagnostics,
        Align,
        Prose,
      }

      local Winbar = {
        { provider = "       " },
        Navic,
      }

      -- LazyVim.info(vim.inspect(StatusLine))

      require("heirline").setup({
        statusline = StatusLine,
        winbar = Winbar,
        -- tabline = TabLine,
        -- statuscolumn = StatusColumn
        opts = {
          disable_winbar_cb = function(args)
            return conditions.buffer_matches({
              buftype = { "nofile", "prompt", "help", "quickfix", "terminal" },
              filetype = { "^git.*", "fugitive", "Trouble", "dashboard" },
            }, args.buf)
          end,
        },
      })
    end,
  },
}
