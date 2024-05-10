local minifiles_toggle = function(MiniFiles)
  if not MiniFiles.close() then
    MiniFiles.open(LazyVim.root())
  end
end

return {
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "echasnovski/mini.files",
    opts = function(_, opts)
      opts.mappings = {
        go_in = "<right>",
        go_out = "<left>",
      }
    end,
    -- stylua: ignore
    keys = {
      { "<leader>e", function () minifiles_toggle(require("mini.files")) end, desc = "Files" },
    },
  },
}
