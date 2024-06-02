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
    "nvim-lualine/lualine.nvim",
    enabled = false,
  },
  {
    "rebelot/heirline.nvim",
    config = function()
      local utils = require("heirline.utils")

      local function setup_colors()
        return {
          bg0 = utils.get_highlight("GruvboxBg0").fg,
          bg1 = utils.get_highlight("GruvboxBg1").fg,
          fg1 = utils.get_highlight("GruvboxFg1").fg,
          fg3 = utils.get_highlight("GruvboxFg3").fg,
          bright_fg = utils.get_highlight("GruvboxFg1").fg,
          bright_bg = utils.get_highlight("GruvboxBg1").fg,
          red = utils.get_highlight("GruvboxRed").fg,
          green = utils.get_highlight("GruvboxGreen").fg,
          blue = utils.get_highlight("GruvboxBlue").fg,
          yellow = utils.get_highlight("GruvboxYellow").fg,
          gray = utils.get_highlight("GruvboxGray").fg,
          orange = utils.get_highlight("GruvboxOrange").fg,
          purple = utils.get_highlight("GruvboxPurple").fg,
          cyan = utils.get_highlight("GruvboxAqua").fg,
          diag_warn = utils.get_highlight("DiagnosticWarn").fg,
          diag_error = utils.get_highlight("DiagnosticError").fg,
          diag_hint = utils.get_highlight("DiagnosticHint").fg,
          diag_info = utils.get_highlight("DiagnosticInfo").fg,
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

      local ModifiedIndicator = {
        condition = function()
          return vim.bo.modifiable and vim.bo.modified
        end,
        update = { "InsertLeave", "TextChanged" },
        hl = { fg = "fg1", bg = "bg1" },
        provider = "*",
      }

      local Align = { hl = { bg = "bg1" }, provider = "%=" }
      local Space = { hl = { bg = "bg1" }, provider = " " }

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

      -- LazyVim.info(vim.inspect(StatusLine))

      require("heirline").setup({
        statusline = StatusLine,
        -- winbar = WinBar,
        -- tabline = TabLine,
        -- statuscolumn = StatusColumn
        opts = {},
      })
    end,
  },
}
