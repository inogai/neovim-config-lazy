local workspace_path = vim.fn.expand("~/Documents/Obsidian/default/")

return {
  {
    "render-markdown.nvim",
    enabled = false,
  },
  {
    "jbyuki/nabla.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>u`", function() require("nabla").toggle_virt() end, desc = "Toggle Nabla virt_lines" },
    },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    cmd = { "ObsidianOpen", "ObsidianToday", "ObsidianDailies" },
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    keys = {
      { "<leader>oo", "<cmd>ObsidianOpen<CR>", desc = "Open Preview" },
      { "<leader>ot", "<cmd>ObsidianToday<CR>", desc = "Daily Notes (Today)" },
      { "<leader>oT", "<cmd>ObsdianDailies<CR>", desc = "Daily Notes" },
    },
    opts = {
      workspaces = {
        {
          name = "default",
          path = workspace_path,
        },
      },

      -- Optional, alternatively you can customize the frontmatter data.
      ---@return table
      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.path and note.path.filename then
          local Path = require("plenary.path")

          -- Define the paths
          local note_path = Path:new(note.path.filename)

          -- Compute the relative path
          local relative_path = Path.make_relative(note_path, workspace_path)

          note.id = relative_path:lower():gsub(" ", "-"):gsub(".md", "")
        end

        local out = { id = note.id, aliases = note.aliases, tags = note.tags }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,

      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "Daily Notes/",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        -- alias_format = "%B %-d, %Y",
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil,
      },

      -- see below for full list of options 👇
    },
  },
}
