local g
g = love.graphics
local Screen
do
  local _class_0
  local _base_0 = {
    draw = function(self)
      g.setColor(self.color[1], self.color[2], self.color[3])
      g.rectangle("fill", 0, 0, g.getWidth(), g.getHeight())
      g.setColor(255, 255, 255)
      g.print(self.header, g.getWidth() / 2, g.getHeight() / 2, 0, 4, 4)
      return g.print(self.body, g.getWidth() / 2, (g.getHeight() / 2) + 100, 0, 2, 2)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, header, body, color)
      self.header = header
      self.body = body
      self.color = color
    end,
    __base = _base_0,
    __name = "Screen"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Screen = _class_0
end
return {
  Screen = Screen
}
