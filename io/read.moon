mapping = {
    "c": "BoxControl",
    "1": "Box1",
    "2": "Box2",
    "3": "Box3",
    ".": "Floor",
    "w": "Wall",
    "p": "Player",
    "e": "Exit",
    "h": "Hunter"
}

class Reader
    new: (handle) =>
        fileName = "io/level.txt"
        if handle != nil
           fileName = handle
        @f = assert (io.open fileName, "r")
        @l = ""
        @levels = {}
    read: =>
        @l = @f\read!
        level = {}
        failure = false
        lineLen = #@l
        y = -1
        while @l != nil
            -- print #@l
            if 0 == #@l
                if #level != 0
                    table.insert @levels, level
                    level = {}
                    y = -1
            else
                y = y + 1
            -- loop through characters in line
            for x = 0,#@l - 1
                c = @l\sub x+1, x+1
                --print c
                t = mapping[c]
                table.insert level, {t, x, y}
            -- read the next line
            @l = @f\read!
            if @l != nil and #@l != 0 and #@l != lineLen
                -- print #@l
                failure = true
                break
        @f\close!
        if #level != 0
            table.insert @levels, level
        if failure
            return false
        else
            return {{xDim: lineLen, yDim: y },@levels}
    print: =>
        for i in *@levels
            for j in *i
                print "Type: ", j[1], " X: ", j[2], " Y: ", j[3]


-- r = Reader "level.txt"
-- res = r\read!
-- print #res[2]
-- print #res[2][2]
-- r\print!
-- print "xDim: ", res[1].xDim, " yDim: ", res[1].yDim

{
    :Reader
}
