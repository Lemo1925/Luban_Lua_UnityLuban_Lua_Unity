luaCore = luaCore or {}

--@region C#�����ֲ�����
local GameObject = CS.UnityEngine.GameObject
local Transform = CS.UnityEngine.Transform
--@endregion

function luaCore:FindObject(ObjectName)
    local obj = GameObject.Find(ObjectName)
    return obj
end