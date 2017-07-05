class Registry
    new: =>
        @objs = {
          "Box1": {},
          "Box2": {},
          "BoxControl": {},
          "Exit": {},
          "Player": {}
        }
    register: (gameEntity) =>
        table.insert @objs[gameEntity.__class.__name], gameEntity
        if gameEntity.__class.__name != "Exit" 
            cd\add gameEntity


{
    :Registry
}
