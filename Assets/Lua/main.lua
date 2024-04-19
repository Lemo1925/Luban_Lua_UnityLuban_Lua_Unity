

function LuaStart()
    print("Lua Start")
    local cube = luaCore:FindObject("Cube")
    local cube2 = luaCore:FindObject("Cube2")
    local collider = ColliderHelper:GetHelper(cube)
    local cube2Helper = ColliderHelper:GetHelper(cube2)
    ColliderHelper:BindCollider(collider, TriggerEnter, TriggerStay, CollisionExit)
    ColliderHelper:BindTrigger(cube2Helper, TriggerEnter, TriggerStay, TriggerExit)

    DataLoader:Tick()
end

function LuaUpdate()
    print("Lua Update")
end


--@region collider
function CollisionEnter(collision)
    print(string.format("CollisionEnter, %s",collision.gameObject.name))
end

function CollisionStay(collision)
    print(string.format("CollisionStay, %s",collision.gameObject.name))
end

function CollisionExit(collision)
    print(string.format("CollisionExit, %s",collision.gameObject.name))
end
--@endregion

--@region triiger
function TriggerEnter(other)
    print(string.format("TriggerEnter, %s", other.gameObject.name))
end

function TriggerStay(other)
    print(string.format("TriggerStay, %s", other.gameObject.name))
end

function TriggerExit(other)
    print(string.format("TriggerExit, %s", other.gameObject.name))
end
--@endregion
