local g
g = love.graphics
local Screen
Screen = require("screen").Screen
local Reader
Reader = require("io.read").Reader
local Game
do
  local _class_0
  local states, tileSize, offset
  local _base_0 = {
    startLevel = function(self, constructorFn)
      self.state = "PLAYING"
      self.currentLevel = self.levels[self.selectedLevel]
      for i = 1, #self.currentLevel do
        constructorFn(self.currentLevel[i])
      end
    end,
    nextLevel = function(self)
      self.state = "LOAD"
      self.selectedLevel = self.selectedLevel + 1
      if self.selectedLevel > #self.levels then
        return false
      end
      return true
    end,
    pauseLevel = function(self)
      self.state = "PAUSE"
    end,
    resumeLevel = function(self)
      self.state = "PLAYING"
    end,
    gameWon = function(self)
      self.state = "WON"
    end,
    drawGrid = function(self)
      for x = 0, self.dimensions.xDim - 1 do
        for y = 0, self.dimensions.yDim - 1 do
          g.setColor(100, 100, 100)
          g.rectangle("line", x * tileSize + offset, y * tileSize + offset, tileSize, tileSize)
        end
      end
    end,
    step = function(self)
      local _exp_0 = self.state
      if "START" == _exp_0 then
        return self.screens.start:draw()
      elseif "LOAD" == _exp_0 then
        return self.screens.load:draw()
      elseif "PAUSE" == _exp_0 then
        return self.screens.pause:draw()
      elseif "WON" == _exp_0 then
        return self.screens.won:draw()
      elseif "PLAYING" == _exp_0 then
        self:drawGrid()
        for k, v in pairs(registry.objs) do
          for _index_0 = 1, #v do
            local obj = v[_index_0]
            obj:draw()
          end
        end
        for k, v in pairs(boundary) do
          v:draw()
        end
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.state = "START"
      self.selectedLevel = 1
      self.levels = { }
      self.dimensions = { }
      self.screens = {
        ["start"] = Screen("Quarks", "Press Enter", {
          0,
          200,
          100
        }),
        ["pause"] = Screen("Paused", "", {
          0,
          200,
          100
        }),
        ["load"] = Screen("Loading...", "", {
          0,
          0,
          0
        }),
        ["won"] = Screen("You Won!", "", {
          0,
          200,
          0
        })
      }
      local r = Reader()
      local fileRes = r:read()
      if false ~= fileRes then
        self.dimensions = fileRes[1]
        self.levels = fileRes[2]
      end
    end,
    __base = _base_0,
    __name = "Game"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  states = {
    "PLAYING",
    "START",
    "LOAD",
    "PAUSE"
  }
  tileSize = 64
  offset = 64
  Game = _class_0
end
return {
  Game = Game
}
