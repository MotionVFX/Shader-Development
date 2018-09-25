Shader "VFX2/043_Ver_frag_Color"
{
    
	Properties
	{
		//_MainTex ("Texture", 2D) = "white" {}
		_Range ("Range", Range(-5,5)) = 0
	}
    SubShader
    {
        Tags
        {
            "RenderType" = "Opaque"
        }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                //float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                //float2 uv : TEXCOORD0;
                //UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
                float4 color : COLOR;
            };
            //sampler2D _MainTex;

            //float4 _MainTex_ST;
            float _Range;
            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.color.r = v.vertex.x * _Range;
                //o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                //UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                fixed4 col = i.color; // * _Range;
                // tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }
    }
}