Shader "VFX/17_NormalEmission"
{
    Properties
    {
        _diffuse ("My Diffuse", 2D) = "white" { }
        _bump ("My Bump", 2D) = "bump" { }
        _slider ("Bump Amount", Range(0, 10)) = 1
        _Eslider ("Emission", Range(0, 10)) = 5

    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _diffuse;
        sampler2D _bump;
        half _slider;
        half _Eslider;

        struct Input
        {
            float2 uv_diffuse;
            float2 uv_bump;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = (tex2D(_diffuse, IN.uv_diffuse) * _Eslider).rgb;
            o.Normal = UnpackNormal(tex2D(_bump, IN.uv_bump));
            o.Normal *= float3(_slider, _slider, 1);
        }
        ENDCG
    }

    FallBack "Diffuse"
}