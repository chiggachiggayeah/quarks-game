{graphics: g} = love
import Player from require "player"
import Entity, Box1, Box2, BoxControl, Wall, Exit from require "entity"
import CollisionDetector from require "collision_detector"
import Reader from require "io.read"
import Registry from require "registry"
import Game from require "game"
-- what the heck
-- hey zeus
-- something
-- something else dumb

lastbutton = "none"
tileSize = 64
offset = 64
game_won = false
dimensions = {}
-- export cd = CollisionDetector 12, 12, tileSize
export cd = {}
export registry = Registry!
export boundary = {}
-- export G = Game!
-- joystick = ""

createObj = (objTuple) ->
    x = objTuple[2]
    y = objTuple[3]
    objType = objTuple[1]
    switch objType 
        when "Box1"
            print "creating box 1"
            o = Box1 tileSize*x, tileSize*y, tileSize 
            registry\register o
           -- create box 1
        when "Box2"
            print "creating box 2"
            o = Box1 tileSize*x, tileSize*y, tileSize 
            registry\register o
           -- create box 1
        when "Box3"
            o = Box2 tileSize*x, tileSize*y, tileSize 
            registry\register o
           -- create box 2
        when "BoxControl"
            o = BoxControl tileSize*x, tileSize*y, tileSize
            registry\register o
           --
        when "Exit"
            print "creating exit"
            o = Exit tileSize*x, tileSize*y, tileSize
            registry\register o
        ---
        when "Player"
            print "creating player"
            o = Player tileSize*x, tileSize*y, tileSize
            registry\register o
           --
        when "Wall"
            o = Wall tileSize*x, tileSize*y, tileSize
            table.insert boundary, o
            cd\add o
        

love.load = ->
    export joysticks = love.joystick.getJoysticks!
    export joystick = joysticks[1]
    export G = Game!
    cd = CollisionDetector G.dimensions.xDim, G.dimensions.yDim, tileSize
    success = love.window.setMode 768, 768, {} 
  -- e1 = Box1 tileSize*2, tileSize*3, tileSize, cd 
  -- e2 = Box2 tileSize*5, tileSize*6, tileSize, cd 
  -- e3 = BoxControl tileSize*10, tileSize*10, tileSize, cd    

  -- register e1, registry, cd
  -- register e2, registry, cd
  -- register e3, registry, cd

  -- export p = Player tileSize, tileSize, tileSize, cd
  -- export exit = Exit tileSize, tileSize*10, tileSize, cd
  -- export boundary = {}

  -- register p, registry, cd
  -- register exit, registry, cd

  --export e = Box1 128, tileSize*3, tileSize, cd
  --export e2 = Box2 tileSize*5, tileSize*6, tileSize, cd
  
  --export exit = Exit tileSize*1, tileSize*10, tileSize, cd
  --table.insert registry.objs["Box1"], e
  --table.insert registry.objs["Box2"], e2
  --export bc = BoxControl tileSize*10, tileSize*10, tileSize, cd
  -- print "Box position in load: #{e.pos.x}"

  --cd\add p
  --cd\add e
  --cd\add e2
  --cd\add bc

    -- for x = 0,11
    --     if x == 0 or x == 11
    --         for y = 0,11
    --             w = Wall x*tileSize, y*tileSize, tileSize, cd
    --            -- table.insert boundary, w
    --             --cd\add w
    --     else
    --         w = Wall x*tileSize, 0, tileSize, cd
    --         -- table.insert boundary, w
    --         -- cd\add w
    --         w = Wall x*tileSize, 11*tileSize, tileSize, cd
    --         -- table.insert boundary, w
    --         -- cd\add w

love.keyreleased = (key) ->
    p = registry.objs["Player"][1]
    switch G.state
        when "PLAYING"
            if key == "right"
                p\move tileSize, 0
            if key == "left"
                p\move -tileSize, 0
            if key == "up"
                p\move 0, -tileSize
            if key == "down"
                p\move 0, tileSize
            if key == "space"
                G\pauseLevel!
        when "START"
            if key == "space"
                G\startLevel createObj
        when "PAUSE"
            if key == "space"
                G\resumeLevel!


-- playerCollision = ->
-- what the hell

love.update = (dt) ->
    if #registry.objs["Exit"] == 1
        exit = registry.objs["Exit"][1]
        if (exit\checkWin registry.objs["Player"][1])
            game_won = true
            registry = Registry!
            cd = CollisionDetector G.dimensions.xDim, G.dimensions.yDim, tileSize
            if G\nextLevel!
                G\startLevel createObj
            else
                G\gameWon!
                print "You won!"

-- startScreen = Screen "Hey", "Play My Game!", {0, 200, 150}
-- 
-- drawScreen = (screen) ->
--     screen\draw!

love.draw = ->
    G\step!
    -- drawScreen startScreen
    -- drawGrid!
    
