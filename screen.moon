{graphics: g} = love

class Screen
    -- color is specified as a tuple with 3 members
    -- header is the "title" or largest text on the page
    -- body is the other text on the page
    new: (header, body, color) =>
        @header = header
        @body = body
        @color = color
    draw: =>
        g.setColor @color[1], @color[2], @color[3]
        g.rectangle "fill", 0, 0, g.getWidth!, g.getHeight! 
        g.setColor 255, 255, 255
        g.print @header, g.getWidth! / 2, g.getHeight! / 2,  0, 4, 4 
        g.print @body, g.getWidth! / 2, (g.getHeight! / 2) + 100, 0, 2, 2 


{
    :Screen
}
