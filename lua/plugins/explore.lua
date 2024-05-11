local minifiles_toggle = function(MiniFiles)
  if not MiniFiles.close() then
    MiniFiles.open(LazyVim.root())
  end
end

return {
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "echasnovski/mini.files",
    lazy = false,
    opts = function(_, opts)
      opts.options = {
        use_as_default_explorer = true,
      }
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
