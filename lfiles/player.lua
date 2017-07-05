local g
g = love.graphics
local Entity, Box1, BoxControl
do
  local _obj_0 = require("entity")
  Entity, Box1, BoxControl = _obj_0.Entity, _obj_0.Box1, _obj_0.BoxControl
end
local Player
do
  local _class_0
  local _base_0 = {
    move = function(self, v1, v2)
      if cd:move(self.pos.x + v1, self.pos.y + v2, self) then
        self.pos.x = self.pos.x + v1
        self.pos.y = self.pos.y + v2
      else
        local obstacle = cd:collision(self.pos.x + v1, self.pos.y + v2)
        local _exp_0 = obstacle.__class.__name
        if "Box1" == _exp_0 then
          obstacle:applyForce({
            x = v1,
            y = v2
          })
          if cd:move(self.pos.x + v1, self.pos.y + v2, self) then
            self.pos.x = self.pos.x + v1
            self.pos.y = self.pos.y + v2
          end
        elseif "BoxControl" == _exp_0 then
          return obstacle:applyForce({
            x = v1,
            y = v2
          })
        end
      end
    end,
    draw = function(self)
      g.setColor(0, 100, 100)
      return g.rectangle("fill", self.pos.x, self.pos.y, self.shape.w, self.shape.h)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, startX, startY, tileSize)
      self.items = { }
      self.pos = {
        x = startX,
        y = startY
      }
      self.shape = {
        w = tileSize,
        h = tileSize
      }
    end,
    __base = _base_0,
    __name = "Player"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Player = _class_0
end
return {
  Player = Player
}
