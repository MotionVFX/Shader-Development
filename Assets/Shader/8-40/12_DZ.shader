Shader "VFX/12_DZ"
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
            o.Albedo = (tex2D(_myTex, IN.uv_myTex) * _myRange).rgb;
            o.Albedo.g = 1;
        }
        ENDCG
    }

    FallBack "Diffuse"
}