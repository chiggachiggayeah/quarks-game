{graphics: g} = love
import Player from require "player"
import Entity, Box1, Box2, Box3, BoxControl, Wall, Exit, Hunter from require "entity"
import CollisionDetector from require "collision_detector"
import Reader from require "io.read"
import Registry from require "registry"
import Game from require "game"

lastbutton = "none"
tileSize = 64
offset = 64
game_won = false
dimensions = {}

export cd = {}
export registry = Registry!
export boundary = {}

createObj = (objTuple) ->
    x = objTuple[2]
    y = objTuple[3]
    objType = objTuple[1]
    switch objType 
        when "Box1"
            o = Box1 tileSize*x, tileSize*y, tileSize 
            registry\register o
        when "Box2"
            o = Box2 tileSize*x, tileSize*y, tileSize 
            registry\register o
        when "Box3"
            o = Box3 tileSize*x, tileSize*y, tileSize 
            registry\register o
        when "BoxControl"
            o = BoxControl tileSize*x, tileSize*y, tileSize
            registry\register o
           --
        when "Exit"
            o = Exit tileSize*x, tileSize*y, tileSize
            registry\register o
        ---
        when "Player"
            o = Player tileSize*x, tileSize*y, tileSize
            registry\register o
           --
        when "Wall"
            o = Wall tileSize*x, tileSize*y, tileSize
            table.insert boundary, o
            cd\add o
        when "Hunter"
            o = Hunter tileSize*x, tileSize*y, tileSize
            registry\register o
        

love.load = ->
    export joysticks = love.joystick.getJoysticks!
    export joystick = joysticks[1]
    export G = Game!
    cd = CollisionDetector G.dimensions.xDim, G.dimensions.yDim, tileSize
    success = love.window.setMode 768, 768, {} 

love.keyreleased = (key) ->
    switch G.state
        when "PLAYING"
            for p in *registry.objs["Player"]
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
            if key == "r"
                registry = Registry!
                cd = CollisionDetector G.dimensions.xDim, G.dimensions.yDim, tileSize
                G\startLevel createObj
        when "START"
            if key == "space"
                G\startLevel createObj
        when "PAUSE"
            if key == "space"
                G\resumeLevel!

timeStep = 0

love.update = (dt) ->
    timeStep = timeStep + dt
    for p in *registry.objs["Player"]
        p\step!
    for h in *registry.objs["Hunter"]
        if timeStep >= 1.0
            h\step  registry.objs["Player"][1] 
    if timeStep >= 1.0
        timeStep = 0
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
    

love.draw = ->
    G\step!
    
