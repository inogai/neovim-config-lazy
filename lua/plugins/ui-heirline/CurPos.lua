local CurPos = {
  update = { "CursorMoved" },

  {
    hl = { fg = "fg1", bg = "bg1" },
    provider = function()
      local r, c = unpack(vim.api.nvim_win_get_cursor(0))
      return r .. ":" .. c
    end,
  },
}

return CurPos
