return {
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python", --optional
    },
    ft = "python",
    branch = "regexp", -- This is the regexp branch, use this for the new version
    config = function(_, opts)
      require("venv-selector").setup(opts)
    end,
    opts = function(_, opts)
      opts = opts or {}

      local function on_venv_activate()
        local source = require("venv-selector").source()
        local python = require("venv-selector").python()

        if source == "miniconda" then
          local conda_env_name =
            python:gsub("^/opt/homebrew/Caskroom/miniconda/base/envs/", ""):gsub("/bin/python$", "")
          local command = "conda activate " .. conda_env_name
          require("toggleterm").exec(command, nil, nil, nil, nil, nil, nil, false)
          return
        end
      end

      opts.settings = opts.settings or {}
      opts.settings.options.on_venv_activate_callback = on_venv_activate
      opts.settings.search = opts.settings.search or {}
      opts.settings.search.miniconda = {
        command = [[conda env list | ggrep -v '^#' | ggrep . | gsed 's/^\\w\\+[ *]\\+//' | gsed 's/$/\\/bin\\/python/']],
        type = "anaconda",
      }
    end,
  },
}
