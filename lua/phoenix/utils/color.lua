local hsl_convert = require 'lush.vivid.hsl.convert'

local M = {}

M.hsl = function(h, s, l)
  return hsl_convert.hsl_to_hex { h = h, s = s, l = l }
end

M.hex_to_rgb = function(hex)
  hex = hex:gsub('#', '')
  return {
    r = tonumber('0x' .. hex:sub(1, 2)) / 255,
    g = tonumber('0x' .. hex:sub(3, 4)) / 255,
    b = tonumber('0x' .. hex:sub(5, 6)) / 255,
  }
end

M.rgb_to_hex = function(rgb)
  return string.format('#%02x%02x%02x', rgb.r * 255, rgb.g * 255, rgb.b * 255)
end

M.rgb_to_hsl = function(rgb)
  local r, g, b = rgb.r, rgb.g, rgb.b
  local max, min = math.max(r, g, b), math.min(r, g, b)
  local h, s, l = (max + min) / 2, (max + min) / 2, (max + min) / 2

  if max == min then
    -- achromatic
    h, s = 0, 0
  else
    local delta = max - min
    s = l > 0.5 and delta / (2 - max - min) or delta / (max + min)
    if max == r then
      h = (g - b) / delta + (g < b and 6 or 0)
    elseif max == g then
      h = (b - r) / delta + 2
    elseif max == b then
      h = (r - g) / delta + 4
    end
    h = h / 6
  end
  return { h = h, s = s, l = l }
end

return M
