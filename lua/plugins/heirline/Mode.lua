local symbols = require("plugins.heirline.symbols")

---@alias mode "NORMAL" | "O-PENDING" | "VISUAL" | "V-LINE" | "V-BLOCK" | "SELECT" | "S-LINE" | "S-BLOCK" | "INSERT" | "REPLACE" | "V-REPLACE" | "COMMAND" | "EX" | "MORE" | "CONFIRM" | "SHELL" | "TERMINAL"

-- borrowed from lualine
local mode_map = {
  ["n"] = "NORMAL",
  ["no"] = "O-PENDING",
  ["nov"] = "O-PENDING",
  ["noV"] = "O-PENDING",
  ["no\22"] = "O-PENDING",
  ["niI"] = "NORMAL",
  ["niR"] = "NORMAL",
  ["niV"] = "NORMAL",
  ["nt"] = "NORMAL",
  ["ntT"] = "NORMAL",
  ["v"] = "VISUAL",
  ["vs"] = "VISUAL",
  ["V"] = "V-LINE",
  ["Vs"] = "V-LINE",
  ["\22"] = "V-BLOCK",
  ["\22s"] = "V-BLOCK",
  ["s"] = "SELECT",
  ["S"] = "S-LINE",
  ["\19"] = "S-BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["ix"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rc"] = "REPLACE",
  ["Rx"] = "REPLACE",
  ["Rv"] = "V-REPLACE",
  ["Rvc"] = "V-REPLACE",
  ["Rvx"] = "V-REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "EX",
  ["ce"] = "EX",
  ["r"] = "REPLACE",
  ["rm"] = "MORE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local _color_map = {
  n = { fg = "fg3", bg = "bg1" },
  i = { fg = "bg0", bg = "green" },
  v = { fg = "bg0", bg = "purple" },
  [""] = { fg = "bg0", bg = "purple" },
  c = { fg = "bg0", bg = "yellow" },
  t = { fg = "bg0", bg = "orange" },
  ["*"] = { fg = "bg0", bg = "red" },
}

local color_map = function(mode)
  return _color_map[mode] or _color_map["*"]
end

---@class MyHeirline.ModeComponentSelf
---@field _color_map table<string, table<string, string>>
---@field mode mode
---@field _hl HeirlineHighlight

local Mode = {
  ---@param self MyHeirline.ModeComponentSelf
  init = function(self)
    self.mode = vim.fn.mode()
  end,

  update = { "ModeChanged" },

  ---@param self MyHeirline.ModeComponentSelf
  hl = function(self)
    self._hl = color_map(self.mode)
    return self._hl
  end,

  {
    ---@param self MyHeirline.ModeComponentSelf
    hl = function(self)
      return { fg = self._hl.bg, bg = "bg1" }
    end,
    provider = symbols.LHC,
  },

  {
    ---@param self MyHeirline.ModeComponentSelf
    provider = function(self)
      if self.mode == "n" then
        return symbols.PIN .. " "
      end
      return symbols.PIN .. " " .. mode_map[self.mode] or self.mode
    end,
  },

  {
    ---@param self MyHeirline.ModeComponentSelf
    hl = function(self)
      return { fg = self._hl.bg, bg = "bg1" }
    end,
    provider = function(self)
      if self.mode == "n" then
        return ""
      end
      return symbols.RHC
    end,
  },
}

return Mode
