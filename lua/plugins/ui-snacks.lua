local function pick_file(cwd)
  return function()
    Snacks.dashboard.pick("files", { cwd = cwd })
  end
end

return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      vim.api.nvim_create_user_command("Dashboard", function()
        Snacks.dashboard.open()
      end, {})

      opts = vim.tbl_deep_extend("force", opts, {
        dashboard = {
          enabled = true,

          wo = {
            winhighlight = "Normal:SnacksDashboardNormal,NormalFloat:SnacksDashboardNormal,Normal:SnacksDashboardDesc",
          },

          preset = {
          -- stylua: ignore
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = "󱞂 ", key = "o", desc = "Daily Notes", action = "ObsidianToday" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = pick_file(vim.fn.stdpath('config')) },
            { icon = "󰇘 ", key = "d", desc = "Dotfiles", action = pick_file("~/.local/share/chezmoi") },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          },

          sections = {
            {
              pane = 1,
              {
                section = "terminal",
                cmd = "cat " .. vim.fn.stdpath("config") .. "/asciiart/noah_" .. vim.o.background .. ".txt",
                height = 18,
                width = 40,
                padding = 1,
              },
              -- {
              --   section = "terminal",
              --   cmd = [[curl -fsSL https://international.v1.hitokoto.cn | jq -Mcr '[.hitokoto,.from,.from_who] | join(" ")' | awk '{print"『"$1"』—— "$2" "$3}']],
              -- },
            },

            {
              pane = 2,
              { section = "keys", gap = 1, padding = 1 },
              { section = "startup" },
            },
          },
        },
      })

      return opts
    end,
  },
}
