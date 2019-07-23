Shader "Holistic/RimCutoff" 
{
	Properties {
	_RimColor ("Rim Color", Color) = (0, 0.5, 0.5, 0.0)
	_RimPower ("Rim Power", Range (0.5, 8.0)) = 3.0
	}

	Subshader {
	
		CGPROGRAM
		#pragma surface surf Lambert

		struct Input {
			float3 viewDir;
			float3 worldPos;
		};

		float4 _RimColor;
		float _RimPower;

		void surf (Input IN, inout SurfaceOutput o) {
			half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal)); 
			// gradient o.Emission = _RimColor.rgb * rim; 
			// no gradient o.Emission = _RimColor.rgb * pow(rim, _RimPower);
			//o.Emission = _RimColor.rgb * (rim > 0.5 ? rim: 0);
			//o.Emission = rim > 0.5 ? float3(1,0,0): 0; //red Rim
			//o.Emission = rim > 0.5 ? float3(1,0,0): rim > 0.3 ? float3(0,1,0): 0; // red & green rim
			//o.Emission = IN.worldPos.y > 1 ? float3(0,1,0): float3(1,0,0); //changes based on world position
			//o.Emission = frac(IN.worldPos.y * 10 * 0.5) > 0.4 ? float3(0,1,0): float3(1,0,0); // red & green strips. no depth
			o.Emission = frac(IN.worldPos.y * 10 * 0.5) > 0.4 ? float3(0,1,0) * rim: float3(1,0,0) * rim; //red & green strips with rim 
		}
		ENDCG
	}
	Fallback "Diffuse"
}