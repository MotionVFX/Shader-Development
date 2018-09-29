Shader "08 Shader Lessons/049_Vertex_Extruding"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _MainTex ("Albedo (RGB)", 2D) = "white" { }
        _Extrude("Extrude", Range(-1,1)) = 0
    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert

        sampler2D _MainTex;
        fixed4 _Color;
        float _Extrude;

        struct Input
        {
            float2 uv_MainTex;
        };

        struct appdata
        {
            float4 vertex : POSITION;
            float3 normal : NORMAL;
            float4 texcoord : TEXCOORD0; 
        };

        void vert (inout appdata v){
            v.vertex.xyz += v.normal * _Extrude;
        }

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex) * _Color;
        }
        ENDCG
    }

    FallBack "Diffuse"
}