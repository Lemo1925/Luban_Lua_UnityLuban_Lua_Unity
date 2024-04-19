luaCore = luaCore or {}

--@region C#变量局部持有
local GameObject = CS.UnityEngine.GameObject
local Transform = CS.UnityEngine.Transform
--@endregion

function luaCore:FindObject(ObjectName)
    local obj = GameObject.Find(ObjectName)
    return obj
end