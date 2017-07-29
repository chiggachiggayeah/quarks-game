{graphics: g} = love
import Entity, Box1, BoxControl from require "entity"
-- export *
-- TODO: within switch statement need to encapsulate duplicated functionality in functions
class Player
    states = {"MOVING", "IDLE"}
    movestep = 0
    count = 2
    new: (startX, startY, tileSize) =>
        @items = {}
        @pos = {
            x: startX,
            y: startY
        }
        @shape = {
            w: tileSize,
            h: tileSize
        }
        @target = nil
        @state = "IDLE"

    move: (v1, v2) =>
        if @state != "MOVING"
            @target = {"x": @pos.x + v1, "y": @pos.y + v2} 
            -- if cd\move @pos.x + v1, @pos.y + v2, self
            --     @pos.x += v1
            --     @pos.y += v2
            -- else
            --     obstacle = cd\collision @pos.x + v1, @pos.y + v2
            --     switch obstacle.__class.__name
            --         when "Box1"
            --             obstacle\applyForce({x: v1, y: v2})
            --             if cd\move @pos.x + v1, @pos.y + v2, self
            --                 @pos.x += v1
            --                 @pos.y += v2
            --         when "BoxControl"
            --             obstacle\applyForce({x: v1, y: v2})
            if cd\move @target.x, @target.y, self
                @state = "MOVING"
                count = 2
            else
                obstacle = cd\collision @pos.x + v1, @pos.y + v2
                switch obstacle.__class.__name
                    when "Box1"
                        obstacle\applyForce({x: v1, y: v2})
                        if cd\move @pos.x + v1, @pos.y + v2, self
                            -- @pos.x += v1
                            -- @pos.y += v2
                            @state = "MOVING"
                            count = 2
                    when "BoxControl"
                        obstacle\applyForce({x: v1, y: v2})
    step: =>
        switch @state
            when "MOVING"
                if @pos.x == @target.x and @pos.y == @target.y
                    @state = "IDLE"
                    movestep = 0
                else
                    movestep = 16
                    if @target.x < @pos.x
                        @pos.x -= movestep
                    else if @target.x > @pos.x
                        @pos.x += movestep
                    if @target.y < @pos.y
                        @pos.y -= movestep
                    else if @target.y > @pos.y
                        @pos.y += movestep

    draw: =>
        g.setColor 0, 100, 100
        g.rectangle "fill", @pos.x, @pos.y, @shape.w, @shape.h

  -- i don't think you want to mix drawing and calculation
{
  :Player
}
