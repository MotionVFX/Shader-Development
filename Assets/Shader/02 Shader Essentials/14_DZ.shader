Shader "02 Shader Lessons/14_DZ"
{

    Properties
    {
        _diffuse ("My Diffuse", 2D) = "white" { }
        _emission ("My Emission()", 2D) = "white" { }
    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _diffuse;
        sampler2D _emission;

        struct Input
        {
            float2 uv_diffuse;
            float2 uv_emission;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_diffuse, IN.uv_diffuse).rgb;
            o.Emission = tex2D(_emission, IN.uv_emission).rgb; 
        }
        ENDCG
    }

    FallBack "Diffuse"
}