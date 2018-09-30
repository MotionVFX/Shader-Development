Shader "08 Shader Lessons/052_Waves"
{
    Properties
    {
        _Tint ("Tint", Color) = (1, 1, 1, 1)
        _MainTex ("Albedo (RGB)", 2D) = "white" { }
        _Freg ("Freguency", Range(0, 5)) = 1
        _Speed ("Speed", Range(0, 100)) = 10
        _Amp ("Amplitude", Range(0, 1)) = 1
    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert

        struct Input
        {
            float2 uv_MainTex;
            float3 vertColor;
        };

        sampler2D _MainTex;
        float _Freg, _Speed, _Amp;
        fixed4 _Tint;

        struct appdata
        {
            float4 vertex : POSITION;
            float3 normal : NORMAL;
            float4 texcoord : TEXCOORD0;
            float4 texcoord1 : TEXCOORD1;
            float4 texcoord2 : TEXCOORD2;
        };

        void vert (inout appdata v, out Input o)
        {
            UNITY_INITIALIZE_OUTPUT(Input,o);
            float t = _Time * _Speed;
            float waveHeight = sin(t + v.vertex.x * _Freg) * _Amp;
            v.vertex.y = v.vertex.y + waveHeight;
            v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z));
            o.vertColor = waveHeight + 2;
        }

        void surf(Input IN, inout SurfaceOutput o)
        {
            float4 c = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = c * IN.vertColor.rgb;
        }
        ENDCG
    }

    FallBack "Diffuse"
}