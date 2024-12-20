---@class MyHeirline.Unit<Self>: { hl: HeirlineHighlight | fun(self: Self): HeirlineHighlight; provider: string | fun(self: Self): string; init: fun(self: Self) }

local M = {}

--- @class ColorSpec
--- @field fg string
--- @field bg string
--- @field hl_group vim.api.keyset.get_hl_info

--- @param name string
function M.get_highlight(name)
  local hl = vim.api.nvim_get_hl(0, { name = name, link = false })

  local ret = {
    fg = hl.fg,
    bg = hl.bg,
    hl_group = hl,
  }

  if hl.reverse then
    ret.fg, ret.bg = ret.bg, ret.fg
  end

  return ret
end

function M.setup_colors()
  local ret = {
    fg = M.get_highlight("Normal").fg,
    bg = M.get_highlight("Normal").bg,

    bg1 = M.get_highlight("StatusLine").bg,
    fg1 = M.get_highlight("Normal").fg,

    fg3 = M.get_highlight("StatusLine").fg,

    bright_bg = M.get_highlight("Folded").bg,
    bright_fg = M.get_highlight("Folded").fg,
    red = M.get_highlight("DiagnosticError").fg,
    dark_red = M.get_highlight("DiffDelete").bg,
    green = M.get_highlight("String").fg,
    blue = M.get_highlight("Directory").fg,
    gray = M.get_highlight("NonText").fg,
    yellow = M.get_highlight("DiagnosticWarn").fg,
    orange = M.get_highlight("Constant").fg,
    purple = M.get_highlight("Statement").fg,
    cyan = M.get_highlight("Special").fg,
    diag_warn = M.get_highlight("DiagnosticWarn").fg,
    diag_error = M.get_highlight("DiagnosticError").fg,
    diag_hint = M.get_highlight("DiagnosticHint").fg,
    diag_info = M.get_highlight("DiagnosticInfo").fg,
    git_del = M.get_highlight("diffDeleted").fg,
    git_add = M.get_highlight("diffAdded").fg,
    git_change = M.get_highlight("diffChanged").fg,
  }

  -- Force disable gui options, like reverse
  vim.api.nvim_set_hl(0, "StatusLine", {
    fg = ret.fg3,
    bg = ret.bg1,
  })

  return ret
end

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

      utils.on_colorscheme(M.setup_colors)

      vim.api.nvim_create_augroup("Heirline", { clear = true })

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          utils.on_colorscheme(M.setup_colors)
        end,
        group = "Heirline",
      })

      vim.api.nvim_create_autocmd("OptionSet", {
        pattern = "background",
        callback = function()
          utils.on_colorscheme(M.setup_colors)
        end,
        group = "Heirline",
      })

      local function submod(modname)
        return require("plugins.ui-heirline" .. modname)
      end

      local Mode = submod(".Mode")
      local Icon = submod(".Icon")
      local Filename = submod(".Filename")
      local Diagnostics = submod(".Diagnostics")
      local CurPos = submod(".CurPos")
      local Prose = submod(".Prose")
      local Navic = submod(".Navic")

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
        CurPos,
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
