local hsluv = require "plugins.lush.hsluv"

local M = {}

function M.clamp(v)
  if v < 0 then
    return 0
  elseif v > 1 then
    return 1
  end
  return v
end

function M.lch(lightness, chroma, hue)
  local rgb = hsluv.lch_to_rgb { lightness, chroma, hue }

  local r, g, b = unpack(rgb)

  r = M.clamp(r)
  g = M.clamp(g)
  b = M.clamp(b)

  return setmetatable({}, {
    __index = function(_, key)
      if key == "h" then
        return hue
      elseif key == "c" then
        return chroma
      elseif key == "l" then
        return lightness
      elseif key == "hex" then
        return function()
          return string.format("#%02x%02x%02x", r * 255, g * 255, b * 255)
        end
      elseif key == "rgb" then
        return function()
          return { r, g, b }
        end
      elseif key == "da" then
        return function(v)
          return M.lch(lightness - v, chroma, hue)
        end
      elseif key == "li" then
        return function(v)
          return M.lch(lightness + v, chroma, hue)
        end
      elseif key == "set_lc" then
        return function(tup)
          return M.lch(tup[1], tup[2], hue)
        end
      elseif key == "mod_lc" then
        return function(tup)
          return M.lch(lightness + tup[1], chroma + tup[2], hue)
        end
      elseif key == "mix" then
        return function(other, ratio)
          local r2, g2, b2 = unpack(other.rgb())
          local lch = hsluv.rgb_to_lch {
            r * (1 - ratio) + r2 * ratio,
            g * (1 - ratio) + g2 * ratio,
            b * (1 - ratio) + b2 * ratio,
          }
          return M.lch(unpack(lch))
        end
      end
    end,
    __tostring = function()
      return string.format("#%02x%02x%02x", r * 255, g * 255, b * 255)
    end,
  })
end

function M.hex_as_lch(hex_str)
  local _ = hsluv.rgb_to_lch(hsluv.hex_to_rgb(hex_str))
  local l, c, h = unpack(_)
  return M.lch(l, c, h)
end

function M.hsluv(h, s, l)
  local rgb = hsluv.hsluv_to_rgb { h, s, l }
  local r, g, b = unpack(rgb)

  r = M.clamp(r)
  g = M.clamp(g)
  b = M.clamp(b)

  return setmetatable({}, {
    __index = function(_, key)
      if key == "h" then
        return h
      elseif key == "s" then
        return s
      elseif key == "l" then
        return l
      elseif key == "hex" then
        return function()
          return string.format("#%02x%02x%02x", r * 255, g * 255, b * 255)
        end
      elseif key == "da" then
        return function(v)
          return M.hsluv(h, s, l - v)
        end
      elseif key == "li" then
        return function(v)
          return M.hsluv(h, s, l + v)
        end
      elseif key == "set_lc" then
        return function(tup)
          return M.hsluv(h, tup[2], tup[1])
        end
      elseif key == "mod_lc" then
        return function(tup)
          return M.hsluv(h, s + tup[2], l + tup[1])
        end
      end
    end,
    __tostring = function()
      return string.format("#%02x%02x%02x", r * 255, g * 255, b * 255)
    end,
  })
end

function M.hex_as_hsluv(hex_str)
  local _ = hsluv.rgb_to_hsluv(hsluv.hex_to_rgb(hex_str))
  local h, s, l = unpack(_)
  return M.hsluv(h, s, l)
end

return M
