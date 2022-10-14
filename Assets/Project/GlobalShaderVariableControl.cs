using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class GlobalShaderVariableControl : MonoBehaviour
{
    //Color to pass to the global variable
    public Color GlobalColor;

    //Convert the _GlobalColor to a variable ID.
    private int shaderPropertyId = 
        Shader.PropertyToID("_GlobalColor");

    void Update()
    {
        /*shaderPropertyId is the ID of the _GlobalColor variable.
        It's more efficient since you'll use a int value instead
        of a string. String operations usually are more expensive.
        */
        Shader.SetGlobalColor(shaderPropertyId, GlobalColor);   
    }
}
