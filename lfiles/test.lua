local CollisionDetector
CollisionDetector = require("collision_detector").CollisionDetector
local cd = CollisionDetector(10, 10)
local e = {
  pos = {
    x = 10,
    y = 10
  }
}
print(cd:collision(10, 10))
cd:move(e, 10, 10)
local ne = cd:collision(10, 10)
return print(tostring(ne[1]) .. " and somethi" .. tostring(ne[2]))
