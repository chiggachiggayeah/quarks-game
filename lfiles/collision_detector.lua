local CollisionDetector
do
  local _class_0
  local _base_0 = {
    add = function(self, thing)
      self.table[thing.pos.x][thing.pos.y] = thing
    end,
    collision = function(self, nx, ny)
      return self.table[nx][ny]
    end,
    move = function(self, nx, ny, ent)
      if not self:collision(nx, ny) then
        self.table[ent.pos.x][ent.pos.y] = false
        self.table[nx][ny] = ent
        return true
      end
      return false
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, xdim, ydim, tileSize)
      self.table = { }
      for x = 0, xdim do
        self.table[x * tileSize] = { }
        for y = 0, ydim do
          self.table[x * tileSize][y * tileSize] = false
        end
      end
    end,
    __base = _base_0,
    __name = "CollisionDetector"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  CollisionDetector = _class_0
end
return {
  CollisionDetector = CollisionDetector
}
