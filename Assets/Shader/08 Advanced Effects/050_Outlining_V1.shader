Shader "08 Shader Lessons/050_Outlining_V1"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _MainTex ("Albedo (RGB)", 2D) = "white" { }
        _OutlineColor ("Outline Color", Color) = (1, 1, 1, 1)
        _Outline ("Outline", Range(-0.4, 0.4)) = 0
    }

    
    SubShader
    {
        Tags {"Queue" = "Transparent"}
        ZWrite Off 
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert

        struct Input
        {
            float2 uv_MainTex;
        };

        float _Outline;
        fixed4 _OutlineColor;

        void vert(inout appdata_full v)
        {
            v.vertex.xyz += v.normal * _Outline;
        }

        sampler2D _MainTex;

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Emission = _OutlineColor;
        }
        ENDCG

        ZWrite On
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        fixed4 _Color;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex) * _Color;
        }
        ENDCG
    }

    FallBack "Diffuse"
}