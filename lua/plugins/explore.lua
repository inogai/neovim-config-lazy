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
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(ev)
          vim.schedule(function()
            vim.api.nvim_set_option_value("buftype", "acwrite", { buf = 0 })
            vim.api.nvim_buf_set_name(0, tostring(vim.api.nvim_get_current_win()))
            vim.api.nvim_create_autocmd("BufWriteCmd", {
              buffer = ev.data.buf_id,
              callback = function()
                require("mini.files").synchronize()
              end,
            })
          end)
        end,
      })
    end,
    -- stylua: ignore
    keys = {
      { "<leader>e", function () minifiles_toggle(require("mini.files")) end, desc = "Files" },
    },
  },
}
