Shader "Holistic/DotProduct" 
{
	Subshader {
	
		CGPROGRAM
		#pragma surface surf Lambert

		struct Input {
			float3 viewDir;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			half dotp = dot(IN.viewDir, o.Normal); //1- dot... will give oposite result
			o.Albedo = float3(dotp, 1, 1);
		}
		ENDCG
	}
	Fallback "Diffuse"
}