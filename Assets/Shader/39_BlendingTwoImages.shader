Shader "VFX/39_BlendingTwoImages"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "black" { }
        _DecalTex ("Decal", 2D) = "black" { }
        _Multiplay("Multiplay", Range(0,1)) = 0.5
        [Toggle] _ShowDecal("Show Decal", Float) = 0
    }

    SubShader
    {
        Tags {"Queue" = "Geometry"}
        Blend SrcAlpha OneMinusSrcAlpha
        Cull  Off 
        Pass 
        {
            SetTexture [_MainTex] { combine texture }
        }

        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        sampler2D _DecalTex;
        half _Multiplay;
        float _ShowDecal;

        struct  Input
        {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout  SurfaceOutput o)
        {
            fixed4 a = tex2D(_MainTex, IN.uv_MainTex);
            fixed4 b = tex2D(_DecalTex, IN.uv_MainTex) * _ShowDecal;
            o.Albedo = b.g > _Multiplay ?  b.rgb : a.rgb;
            
        }
        ENDCG
    }
    FallBack "Diffuse"
}