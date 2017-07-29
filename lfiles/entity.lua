local g
g = love.graphics
local Queue
Queue = require("util").Queue
local Entity
do
  local _class_0
  local _base_0 = {
    draw = function(self, color)
      if nil == color then
        g.setColor(255, 255, 255)
      else
        g.setColor(color[1], color[2], color[3])
      end
      return g.rectangle("fill", self.pos.x, self.pos.y, self.shape.w, self.shape.h)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, startX, startY, tileSize)
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
    __name = "Entity"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Entity = _class_0
end
local Box1
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    applyForce = function(self, v)
      local nx = self.pos.x + v.x
      local ny = self.pos.y + v.y
      if cd:move(nx, ny, self) then
        self.pos.x = self.pos.x + v.x
        self.pos.y = self.pos.y + v.y
      else
        local otherClass = cd.table[nx][ny].__class.__name
        if otherClass == "Box1" or otherClass == "Box2" or otherClass == "Box3" then
          cd.table[nx][ny]:applyForce(v)
          if cd:move(nx, ny, self) then
            self.pos.x = self.pos.x + v.x
            self.pos.y = self.pos.y + v.y
          end
        end
      end
    end,
    draw = function(self)
      return _class_0.__parent.draw(self, {
        0,
        255,
        0
      })
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "Box1",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Box1 = _class_0
end
local Box2
do
  local _class_0
  local _parent_0 = Box1
  local _base_0 = {
    draw = function(self)
      return _class_0.__parent.draw(self, {
        0,
        200,
        0
      })
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "Box2",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Box2 = _class_0
end
local Box3
do
  local _class_0
  local _parent_0 = Box1
  local _base_0 = {
    draw = function(self)
      return _class_0.__parent.draw(self, {
        0,
        140,
        0
      })
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "Box3",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Box3 = _class_0
end
local Wall
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    draw = function(self)
      g.setColor(200, 200, 200)
      return g.rectangle("fill", self.pos.x, self.pos.y, self.shape.w, self.shape.h)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "Wall",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Wall = _class_0
end
local BoxControl
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    affectAllOfType = function(type, v)
      for i = 1, #registry.objs[type] do
        registry.objs[type][i]:applyForce(v)
      end
    end,
    applyForce = function(self, v)
      self.affectAllOfType("Box1", v)
      return self.affectAllOfType("Box2", ({
        x = -v.x,
        y = -v.y
      }))
    end,
    draw = function(self)
      return _class_0.__parent.draw(self, {
        135,
        206,
        250
      })
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "BoxControl",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  BoxControl = _class_0
end
local Exit
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    checkWin = function(self, plyr)
      return plyr.pos.x == self.pos.x and plyr.pos.y == self.pos.y
    end,
    draw = function(self)
      return _class_0.__parent.draw(self, {
        255,
        255,
        150
      })
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "Exit",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Exit = _class_0
end
local Replicator
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    replicate = function(self)
      return print("replicated")
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "Replicator",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Replicator = _class_0
end
local pointToString
pointToString = function(pt)
  local strRep = "x: " .. pt.x .. " y: " .. pt.y
  return strRep
end
local inBounds
inBounds = function(pt)
  return (pt.x >= 0) and (pt.x < (g.getWidth())) and (pt.y >= 0) and (pt.y < (g.getHeight()))
end
local Hunter
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    move = function(self)
      local newPos = self.paths[pointToString(self.pos)]
      if nil ~= newPos then
        self.pos.x = newPos.x
        self.pos.y = newPos.y
      end
    end,
    search = function(self, pt)
      local frontier = Queue()
      local cameFrom = { }
      frontier:add(pt)
      cameFrom[pointToString(pt)] = nil
      while frontier:length() ~= 0 do
        local current = frontier:get()
        local neighbors = {
          {
            x = current.x + self.tileSize,
            y = current.y
          },
          {
            x = current.x,
            y = current.y + self.tileSize
          },
          {
            x = current.x - self.tileSize,
            y = current.y
          },
          {
            x = current.x,
            y = current.y - self.tileSize
          }
        }
        for i, pos in ipairs(neighbors) do
          if (nil == cameFrom[pointToString(pos)]) then
            if (inBounds(pos)) then
              frontier:add(pos)
              cameFrom[pointToString(pos)] = current
            end
          end
        end
      end
      self.paths = cameFrom
    end,
    step = function(self, plyr)
      self:search(plyr.pos)
      return self:move()
    end,
    draw = function(self)
      return _class_0.__parent.draw(self, {
        255,
        0,
        0
      })
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, startX, startY, tileSize)
      self.paths = { }
      self.tileSize = tileSize
      return _class_0.__parent.__init(self, startX, startY, tileSize)
    end,
    __base = _base_0,
    __name = "Hunter",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Hunter = _class_0
end
return {
  Entity = Entity,
  Box1 = Box1,
  Box2 = Box2,
  Box3 = Box3,
  Wall = Wall,
  BoxControl = BoxControl,
  Exit = Exit,
  Hunter = Hunter
}
