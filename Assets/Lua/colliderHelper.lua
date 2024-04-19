ColliderHelper = ColliderHelper or {}
--@region
local Helper = CS.ColliderHelper
--@endregion

function ColliderHelper:GetHelper(GameObject)
    return Helper.Get(GameObject)
end

--- OnCollisionEnter,OnCollisionStay,OnCollisionExit
function ColliderHelper:BindCollider(helper, ...)
    if helper == nil then return end
    local args = {...}
    helper.luaCollisionEnter = args[1]
    helper.luaCollisionStay = args[2]
    helper.luaCollisionExit = args[3]
end

--- OnTriggerEnter,OnTriggerStay,OnTriggerExit
function ColliderHelper:BindTrigger(helper, ...)
    if helper == nil then return end
    local args = {...}
    helper.luaTriggerEnter = args[1]
    helper.luaTriggerStay = args[2]
    helper.luaTriggerExit = args[3]
end