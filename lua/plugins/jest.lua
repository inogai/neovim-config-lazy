local ft_list = { "javascript", "typescript", "typescriptreact" }

return {
  {
    "nvim-neotest/neotest-jest",
    ft = ft_list,
  },
  {
    "nvim-neotest/neotest",
    ft = ft_list,
    dependencies = {
      "nvim-neotest/neotest-jest",
    },
    opts = {
      adapters = {
        "neotest-jest",
      },
    },
  },
}
