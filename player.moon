{graphics: g} = love
import Entity, Box1, BoxControl from require "entity"
-- export *
-- TODO: within switch statement need to encapsulate duplicated functionality in functions

class Player
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

    move: (v1, v2) =>
        if cd\move @pos.x + v1, @pos.y + v2, self
            @pos.x += v1
            @pos.y += v2
        else
            obstacle = cd\collision @pos.x + v1, @pos.y + v2
            -- print obstacle.__class
            switch obstacle.__class.__name
                when "Box1"
                    obstacle\applyForce({x: v1, y: v2})
                    if cd\move @pos.x + v1, @pos.y + v2, self
                        @pos.x += v1
                        @pos.y += v2
                when "BoxControl"
                    obstacle\applyForce({x: v1, y: v2})
    draw: =>
        g.setColor 0, 100, 100
        g.rectangle "fill", @pos.x, @pos.y, @shape.w, @shape.h

  -- i don't think you want to mix drawing and calculation
{
  :Player
}
