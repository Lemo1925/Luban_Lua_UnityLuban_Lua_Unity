using System;
using System.IO;
using UnityEngine;
using XLua;
using Luban;

public class LuaManager : MonoBehaviour
{
    private LuaEnv _luaEnv;

    public static Action luaStart, luaUpdate;

    private void Awake()
    {
        _luaEnv = new LuaEnv();
        _luaEnv.AddLoader(CuteLoader);
        _luaEnv.DoString("require 'Main'");
        _luaEnv.DoString("require 'luaCore'");
        _luaEnv.DoString("require 'colliderHelper'");
        _luaEnv.DoString("require 'dataLoader'");

        luaStart = _luaEnv.Global.Get<Action>("LuaStart");
        luaUpdate = _luaEnv.Global.Get<Action>("LuaUpdate");   
    }

    private byte[] CuteLoader(ref string filepath) =>
        File.ReadAllBytes(Application.dataPath + "/Lua/" + filepath.Replace('.', '/') + ".lua");

    // Start is called before the first frame update
    void Start() => luaStart?.Invoke();

    // Update is called once per frame
    void Update() => luaUpdate?.Invoke();
}
