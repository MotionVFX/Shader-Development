Shader "06 Shader Lessons/36_Holograms"
{
    Properties
    {
        _color ("Color", Color) = (1, 1, 1, 1)
        _range ("RimColor", Range(0, 8)) = 3
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Transparent"
        }

        Pass {
            ZWrite On
            ColorMask 0 
        }

        CGPROGRAM
        #pragma surface surf Lambert alpha:fade

        struct Input
        {
            float3 viewDir;
        };

        float4 _color;
        float _range;

        void surf(Input IN, inout SurfaceOutput o)
        {
            half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
            o.Emission = _color.rgb * pow(rim, _range) * 10;
            o.Alpha = pow(rim, _range);
        }
        ENDCG
    }

    FallBack "Diffuse"
}