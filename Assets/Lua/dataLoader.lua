DataLoader = DataLoader or {}

Application = CS.UnityEngine.Application
ByteBuf = CS.Luban.ByteBuf

local byteBufIns = ByteBuf()

local byteBufFuns = {
    readBool = byteBufIns.ReadBool,
    writeBool = byteBufIns.WriteBool,
    readByte = byteBufIns.ReadByte,
    writeByte = byteBufIns.WriteByte,
    readShort = byteBufIns.ReadShort,
    writeShort = byteBufIns.WriteShort,
    readFshort = byteBufIns.ReadFshort,
    writeInt = byteBufIns.WriteInt,
    readInt = byteBufIns.ReadInt,
    writeFint = byteBufIns.WriteFint,
    readFint = byteBufIns.ReadFint,
    readLong = byteBufIns.ReadLong,
    writeLong = byteBufIns.WriteLong,
    readFlong = byteBufIns.ReadFlong,
    writeFlong = byteBufIns.WriteFlong,
    readFloat = byteBufIns.ReadFloat,
    writeFloat = byteBufIns.WriteFloat,
    readDouble = byteBufIns.ReadDouble,
    WriteDouble = byteBufIns.WriteDouble,
    readSize = byteBufIns.ReadSize,
    writeSize = byteBufIns.WriteSize,
    readString = byteBufIns.ReadString,
    writeString = byteBufIns.WriteString,
    readBytes = byteBufIns.ReadBytes,
    writeBytes = byteBufIns.WriteBytes
}

function DataLoader:_read_file_all_bytes(fileName)
    local file = io.open(fileName, "rb")
    local bytes = file:read("*a")
    file:close()
    return bytes
end

function DataLoader:_ttostring2(x, result)
    local t = type(x)
    if t == "table" then
        table.insert(result, "{")
        for k, v in pairs(x) do
            table.insert(result, tostring(k))
            table.insert(result, "=")
            DataLoader:_ttostring2(v, result)
            table.insert(result, ",")
        end

        table.insert(result, "}")
    elseif t == "string" then
        table.insert(result, x)
    else
        table.insert(result, tostring(x))
    end
end

function DataLoader:ttostring(t)
    local out = {}
    DataLoader:_ttostring2(t, out)
    return table.concat(out)
end


---@param typeDef string
---@param configFileloader function
function DataLoader:Load(typeDef, configFileloader)
    local cfgPath = Application.dataPath .. "/GenerateDatas"

    self.enumDef = typeDef.enums
    self.constDef = typeDef.consts
    self.tables = {}
    
    local buf = ByteBuf()
    local tableDefs = typeDef.tables
    local beanDefs = typeDef.beans

    for _, t in pairs(tableDefs) do
        buf:Clear()
        print(cfgPath .. "/" .. t.file .. ".bytes")
        buf:WriteBytesWithoutSize(self:_read_file_all_bytes(cfgPath .. "/" .. t.file .. ".bytes"))
        
        local valueType = beanDefs[t.value_type]
        local mode = t.mode

        local tableDatas
        if mode == "map" then
            tableDatas = {}
            local index = t.index
            for i = 1, buf:ReadSize() do
                local v = valueType._deserialize(buf)
                tableDatas[v[index]] = v
            end
        else
            assert(buf:ReadSize() == 1)
            tableDatas = valueType._deserialize(buf)
        end
        print(DataLoader:ttostring(tableDatas))
        self.tables[t.name] = tableDatas
    end
end

---@param typeName string
---@param key string
function DataLoader:GetEnum(typeName, key)
    local def = self.enumDef[typeName]
    return key and def[key] or def
end

---@param typeName string
---@param field string
function DataLoader:GetConst(typeName, field)
    local def = self.constDef[typeName]
    return field and def[field] or constDefs
end

function DataLoader:GetData(tableName, key1, key2)
    local tableDatas = self.tables[tableName]
    if not key1 then
        return tableDatas
    end
    local value1 = tableDatas[key1]
    return key2 and value1[key2] or value1
end

function DataLoader:Tick()
    local cfgTypeDefs = require("Gen.schema").InitTypes(byteBufFuns)
    self:Load(cfgTypeDefs)
end