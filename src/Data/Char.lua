-- module Data.Char
local Char = {}

Char.toCharCode = function (c)
  return string.byte(c)
end

Char.fromCharCode = function (c)
  return string.char(c)
end

Char.toLower = function (c)
  return string.lower(c)
end

Char.toUpper = function (c)
  return string.upper(c)
end

return Char
