class Queue
    new: =>
        @inner = {}
    get: =>
        if #@inner > 0
            val = @inner[1]
            newInner = {}
            if #@inner > 1
                for i=2,#@inner
                    table.insert newInner, @inner[i]
            @inner = newInner
            return val
        else
            return nil
    add: (item) =>
        table.insert @inner, item
    length: =>
        return #@inner
  
{
    :Queue
}
