local Queue
do
  local _class_0
  local _base_0 = {
    get = function(self)
      if #self.inner > 0 then
        local val = self.inner[1]
        local newInner = { }
        if #self.inner > 1 then
          for i = 2, #self.inner do
            table.insert(newInner, self.inner[i])
          end
        end
        self.inner = newInner
        return val
      else
        return nil
      end
    end,
    add = function(self, item)
      return table.insert(self.inner, item)
    end,
    length = function(self)
      return #self.inner
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.inner = { }
    end,
    __base = _base_0,
    __name = "Queue"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Queue = _class_0
end
return {
  Queue = Queue
}
