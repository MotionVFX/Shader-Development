Shader "04 Shader Lessons/26_DZ"
{
    Properties
    {
        _diffuse ("Diffuse", 2D) = "white" { }
        _RimColor ("Rim Color", Color) = (0, 0.5, 0.5, 0.0)
        _RimPower ("Rim Power", Range(0.5, 8.0)) = 3.0
    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _diffuse;

        struct Input
        {
            float2 uv_diffuse;
            float3 viewDir;
            float3 worldPos;
        };

        float4 _RimColor;
        float _RimPower;

        void surf(Input IN, inout SurfaceOutput o)
        {
            half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
            o.Albedo = tex2D(_diffuse, IN.uv_diffuse).rgb;
            o.Emission = frac(IN.worldPos.x * 2 * 0.5) > 0.5 ? float3(1, 0, 0) * rim : float3(0, 1, 0) * rim;
        }

        ENDCG
    }

    FallBack "Diffuse"
}