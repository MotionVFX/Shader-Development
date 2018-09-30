﻿Shader "08 Shader Lessons/051_Glass"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" { }
        _BumpMap ("Normalmap", 2D) = "bump" { }
        _ScaleUV ("Scale UV", Range(0, 30)) = 1
    }

    SubShader
    {
        Tags{"Queue" = "Transparent"}
        //Cull Off 
        GrabPass{}
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 uvgrab : TEXCOORD1;
                float2 uvbump : TEXCOORD2;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex, _BumpMap, _GrabTexture;
            float4 _MainTex_ST, _BumpMap_ST, _GrabTexture_TexelSize;
            float _ScaleUV;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uvgrab.xy = (float2(o.vertex.x, - o.vertex.y) + o.vertex.w) * 0.5;
                o.uvgrab.zw = o.vertex.zw;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.uvbump = TRANSFORM_TEX(v.uv, _BumpMap);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                half2 bump = UnpackNormal(tex2D(_BumpMap, i.uvbump)).rg;
                float2 offset = bump * _ScaleUV * _GrabTexture_TexelSize.xy;
                i.uvgrab.xy = offset * i.uvgrab.z + i.uvgrab.xy;

                fixed4 col = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(i.uvgrab));
                fixed4 tint = tex2D(_MainTex,i.uv);
                col *= tint;
                return col;
            }
            ENDCG
        }
    }
}