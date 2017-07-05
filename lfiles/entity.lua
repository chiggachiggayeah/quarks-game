local g
g = love.graphics
local Entity
do
  local _class_0
  local _base_0 = {
    draw = function(self)
      g.setColor(255, 255, 255)
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
      end
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
  local _base_0 = { }
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
    applyForce = function(self, v)
      local nx = self.pos.x + v.x
      local ny = self.pos.y + v.y
      if not self.cd:move(nx, ny, self) then
        local entity = cd.table[nx][ny]
        local _exp_0 = entity.__class.__name
        if "Box1" == _exp_0 then
          return entity:applyForce(v)
        elseif "Box2" == _exp_0 then
          return entity:applyForce(v)
        end
      else
        return _class_0.__parent.applyForce(self, v)
      end
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
      g.setColor(255, 255, 255)
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
return {
  Entity = Entity,
  Box1 = Box1,
  Box2 = Box2,
  Wall = Wall,
  BoxControl = BoxControl,
  Exit = Exit
}
