Shader "06 Shader Lessons/38_Culling"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "black" { }
    }

    SubShader
    {
        Tags {"Queue" = "Transparent"}
        Blend SrcAlpha OneMinusSrcAlpha
        Cull  Off 
        Pass 
        {
            SetTexture [_MainTex] { combine texture }
        }
    }
}