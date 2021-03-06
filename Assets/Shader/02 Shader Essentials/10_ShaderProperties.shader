﻿Shader "02 Shader Lessons/10_AllProperties"
{

    Properties
    {
        _myColor ("My Color", Color) = (1, 1, 1, 1)
        _myRange ("My Range", Range(0, 5)) = 1
        _myTex ("My Texture", 2D) = "white" { }
        _myCube ("My Cube", Cube) = "" { }
        _myFloat ("My Float", Float) = 0.5
        _myVector ("My Vector", Vector) = (0.5, 1, 1, 1)
    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        fixed4 _myColor;
        half _myRange;
        sampler2D _myTex;
        samplerCUBE _myCube;
        float _myFloat;
        float4 _myVector;

        struct Input
        {
            float2 uv_myTex;
            float3 worldRefl;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = (tex2D(_myTex, IN.uv_myTex) * _myRange).rgb;

        }

        ENDCG
    }

    FallBack "Diffuse"
}