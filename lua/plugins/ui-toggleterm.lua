local function toggle()
  local toggleterm = require("toggleterm")
  local cnt = vim.v.count

  if cnt == 0 then
    toggleterm.toggle(1, 8, LazyVim.root())
  else
    toggleterm.toggle(cnt, 8, LazyVim.root())
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
    -- stylua: ignore
    keys = {
      { "<c-/>", toggle },
      { "<c-\\>", function() require("toggleterm").toggle_all() end },
    },
    opts = {
      shade_terminals = false,
    },
  },
}
