-- module Data.String.Unsafe
local Unsafe = {}

Unsafe.charCodeAt = function (i)
  return function (s)
    if i >= 0 and i < #s then return byte(string.sub(s, i+1, i+1)) end
    error("Data.String.Unsafe.charCodeAt: Invalid index.")
  end
end

Unsafe.charAt = function (i)
  return function (s)
    if i >= 0 and i < #s then return string.sub(s, i+1, i+1) end
    error("Data.String.Unsafe.charAt: Invalid index.")
  end
end

Unsafe.char = function (s)
  if s.length == 1 then return string.sub(s, 1, 1) end
  error("Data.String.Unsafe.char: Expected string of length 1.")
end

return Unsafe
