function generateVertices(w, h, num)
    if num % 4 ~= 1 then
        return false
    else
        v = {}
        segmentsPerSide = (num - 1) / 4
        widthStep = 0
        heightStep = 0
        for i=1,num do
            if i == 1 then
                -- center vertex
                table.insert(v, {w/2,h/2,0,0,255,255,255,255})
            end
        end
    end
end

-- mesh state: idle, left, up, right, down
function love.load()
    w, h = 100, 100
    windowWidth, windowHeight = love.graphics.getWidth(), love.graphics.getHeight()
    meshPos  = {}
    meshPos.x = 2 * w
    meshPos.y = 2 * h
    meshState = "IDLE"

    vertices = {
        {(w/2), (h/2), 0, 0, 255, 255, 255, 255},
        {0, 0, 0, 0, 255, 255, 255, 255},
        {w / 2, 0, 0, 0, 255, 255, 255, 255},
        {w, 0, 0, 0, 255, 255, 255, 255},
        {w, h / 2, 0, 0, 255, 255, 255, 255},
        {w, h, 0, 0, 255, 255, 255, 255},
        {w / 2, h, 0, 0, 255, 255, 255, 255},
        {0, h, 0, 0, 255, 255, 255, 255},
        {0, h / 2, 0, 0, 255, 255, 255, 255}
    }

    handles = {} 
    mesh = love.graphics.newMesh(vertices)
    mesh:setVertexMap(1,2,3,4,5,6,7,8,9,2)
end

local timestep = 0
local sign = 1
drawStep = 0

function vertexFn(m, vertices, obj)
    -- obj: {trigFn, tStep, mW, mH, vertex, vertexInd, ySign, xSign
    m:setVertex(o.vertexInd, vertices[o.vertexInd][1] + o.trigFn(o.tStep) * o.xSign * (o.mW / 2), o.trigFn(o.tStep) * o.ySign * (o.mH / 2), 0, 0, 255, 255, 255, 255)
end

-- you want to increase the move in the direction up the destination
function love.keyreleased(key)
    if meshState == "IDLE" then
        if key == "up" then
            meshState = "UP"
            --meshPos.y = meshPos.y - h
        elseif key == "right" then
            meshState = "RIGHT"
            --meshPos.x = meshPos.x + w
        elseif key == "down" then
            meshState = "DOWN"
            --meshPos.y = meshPos.y + h
        elseif key == "left" then
            meshState = "LEFT"
            --meshPos.x = meshPos.x - w
        end
    end
end

function easeMeshToBase(m, verts)
    for i,v in ipairs(verts) do
        local vx, vy = unpack(v) 
        local mx, my = mesh:getVertex(i)
        local meshConstant = 0.05
        if mx ~= vx or my ~= vy then
            mesh:setVertex(i, mx + (meshConstant * (vx - mx)), my + (meshConstant * (vy - my)), 0, 0, 255, 255, 255, 255)  
        end
    end
end

-- want to make the animation states transition into one another
function love.update(dt)
    drawStep = drawStep + dt
    if timestep > 5 then
        sign = sign * -1
    elseif timestep <= 0 then
        sign = sign * -1
    end

    local meshConstant = 0.05
    if meshState ~= "IDLE" then
        if meshState == "UP" then
            meshPos.y = meshPos.y - (meshConstant * h)
        elseif meshState == "RIGHT" then
            meshPos.x = meshPos.x + (meshConstant * w)
        elseif meshState == "LEFT" then
            meshPos.x = meshPos.x - (meshConstant * w)
        elseif meshState == "DOWN" then
            meshPos.y = meshPos.y + (meshConstant * h)
        end
    end

    if meshPos.x % w == 0 and meshPos.y % h == 0 and meshState ~= "IDLE" then
        meshState = "IDLE"
    end
-- timestep = timestep + (sign * dt * 5)
    
    timestep = timestep + dt
    local fn = nil
    local flip = nil
    local tmp = nil
    local ind = 1
    -- what you can do is set these to specific trigonometric functions based on the position of the vertex relative to the center.
    -- then you can maybe do some other things to mess with making everything look and feel more organic
    local yfn = nil
    local xfn = nil
    -- I want to figure out how to get this semi, procedural animation going on
    while ind <= #vertices do
        local x,y,u,v,r,g,b,a = mesh:getVertex(ind)
        local v = {x,y,u,v,r,g,b,a}
        -- do something with the center node. although, I don't have any ideas for anything to do with the center node yet
        if ind ~= 1 then 
        end
        -- get center mesh vertex
        local cx,cy,cu,cv,cr,cg,cb,ca = mesh:getVertex(ind)
        local cv = {cx,cy,cu,cv,cr,cg,cb,ca}

        if meshState == "IDLE" then
            if ind == 2 then
                mesh:setVertex(ind, math.cos(timestep) * w / 3,  math.cos(timestep) * h / 3, 0, 0, 255, 255, 255, 255)
                --vertexFn(mesh, vertices, {trigFn: , tStep: timestep, mW: w, mH: h, vertexInd: ind, xSign: 1, ySign: 1})
            elseif ind == 4 then
                mesh:setVertex(ind, vertices[4][1] + math.cos(timestep) * -(w/ 3), math.cos(timestep) * h / 3, 0, 0, 255, 255, 255, 255)
            elseif ind == 6 then
                mesh:setVertex(ind,vertices[6][1] + math.cos(timestep) * -(w / 3), vertices[6][2] + math.cos(timestep) * -(h / 3), 0, 0, 255, 255, 255, 255)
            elseif ind == 8 then
                mesh:setVertex(ind, vertices[8][1] + math.cos(timestep) * w / 3, vertices[8][2] + math.cos(timestep) * -(h / 3), 0, 0, 255, 255, 255, 255)
            elseif ind == 3 then
                mesh:setVertex(ind, vertices[ind][1], vertices[ind][2] + math.cos(timestep) * -(h / 4), 0, 0, 255, 255, 255, 255)
            elseif ind == 5 then
                mesh:setVertex(ind, vertices[ind][1] + math.cos(timestep) * (w / 4), vertices[ind][2], 0, 0, 255, 255, 255, 255)
            elseif ind == 7 then
                mesh:setVertex(ind, vertices[ind][1], vertices[ind][2] + math.cos(timestep) * (h / 4), 0, 0, 255, 255, 255, 255)
            elseif ind == 9 then
                mesh:setVertex(ind, vertices[ind][1] + math.cos(timestep) * -(w / 4), vertices[ind][2], 0, 0, 255, 255, 255, 255)
            end
        else
            -- do something to the vertices for each of the move states
            if math.abs(x - vertices[ind][1]) > 1 or math.abs(y - vertices[ind][2]) > 1 then
                easeMeshToBase(mesh, vertices)
            else
                if meshState == "UP" then
                    if ind == 3 then
                        mesh:setVertex(ind, vertices[ind][1], vertices[ind][2] - (w / 4), 0, 0, 255, 255, 255, 255)
                    elseif ind == 7 then
                        mesh:setVertex(ind, vertices[ind][1], vertices[ind][2] - (w), 0, 0, 255, 255, 255, 255)
                    else
                        mesh:setVertex(ind, vertices[ind][1], vertices[ind][2], 0, 0, 255, 255, 255, 255)
                    end
                elseif meshState == "RIGHT" then
                    if ind == 5 then
                        mesh:setVertex(ind, vertices[ind][1] + (w / 4), vertices[ind][2], 0, 0, 255, 255, 255, 255)
                    elseif ind == 9 then
                        mesh:setVertex(ind, vertices[ind][1] - (w), vertices[ind][2], 0, 0, 255, 255, 255, 255)
                    else
                        mesh:setVertex(ind, vertices[ind][1], vertices[ind][2], 0, 0, 255, 255, 255, 255)
                                        
                    end
                elseif meshState == "DOWN" then
                    if ind == 7 then
                        mesh:setVertex(ind, vertices[ind][1], vertices[ind][2] + (w / 4), 0, 0, 255, 255, 255, 255)
                    elseif ind == 3 then
                        mesh:setVertex(ind, vertices[ind][1], vertices[ind][2] - (w), 0, 0, 255, 255, 255, 255)
                    else
                        mesh:setVertex(ind, vertices[ind][1], vertices[ind][2], 0, 0, 255, 255, 255, 255)
                    end

                elseif meshState == "LEFT" then
                    if ind == 9 then
                        mesh:setVertex(ind, vertices[ind][1] - (w / 4), vertices[ind][2], 0, 0, 255, 255, 255, 255)
                    elseif ind == 5 then
                        mesh:setVertex(ind, vertices[ind][1] + (w), vertices[ind][2], 0, 0, 255, 255, 255, 255)
                    else
                        mesh:setVertex(ind, vertices[ind][1], vertices[ind][2], 0, 0, 255, 255, 255, 255)
                    end
                end
            end
        end
        ind = ind + 1
    end
    --timestep = 0
end

function love.draw()
    
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(mesh, meshPos.x, meshPos.y)
    for i,v in ipairs(vertices) do
        love.graphics.setColor(0, 255, 0)
        love.graphics.circle("fill", v[1] + (windowWidth / 2), v[2] + (windowHeight / 2), 5, 20)
        table.insert(handles, {v[1], v[2]})
    end
    -- love.graphics.circle("fill", windowWidth/2, (math.sin(drawStep) * 100) + windowHeight / 2, 5, 20)
end
