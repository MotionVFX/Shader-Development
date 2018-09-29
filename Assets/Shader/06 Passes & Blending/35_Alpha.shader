Shader "06 Shader Lessons/35_Alpha"
{
    Properties
    {
        _Tex ("Texture", 2D) = "white" { }
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Transparent"
        }

        CGPROGRAM
        #pragma surface surf Lambert alpha:fade

        sampler2D _Tex;
        struct Input
        {
            float2 uv_Tex;

        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            //fixed4 c = tex2D(_Tex, IN.uv_Tex);
            o.Albedo = tex2D(_Tex, IN.uv_Tex).rgb;
            o.Alpha = tex2D(_Tex, IN.uv_Tex).a;
        }
        ENDCG
    }

    FallBack "Diffuse"
}