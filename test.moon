import CollisionDetector from require "collision_detector"

cd = CollisionDetector(10, 10)
e = {
  pos: {
    x: 10,
    y: 10
  }
}

print cd\collision 10, 10

cd\move e, 10, 10

ne = cd\collision 10, 10
print "#{ne[1]} and somethi#{ne[2]}"
