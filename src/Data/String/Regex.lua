-- module Data.String.Regex
local Regex = {}

error("Not implemented: Data.String.Regex")

--[[
Regex["showRegex'"] = function (r)
  return "" + r
end

Regex["regex'"] = function (s1)
  return function (s2)
    return new RegExp(s1, s2)
  end
end

Regex.source = function (r)
  return r.source
end

Regex.flags = function (r)
  return {
    multiline: r.multiline,
    ignoreCase: r.ignoreCase,
    global: r.global,
    sticky: !!r.sticky,
    unicode: !!r.unicode
  end
end

Regex.test = function (r)
  return function (s)
    return r.test(s)
  end
end

Regex._match = function (just)
  return function (nothing)
    return function (r)
      return function (s)
        var m = s.match(r)
        if (m == null) {
          return nothing
        } else {
          var list = []
          for (var i = 0; i < m.length; i++) {
            list.push(m[i] == null ? nothing : just(m[i]))
          }
          return just(list)
        }
      end
    end
  end
end

Regex.replace = function (r)
  return function (s1)
    return function (s2)
      return s2.replace(r, s1)
    end
  end
end

Regex["replace'"] = function (r)
  return function (f)
    return function (s2)
      return s2.replace(r, function (match)
        return f(match)(Array.prototype.splice.call(arguments, 1, arguments.length - 3))
      })
    end
  end
end

Regex._search = function (just)
  return function (nothing)
    return function (r)
      return function (s)
        var result = s.search(r)
        return result === -1 ? nothing : just(result)
      end
    end
  end
end

Regex.split = function (r)
  return function (s)
    return s.split(r)
  end
end

return Regex
]]
