local M = {}

function M.cwd()
  return LazyVim.root()
end

function M.commit()
  local neogit = require("neogit")
  neogit.open({ cwd = M.cwd() })
  neogit.action("commit", "commit", {})()
end

return M
