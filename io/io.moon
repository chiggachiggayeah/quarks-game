f = assert (io.open "level.txt", "w")
wall = "wwwwwwwwwwww\n"
mid = "w..........w\n"

f\write wall
for j = 1,10
    f\write mid
f\write wall
f\close        
