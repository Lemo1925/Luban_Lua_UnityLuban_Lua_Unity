using System;
using UnityEngine;


public class ColliderHelper : MonoBehaviour
{
    public Action<Collision> luaCollisionEnter, luaCollisionStay, luaCollisionExit;
    public Action<Collider> luaTriggerEnter, luaTriggerStay, luaTriggerExit;

    public static ColliderHelper Get(GameObject go)
    {
        ColliderHelper helper = go.GetComponent<ColliderHelper>() == null ? 
            go.AddComponent<ColliderHelper>():go.GetComponent<ColliderHelper>();
        return helper;
    }

    private void OnCollisionEnter(Collision collision) => luaCollisionEnter?.Invoke(collision);

    private void OnCollisionStay(Collision collision) => luaCollisionStay?.Invoke(collision);

    private void OnCollisionExit(Collision collision) => luaCollisionExit?.Invoke(collision);

    private void OnTriggerEnter(Collider other) => luaTriggerEnter?.Invoke(other);

    private void OnTriggerStay(Collider other) => luaTriggerStay?.Invoke(other);

    private void OnTriggerExit(Collider other) => luaTriggerExit?.Invoke(other);
}
