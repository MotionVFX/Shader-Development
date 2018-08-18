Shader "VFX/40_Stencil_Buffer_1"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "black" { }
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Geometry-1"
        }

        ColorMask 0
        ZWrite Off

        Stencil { Ref 1 Comp always Pass replace }

        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            fixed4 a = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = a.rgb;

        }
        ENDCG
    }

    FallBack "Diffuse"
}