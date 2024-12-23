local function ctrl_slash()
  local toggleterm = require("toggleterm")
  local term = require("toggleterm.terminal")
  local cnt = vim.v.count

  if cnt ~= 0 then
    -- if count is provided, open a terminal with that id
    toggleterm.toggle(cnt, 12, LazyVim.root())
  else
    local terminals = term.get_all()
    -- if not provided, and no terminals are open, open a new terminal with id '1'
    if #terminals == 0 then
      toggleterm.toggle(1, 12, LazyVim.root())
      return
    end
    -- if not provided, toggle all terminals
    toggleterm.toggle_all()
  end
end

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function(_, opts)
      require("toggleterm").setup(opts)
    end,
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<C-/>", ctrl_slash },
    },
    opts = {
      shade_terminals = false,
    },
  },
}
