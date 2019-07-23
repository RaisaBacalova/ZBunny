Shader "Holistic/PBRStandard" {
Properties{
		_Color("Color", Color) = (1,1,1,1)
		_MetallicTex("Metallic (R)", 2D) = "white" {}
		_Metallic("Metallic", Range(0.0, 1.0)) = 0.0
		_mySlider ("Emission", Range(0, 10)) = 1
	}
	SubShader{
		Tags{
			"Queue" = "Geometry"
		}


		CGPROGRAM
		#pragma surface surf Standard

		float4 _Color;
		sampler2D _MetallicTex;
		half _Metallic;
		half _mySlider;

		struct Input {
			float2 uv_MetallicTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o) {
			o.Albedo = _Color.rgb;
			o.Smoothness = tex2D (_MetallicTex, IN.uv_MetallicTex).r; //* _mySlider;
			o.Metallic = _Metallic;
			o.Emission = tex2D (_MetallicTex, IN.uv_MetallicTex).r * _mySlider;
		}
		ENDCG
	}
	FallBack "Diffuse"

}
