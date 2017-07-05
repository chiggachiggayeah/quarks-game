local g
g = love.graphics
local Player
Player = require("player").Player
local Entity, Box1, Box2, BoxControl, Wall, Exit
do
  local _obj_0 = require("entity")
  Entity, Box1, Box2, BoxControl, Wall, Exit = _obj_0.Entity, _obj_0.Box1, _obj_0.Box2, _obj_0.BoxControl, _obj_0.Wall, _obj_0.Exit
end
local CollisionDetector
CollisionDetector = require("collision_detector").CollisionDetector
local Reader
Reader = require("io.read").Reader
local Registry
Registry = require("registry").Registry
local Game
Game = require("game").Game
local lastbutton = "none"
local tileSize = 64
local offset = 64
local game_won = false
local dimensions = { }
cd = { }
registry = Registry()
boundary = { }
local createObj
createObj = function(objTuple)
  local x = objTuple[2]
  local y = objTuple[3]
  local objType = objTuple[1]
  local _exp_0 = objType
  if "Box1" == _exp_0 then
    print("creating box 1")
    local o = Box1(tileSize * x, tileSize * y, tileSize)
    return registry:register(o)
  elseif "Box2" == _exp_0 then
    print("creating box 2")
    local o = Box1(tileSize * x, tileSize * y, tileSize)
    return registry:register(o)
  elseif "Box3" == _exp_0 then
    local o = Box2(tileSize * x, tileSize * y, tileSize)
    return registry:register(o)
  elseif "BoxControl" == _exp_0 then
    local o = BoxControl(tileSize * x, tileSize * y, tileSize)
    return registry:register(o)
  elseif "Exit" == _exp_0 then
    print("creating exit")
    local o = Exit(tileSize * x, tileSize * y, tileSize)
    return registry:register(o)
  elseif "Player" == _exp_0 then
    print("creating player")
    local o = Player(tileSize * x, tileSize * y, tileSize)
    return registry:register(o)
  elseif "Wall" == _exp_0 then
    local o = Wall(tileSize * x, tileSize * y, tileSize)
    table.insert(boundary, o)
    return cd:add(o)
  end
end
love.load = function()
  joysticks = love.joystick.getJoysticks()
  joystick = joysticks[1]
  G = Game()
  cd = CollisionDetector(G.dimensions.xDim, G.dimensions.yDim, tileSize)
  local success = love.window.setMode(768, 768, { })
end
love.keyreleased = function(key)
  local p = registry.objs["Player"][1]
  local _exp_0 = G.state
  if "PLAYING" == _exp_0 then
    if key == "right" then
      p:move(tileSize, 0)
    end
    if key == "left" then
      p:move(-tileSize, 0)
    end
    if key == "up" then
      p:move(0, -tileSize)
    end
    if key == "down" then
      p:move(0, tileSize)
    end
    if key == "space" then
      return G:pauseLevel()
    end
  elseif "START" == _exp_0 then
    if key == "space" then
      return G:startLevel(createObj)
    end
  elseif "PAUSE" == _exp_0 then
    if key == "space" then
      return G:resumeLevel()
    end
  end
end
love.update = function(dt)
  if #registry.objs["Exit"] == 1 then
    local exit = registry.objs["Exit"][1]
    if (exit:checkWin(registry.objs["Player"][1])) then
      game_won = true
      registry = Registry()
      cd = CollisionDetector(G.dimensions.xDim, G.dimensions.yDim, tileSize)
      if G:nextLevel() then
        return G:startLevel(createObj)
      else
        G:gameWon()
        return print("You won!")
      end
    end
  end
end
love.draw = function()
  return G:step()
end
