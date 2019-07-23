Shader "Holistic/Wall" {
Properties{
		_MainTex("Deffuse", 2D) = "white" {}
		_MainNorm("Normal", 2D) = "normal" {}
	}
	SubShader{

		Tags{"Queue" = "Geometry"}

		
		Stencil {
			Ref 1
			Comp notequal
			Pass keep
		}

		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _MainNorm;

		struct Input {
			float2 uv_MainTex;
			float2 uv_MainNormal;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Normal = UnpackNormal(tex2D (_MainNorm, IN.uv_MainNormal));

		}
		ENDCG
	}
	FallBack "Diffuse"

}
