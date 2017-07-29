local mapping = {
  ["c"] = "BoxControl",
  ["1"] = "Box1",
  ["2"] = "Box2",
  ["3"] = "Box3",
  ["."] = "Floor",
  ["w"] = "Wall",
  ["p"] = "Player",
  ["e"] = "Exit",
  ["h"] = "Hunter"
}
local Reader
do
  local _class_0
  local _base_0 = {
    read = function(self)
      self.l = self.f:read()
      local level = { }
      local failure = false
      local lineLen = #self.l
      local y = -1
      while self.l ~= nil do
        if 0 == #self.l then
          if #level ~= 0 then
            table.insert(self.levels, level)
            level = { }
            y = -1
          end
        else
          y = y + 1
        end
        for x = 0, #self.l - 1 do
          local c = self.l:sub(x + 1, x + 1)
          local t = mapping[c]
          table.insert(level, {
            t,
            x,
            y
          })
        end
        self.l = self.f:read()
        if self.l ~= nil and #self.l ~= 0 and #self.l ~= lineLen then
          failure = true
          break
        end
      end
      self.f:close()
      if #level ~= 0 then
        table.insert(self.levels, level)
      end
      if failure then
        return false
      else
        return {
          {
            xDim = lineLen,
            yDim = y
          },
          self.levels
        }
      end
    end,
    print = function(self)
      local _list_0 = self.levels
      for _index_0 = 1, #_list_0 do
        local i = _list_0[_index_0]
        for _index_1 = 1, #i do
          local j = i[_index_1]
          print("Type: ", j[1], " X: ", j[2], " Y: ", j[3])
        end
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, handle)
      local fileName = "io/level.txt"
      if handle ~= nil then
        fileName = handle
      end
      self.f = assert((io.open(fileName, "r")))
      self.l = ""
      self.levels = { }
    end,
    __base = _base_0,
    __name = "Reader"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Reader = _class_0
end
return {
  Reader = Reader
}
