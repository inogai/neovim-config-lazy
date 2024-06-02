---@class MyHeirline.Filename.Self
---@field _root string
---@field _path string
---@field _file string

local function pretty_path(path)
  local plpath = require("plenary.path")

  local home = vim.fn.expand("$HOME")
  local root_rel = plpath:new(path):make_relative(home)

  if root_rel == "." then
    return "~/"
  end

  if root_rel.sub(0, 1) == "/" then
    return root_rel .. "/"
  end

  return "~/" .. root_rel .. "/"
end

---@class MyHeirline.Filename.Path.Self : MyHeirline.Filename.Self
---@field _path_body string
---@field _path_root string

---@type MyHeirline.Unit<MyHeirline.Filename.Path.Self>
local Path = {
  init = function(self)
    self._path_body = ""
    self._path_root = ""

    local plpath = require("plenary.path")

    local head = vim.fn.fnamemodify(self._file, ":h")
    local head_rel = plpath:new(head):make_relative(self._root)

    -- if `head_rel` is not precedent to root, then no need to show root
    if head_rel:sub(0, 1) == "/" then
      self._path_body = pretty_path(head_rel)
      return
    end

    -- if `head_rel` is root, then no need to show body
    if head_rel == "." then
      self._path_root = pretty_path(self._root)
      return
    end

    self._path_root = pretty_path(self._root)
    self._path_body = head_rel .. "/"
  end,

  {
    {
      hl = { fg = "fg3" },
      provider = function(self)
        return self._path_root
      end,
    },
    {
      hl = { fg = "green" },
      provider = function(self)
        return self._path_body
      end,
    },
  },
}

---@type MyHeirline.Unit<MyHeirline.Filename.Self>
local Name = {
  hl = { fg = "fg1" },
  provider = function(self)
    return vim.fn.fnamemodify(self._file, ":t")
  end,
}

---@type MyHeirline.Unit<MyHeirline.Filename.Self>
local Size = {
  hl = { fg = "fg3" },
  provider = function(self)
    local nr = vim.fn.getfsize(self._file)
    local magnitude = 1
    local unit_map = { "B", "kB", "MB", "GB", "TB" }
    while nr >= 100 do
      nr = nr / 1000
      magnitude = magnitude + 1
    end
    local nr_str = string.format("%.2f", nr)
    nr_str = nr_str:sub(0, 4) -- digits before '.' is always <= 2, so it's safe say this would be 3 effective numbers
    return nr_str .. unit_map[magnitude]
  end,
}

local Filename = {
  hl = { bg = "bg1" },
  ---@param self MyHeirline.Filename.Self
  init = function(self)
    local plpath = require("plenary.path")

    self._root = LazyVim.root()
    self._file = vim.fn.expand("%:p")
  end,
  update = { "BufEnter", "BufWritePost", "DirChanged" },

  { provider = " " },
  Path,
  Name,
  { provider = " " },
  Size,
}

return Filename
