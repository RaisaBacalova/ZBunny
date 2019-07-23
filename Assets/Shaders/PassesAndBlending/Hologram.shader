Shader "Holistic/Hologram" {
Properties{
		_RimColour("Rim Colour", Color) = (0, 0.5, 0.5, 0.0)
		_RimPower("Rim Power", Range(0.5, 8.0)) = 3.0
	}
	SubShader{

		Tags{"Queue" = "Transparent"}

		Pass {
			ZWrite On 
			ColorMask 0 //Depth data only, we don't see through but transparent. Write RGB to see the color
		}

		CGPROGRAM
		#pragma surface surf Lambert alpha:fade

		float4 _RimColour;
		float _RimPower;

		struct Input {
			float3 viewDir;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			half rim = 1.0 - saturate(dot (normalize (IN.viewDir), o.Normal)); //1.0 - outside edges
			o.Emission = _RimColour.rgb * pow(rim, _RimPower) * 10;
			o.Alpha = pow(rim, _RimPower);
		}
		ENDCG
	}
	FallBack "Diffuse"

}
