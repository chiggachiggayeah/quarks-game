class CollisionDetector
    new: (xdim, ydim, tileSize)=>
        @table = {}
        for x = 0,xdim
            @table[x*tileSize] = {}
            for y = 0,ydim
                @table[x*tileSize][y*tileSize] = false

    add: (thing) =>
        @table[thing.pos.x][thing.pos.y] = thing

    -- evaluate whether moving to new x (nx) and new y will result in a collision
    collision: (nx, ny) =>
        return @table[nx][ny]

    move: (nx, ny, ent) =>
        if not self\collision nx, ny
            @table[ent.pos.x][ent.pos.y] = false
            @table[nx][ny] = ent
            return true
        return false

{
  :CollisionDetector
}
