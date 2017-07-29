local f = assert((io.open("level.txt", "w")))
local wall = "wwwwwwwwwwww\n"
local mid = "w..........w\n"
f:write(wall)
for j = 1, 10 do
  f:write(mid)
end
f:write(wall)
local _base_0 = f
local _fn_0 = _base_0.close
return function(...)
  return _fn_0(_base_0, ...)
end
