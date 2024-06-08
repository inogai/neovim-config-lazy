local minifiles_toggle = function(MiniFiles)
  if not MiniFiles.close() then
    MiniFiles.open(vim.fn.expand("%:p:h"))
  end
end

return {
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "echasnovski/mini.files",
    lazy = false,
    opts = function(_, opts)
      opts.mappings = {
        toggle_hidden = "g.",
        change_cwd = "gc",
        go_in_horizontal = "<C-w>s",
        go_in_vertical = "<C-w>v",
        go_in_horizontal_plus = "<C-w>S",
        go_in_vertical_plus = "<C-w>V",
        synchronize = ";",
      }
      opts.options = {
        use_as_default_explorer = true,
      }
    end,
    -- stylua: ignore
    keys = {
      { "<leader>e", function () minifiles_toggle(require("mini.files")) end, desc = "Files" },
    },
  },
}
