Shader "03 Shader Lessons/21_DZ"
{
    Properties
    {
        _bump ("My Bump", 2D) = "bump" { }
        _Cube ("Cube Map", Cube) = "white" { }
    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _bump;
        samplerCUBE _Cube;
        
        struct Input
        {

            float2 uv_bump;
            float3 worldRefl;
            INTERNAL_DATA
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = texCUBE(_Cube, WorldReflectionVector(IN, o.Normal)).rgb;
            o.Normal = UnpackNormal(tex2D(_bump, IN.uv_bump)) * 0.3;
        }
        ENDCG
    }

    FallBack "Diffuse"
}