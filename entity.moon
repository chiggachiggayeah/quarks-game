{graphics: g} = love
import Queue from require "util"
-- TODO: extract tileSize from constructor, probably make it a global

class Entity
    new: (startX, startY, tileSize) =>
        @pos = {
          x: startX,
          y: startY
        }

        @shape = {
          w: tileSize,
          h: tileSize
        }

    draw: (color) =>
        if nil == color
            g.setColor 255, 255, 255
        else
            g.setColor color[1], color[2], color[3]
        g.rectangle "fill", @pos.x, @pos.y, @shape.w, @shape.h

class Box1 extends Entity
    -- think about having this return true or false
    applyForce: (v) =>
    -- calc where the box should move based on the vector
    -- check for collision
    -- move and move all in "chain"

        nx = @pos.x + v.x
        ny = @pos.y + v.y

        if cd\move nx, ny, self
          @pos.x += v.x
          @pos.y += v.y
        else
            otherClass = cd.table[nx][ny].__class.__name
            if otherClass == "Box1" or otherClass == "Box2" or otherClass == "Box3" 
                cd.table[nx][ny]\applyForce v
                if cd\move nx, ny, self
                    @pos.x += v.x
                    @pos.y += v.y
    draw: =>
        super\draw {0, 255, 0} --lime green
        
-- else check if we have the kind of thing a box one can move and attempt to move it

class Box2 extends Box1
    draw: =>
        super\draw {0,200,0}

class Box3 extends Box1
    -- applyForce: (v) =>
    --     print self.__parent.__name
    --     nx = @pos.x + v.x
    --     ny = @pos.y + v.y

    --     if not cd\move nx, ny, self
    --          
    --         entity = cd.table[nx][ny]
    --         switch entity.__class.__name
    --             when "Box1"
    --                 entity\applyForce v
    --             when "Box2"
    --                 entity\applyForce v
    --     else
    --         super\applyForce v
    draw: =>
        super\draw {0, 140, 0}
    
class Wall extends Entity
    draw: =>
        g.setColor 200, 200, 200
        g.rectangle "fill", @pos.x, @pos.y, @shape.w, @shape.h

class BoxControl extends Entity
    affectAllOfType: (type, v) ->
        for i = 1,#registry.objs[type]
            registry.objs[type][i]\applyForce v
        
    applyForce: (v) =>
        self.affectAllOfType "Box1", v
        self.affectAllOfType "Box2", ({x: -v.x, y: -v.y})
    draw: =>
        super\draw {135, 206, 250}

class Exit extends Entity
    checkWin: (plyr)  =>
        return plyr.pos.x == @pos.x and plyr.pos.y == @pos.y
    draw: =>
        super\draw {255, 255, 150}

class Replicator extends Entity
    replicate: =>
        print "replicated"

pointToString = (pt) ->
    strRep = "x: " .. pt.x .. " y: " .. pt.y
    return strRep

inBounds = (pt) ->
    return (pt.x >= 0) and (pt.x < (g.getWidth!)) and (pt.y >= 0) and (pt.y < (g.getHeight!))

class Hunter extends Entity
    new: (startX, startY, tileSize) =>
        -- @frontier = {}
        @paths = {}
        @tileSize = tileSize
        super startX, startY, tileSize
    move:  =>
       -- if cd\move v.x, v.y, self
        newPos = @paths[pointToString @pos] 
        if nil != newPos
            @pos.x = newPos.x
            @pos.y = newPos.y
    search: (pt) =>
        frontier = Queue!
        cameFrom = {}
        frontier\add pt
        cameFrom[pointToString pt] = nil
        while frontier\length! != 0
            current = frontier\get!
            neighbors = {{x: current.x + @tileSize, y: current.y}, {x: current.x, y: current.y + @tileSize}, {x: current.x - @tileSize, y: current.y}, {x: current.x, y: current.y - @tileSize}}
            for i,pos in ipairs neighbors
                -- print "Searching: ", pointToString pos
                if (nil == cameFrom[pointToString pos])
                    if (inBounds pos)
                        frontier\add pos
                        cameFrom[pointToString pos] = current
        @paths = cameFrom
        -- return cameFrom
    step: (plyr) =>
        self\search plyr.pos
        self\move!
    draw: =>
        super\draw {255, 0, 0}
{
    :Entity,
    :Box1,
    :Box2,
    :Box3,
    :Wall,
    :BoxControl,
    :Exit,
    :Hunter
}
