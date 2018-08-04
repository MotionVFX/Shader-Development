Shader "VFX/20_Bumped_Environments"
{
    Properties
    {
        _diffuse ("My Diffuse", 2D) = "white" { }
        _bump ("My Bump", 2D) = "bump" { }
        _slider ("Bump Amount", Range(0, 10)) = 1
        _Eslider ("Emission", Range(0, 10)) = 1
        _Cube ("Cube Map", Cube) = "white" { }

    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _diffuse;
        sampler2D _bump;
        half _slider;
        half _Eslider;
        samplerCUBE _Cube;

        struct Input
        {
            float2 uv_diffuse;
            float2 uv_bump;
            float3 worldRefl; INTERNAL_DATA 
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = (tex2D(_diffuse, IN.uv_diffuse) * _Eslider).rgb;
            o.Normal = UnpackNormal(tex2D(_bump, IN.uv_bump));
            o.Normal *= float3(_slider, _slider, 1);
            o.Emission = texCUBE(_Cube, WorldReflectionVector(IN, o.Normal)).rgb;
        }
        ENDCG
    }

    FallBack "Diffuse"
}