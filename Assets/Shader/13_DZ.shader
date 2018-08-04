Shader "VFX/13_DZ"
{

    Properties
    {
        _myRange ("My Range", Range(0, 5)) = 1
        _myTex ("My Texture", 2D) = "white" { }
    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        half _myRange;
        sampler2D _myTex;

        struct Input
        {
            float2 uv_myTex;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            float4 green = float4(0, 1, 0, 1);
            o.Albedo = (tex2D(_myTex, IN.uv_myTex) * _myRange).rgb; 
        }
        ENDCG
    }

    FallBack "Diffuse"
}