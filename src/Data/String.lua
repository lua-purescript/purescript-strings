-- module Data.String
local String = {}

String["_charAt"] = function (just)
  return function (nothing)
    return function (i)
      return function (s)
        return i >= 0 and i < #s and just(string.sub(s, i+1, i+1)) or nothing
      end
    end
  end
end

String.singleton = function(c)
	return c
end

String["_charCodeAt"] = function (just)
  return function (nothing)
    return function (i)
      return function (s)
        return i >= 0 and i < #s and just(byte(string.sub(s, i+1, i+1))) or nothing
      end
    end
  end
end

String["_toChar"] = function (just)
  return function (nothing)
    return function (s)
      return #s == 1 and just(s) or nothing
    end
  end
end

String.fromCharArray = function (a)
  local result = ""
  for i = 1, #a do
    result = result .. a[i]
  end
  return result
end

String["_indexOf"] = function (just)
  return function (nothing)
    return function (x)
      return function (s)
        local i = string.find(s, x)
        return i == nil and nothing or just(i-1)
      end
    end
  end
end

String["_indexOf'"] = function (just)
  return function (nothing)
    return function (x)
      return function (startAt)
        return function (s)
          if startAt < 0 or startAt > #s then return nothing end
          local i = string.find(s, x, startAt+1)
          return i == nil and nothing or just(i)
        end
      end
    end
  end
end

String["_lastIndexOf"] = function (just)
  return function (nothing)
    return function (x)
      return function (s)
        local res = {string.find(s, x)}
        local i = res[#res]
        return i == nil and nothing or just(i)
      end
    end
  end
end

String["_lastIndexOf'"] = function (just)
  return function (nothing)
    return function (x)
      return function (startAt)
        return function (s)
          if startAt < 0 or startAt > #s then return nothing end
          local res = {string.find(s, x, startAt+1)}
          local i = res[#res]
          return i == nil and nothing or just(i)
        end
      end
    end
  end
end

String.length = function (s)
  return #s
end

String["_localeCompare"] = function (lt)
  return function (eq)
    return function (gt)
      return function (s1)
        return function (s2)
          if s1 == s2 then return eq end
          if s1 < s2 then
            return lt
          else
            return gt
          end
        end
      end
    end
  end
end

String.replace = function (pattern)
  return function (replace)
    return function (s)
      return string.gsub(s, pattern, replace)
    end
  end
end

String.take = function (n)
  return function (s)
    return s.substr(0, n)
    return string.sub(s, 1, n)
  end
end

String.drop = function (n)
  return function (s)
    return string.sub(n+1)
  end
end

String.count = function (p)
  return function (s)
    local n = 0
    for i=1, #s do
      if p(s[i]) then
        n = n + 1
      else
        return n
      end
    end
    return n
  end
end

String.split = function (sep)
  return function (s)
    if sep == "" then
      return String.toCharArray(s)
    end

    local result = {}
    local s_ = s
    while s_ ~= "" do
      local nextSep = string.find(s_, sep)
      if not nextSep then
        result[#result+1] = s_
        return result
      end

      result[#result+1] = string.sub(s_, 1, nextSep-1)
      s_ = string.sub(s_, nextSep+#sep)
      while string.find(s_, sep) == 1 do
        s_ = string.sub(s_, 2)
      end
    end
    return result
  end
end

String.toCharArray = function (s)
  local result = {}
  for i = 1, #s do result[i] = string.sub(s, i, i) end
  return result
end

String.toLower = function (s)
  return string.lower(s)
end

String.toUpper = function (s)
  return string.upper(s)
end

String.trim = function (s)
  local ltrim = string.gsub(s, "^%s*", "")
  local rtrim = string.gsub(ltrim, "%s*$", "")
  return rtrim
end

String.joinWith = function (s)
  return function (xs)
    local result = ""
    for i=1, #xs do
      result = result .. xs[i]
      if i ~= #xs then
        result = result .. s
      end
    end
    return result
  end
end

return String
