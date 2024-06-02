local prose = require("nvim-prose")

local Prose = {
  condition = prose.is_available,

  update = { "InsertLeave" },

  {
    hl = { fg = "fg1", bg = "bg1" },
    provider = function()
      return "󰆙 " .. prose.word_count()
    end,
  },
}

return Prose
