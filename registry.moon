class Registry
    new: =>
        @objs = {
          "Box1": {},
          "Box2": {},
          "Box3": {},
          "BoxControl": {},
          "Exit": {},
          "Player": {},
          "Hunter": {}
        }
    register: (gameEntity) =>
        table.insert @objs[gameEntity.__class.__name], gameEntity
        if gameEntity.__class.__name != "Exit" 
            cd\add gameEntity


{
    :Registry
}
