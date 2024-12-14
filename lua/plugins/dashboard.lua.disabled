return {
  { "nvimdev/dashboard-nvim", enable = false },
  {
    "inogai/dashboard-nvim",
    lazy = true,
    event = function()
      return { "VeryLazy" }
    end,
    config = function(_, opts)
      if vim.fn.argc() == 0 and vim.api.nvim_buf_get_name(0) == "" and vim.g.read_from_stdin == nil then
        local dashboard = require("dashboard")
        dashboard.setup(opts)
        dashboard:instance()
      end
    end,
    opts = function()
      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        preview = {
          command = "cat",
          file_path = vim.fn.stdpath("config") .. "/asciiart/noah_" .. vim.o.background .. ".txt",
          file_height = 16,
          file_width = 40,
          row = math.floor((vim.o.lines - 38) / 2),

          padding_bottom = 2,
        },
        config = {
          header = {},
        -- stylua: ignore
        center = {
          { action = LazyVim.pick("files"),                         desc = " Find File",       icon = "󰱽 ", key = "f" },
          { action = "ObsidianToday",                               desc = " Daily Notes",     icon = "󱞂 ", key = "o" },
          { action = "ene | startinsert",                           desc = " New File",        icon = " ", key = "n" },
          { action = LazyVim.pick("oldfiles"),                      desc = " Recent Files",    icon = " ", key = "r" },
          { action = LazyVim.pick("live_grep"),                     desc = " Find Text",       icon = "󱎸 ", key = "g" },
          { action = LazyVim.pick.config_files(),                   desc = " Config",          icon = " ", key = "c" },
          { action = function() require("persistence").load() end,  desc = " Restore Session", icon = "󰦛 ", key = "s" },
          { action = "LazyExtras",                                  desc = " Lazy Extras",     icon = " ", key = "x" },
          { action = "Lazy",                                        desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = "qa",                                          desc = " Quit",            icon = " ", key = "q" },
      },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },
}
