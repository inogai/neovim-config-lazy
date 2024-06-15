local hsluv = require "plugins.lush.hsluv"

local M = {}

---comment
---@param v number
---@param min number
---@param max number
---@return number
function M.clamp(v, min, max)
  if v < min then
    return min
  elseif v > max then
    return max
  end
  return v
end

---@class Lch.Options
---@field invert_lighteness? boolean

---@class Lch
---@field _lightness number 0-100
---@field _chroma number 0-100
---@field _hue number 0-360
---@field _opts Lch.Options
local Lch = {}
M.Lch = Lch

---Construct a new Lch object
---Will clamp h and c to 0-100
---Will rotate h to 0-360
---@param l number
---@param c number
---@param h number
---@param opts? Lch.Options
---@return Lch
function Lch:new(l, c, h, opts)
  l = M.clamp(l, 0, 100)
  c = M.clamp(c, 0, 100)
  h = h % 360
  local lch = { _lightness = l, _chroma = c, _hue = h, _opts = opts or {} }
  setmetatable(lch, self)
  self.__index = self
  return lch
end

function Lch:from_rgb(r, g, b)
  return Lch:new(unpack(hsluv.rgb_to_lch { r, g, b }))
end

---@param val number
---@return Lch
function Lch:l(val)
  return Lch:new(val, self._chroma, self._hue, self._opts)
end

---@param val number
---@return Lch
function Lch:c(val)
  return Lch:new(self._lightness, val, self._hue, self._opts)
end

---@param val number
---@return Lch
function Lch:h(val)
  return Lch:new(self._lightness, self._chroma, val, self._opts)
end

---@param val number
---@return Lch
function Lch:li(val)
  return Lch:new(self._lightness + val, self._chroma, self._hue, self._opts)
end

---@param val number
---@return Lch
function Lch:ci(val)
  return Lch:new(self._lightness, self._chroma + val, self._hue, self._opts)
end

---@param val number
---@return Lch
function Lch:hi(val)
  return Lch:new(self._lightness, self._chroma, self._hue + val, self._opts)
end

function Lch:export(val)
  local opts = self._opts
  if opts.invert_lighteness then
    opts.invert_lighteness = false
    return Lch:new(100 - self._lightness, self._chroma, self._hue, opts)
  end

  return self
end

function Lch:hex()
  return hsluv.lch_to_hex { self._lightness, self._chroma, self._hue }
end

function Lch:rgb()
  local rgb = hsluv.lch_to_rgb { self._lightness, self._chroma, self._hue }
  local r, g, b = unpack(rgb)

  r = M.clamp(r, 0, 1)
  g = M.clamp(g, 0, 1)
  b = M.clamp(b, 0, 1)

  return r, g, b
end

function Lch:mix(other, ratio)
  local r1, g1, b1 = self:rgb()
  local r2, g2, b2 = other:rgb()

  local r = (r1 * (1 - ratio)) + (r2 * ratio)
  local g = (g1 * (1 - ratio)) + (g2 * ratio)
  local b = (b1 * (1 - ratio)) + (b2 * ratio)

  return Lch:from_rgb(r, g, b)
end

function Lch:__tostring()
  local r, g, b = self:export():rgb()
  return string.format("#%02x%02x%02x", r * 255, g * 255, b * 255)
end

---@param hex_str string
---@param opts? Lch.Options
---@return Lch
function Lch:from_hex(hex_str, opts)
  local _ = hsluv.rgb_to_lch(hsluv.hex_to_rgb(hex_str))
  local l, c, h = unpack(_)
  return Lch:new(l, c, h, opts)
end

-- function M.hsluv(h, s, l)
--   local rgb = hsluv.hsluv_to_rgb { h, s, l }
--   local r, g, b = unpack(rgb)
--
--   r = M.clamp(r)
--   g = M.clamp(g)
--   b = M.clamp(b)
--
--   return setmetatable({}, {
--     __index = function(_, key)
--       if key == "h" then
--         return h
--       elseif key == "s" then
--         return s
--       elseif key == "l" then
--         return l
--       elseif key == "hex" then
--         return function()
--           return string.format("#%02x%02x%02x", r * 255, g * 255, b * 255)
--         end
--       elseif key == "da" then
--         return function(v)
--           return M.hsluv(h, s, l - v)
--         end
--       elseif key == "li" then
--         return function(v)
--           return M.hsluv(h, s, l + v)
--         end
--       elseif key == "set_lc" then
--         return function(tup)
--           return M.hsluv(h, tup[2], tup[1])
--         end
--       elseif key == "mod_lc" then
--         return function(tup)
--           return M.hsluv(h, s + tup[2], l + tup[1])
--         end
--       end
--     end,
--     __tostring = function()
--       return string.format("#%02x%02x%02x", r * 255, g * 255, b * 255)
--     end,
--   })
-- end
--
-- function M.hex_as_hsluv(hex_str)
--   local _ = hsluv.rgb_to_hsluv(hsluv.hex_to_rgb(hex_str))
--   local h, s, l = unpack(_)
--   return M.hsluv(h, s, l)
-- end
--
return M
