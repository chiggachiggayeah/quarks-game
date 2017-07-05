{graphics: g} = love
import Screen from require "screen"
import Reader from require "io.read"


class Game
    states = {"PLAYING", "START", "LOAD", "PAUSE"}
    tileSize = 64
    offset = 64
    new:  =>
        @state = "START"
        @selectedLevel = 1 
        @levels = {}
        @dimensions = {} -- will have xDim, yDim
        @screens = {
            "start": Screen "Quarks", "Press Enter", {0, 200, 100},
            "pause": Screen "Paused", "", {0, 200, 100},
            "load": Screen "Loading...", "", {0, 0, 0}
            "won": Screen "You Won!", "", {0, 200, 0}
        }
        r = Reader!
        fileRes = r\read!
        if false != fileRes
            @dimensions = fileRes[1]
            @levels = fileRes[2] -- need to change this to hold multiple levels
            -- for i = 1,#spec
            --     -- print fileRes[i][1]
            --     createObj spec[i]
    startLevel: (constructorFn) =>
        -- make sure the registry and collision detector are zeroed out
        @state = "PLAYING"
        @currentLevel = @levels[@selectedLevel]
        for i = 1,#@currentLevel
            constructorFn @currentLevel[i]
    nextLevel: =>
        @state = "LOAD"
        @selectedLevel = @selectedLevel + 1
        if @selectedLevel > #@levels
            -- the game has been won
            return false
        return true    
        -- else
        --     @currentLevel = @levels[@selectedLevel]
        --     return true
    pauseLevel: =>
        @state = "PAUSE"
    resumeLevel: =>
        @state = "PLAYING"
    gameWon: =>
        @state = "WON"
    drawGrid:  =>
        for x = 0,@dimensions.xDim - 1
            for y = 0,@dimensions.yDim - 1
                  g.setColor 100, 100, 100
                  g.rectangle "line", x*tileSize + offset, y*tileSize + offset, tileSize, tileSize


    step: =>
        switch @state
            when "START"
                @screens.start\draw!
            when "LOAD"
                @screens.load\draw!
            when "PAUSE"
                @screens.pause\draw!
            when "WON"
                @screens.won\draw!
            when "PLAYING"
                -- have  to do something in addition to this
                -- draw the current game state in the registry
                self\drawGrid!
                for k,v in pairs registry.objs
                    for obj in *v do obj\draw!
                for k,v in pairs boundary
                    v\draw!
{
    :Game
}
