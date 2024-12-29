local ModifiedIndicator = {
  condition = function()
    return vim.bo.modifiable and vim.bo.modified
  end,
  update = { "InsertLeave", "TextChanged" },
  provider = "*",
}

return ModifiedIndicator
