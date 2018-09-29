Shader "02 Shader Lessons/08_PackedPractice" {
	
	Properties {
		_myColor("Color", Color) = (1,1,1,1)
	}

	SubShader {

		CGPROGRAM 
		#pragma surface surf Lambert

		struct Input {
			float3 viewDir;
		};

		float4 _myColor;

		void surf (Input IN, inout SurfaceOutput o){
			o.Albedo = _myColor.rgb;
		}

		ENDCG
	}

	FallBack "Diffuse"
}
