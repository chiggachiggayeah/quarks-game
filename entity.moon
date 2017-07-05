{graphics: g} = love
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

    draw: =>
        g.setColor 255, 255, 255
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
        
-- else check if we have the kind of thing a box one can move and attempt to move it

class Box2 extends Box1

class Box3 extends Box1
    applyForce: (v) =>
        nx = @pos.x + v.x
        ny = @pos.y + v.y

        if not @cd\move nx, ny, self
             
            entity = cd.table[nx][ny]
            switch entity.__class.__name
                when "Box1"
                    entity\applyForce v
                when "Box2"
                    entity\applyForce v
        else
            super\applyForce v

    
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

class Exit extends Entity
    checkWin: (plyr)  =>
        return plyr.pos.x == @pos.x and plyr.pos.y == @pos.y
    draw: =>
        g.setColor 255, 255, 255
        g.rectangle "fill", @pos.x, @pos.y, @shape.w, @shape.h
{
    :Entity,
    :Box1,
    :Box2,
    :Wall,
    :BoxControl,
    :Exit
}
