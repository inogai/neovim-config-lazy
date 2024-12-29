--- based on the cookbook https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#getting-started
--- modified for mini.diff
local conditions = require("heirline.conditions")

local Git = {
  init = function(self)
    self.status_dict = vim.b.minidiff_summary or {}
    self.has_changes = (self.status_dict.add or 0) ~= 0
      or (self.status_dict.delete or 0) ~= 0
      or (self.status_dict.change or 0) ~= 0
  end,

  conditions = conditions.is_git_repo,

  hl = { fg = "fg3" },

  update = { "BufEnter", "TextChanged", "TextChangedI", "BufWritePost" },

  { -- git branch name
    provider = function(self)
      local handle = io.popen("git branch --show-current")
      local result = ""
      if handle ~= nil then
        result = handle:read("*l")
        handle:close()
      end
      return " " .. result
    end,
    hl = { bold = true },
  },
  -- You could handle delimiters, icons and counts similar to Diagnostics
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = "(",
  },
  {
    provider = function(self)
      local count = self.status_dict.add or 0
      return count > 0 and ("+" .. count)
    end,
    hl = { fg = "green" },
  },
  {
    provider = function(self)
      local count = self.status_dict.delete or 0
      return count > 0 and ("-" .. count)
    end,
    hl = { fg = "red" },
  },
  {
    provider = function(self)
      local count = self.status_dict.change or 0
      return count > 0 and ("~" .. count)
    end,
    hl = { fg = "yellow" },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = ")",
  },
}

return Git
