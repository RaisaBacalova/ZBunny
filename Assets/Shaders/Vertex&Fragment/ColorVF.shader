Shader "Unlit/ColorVF"
{
	
	SubShader
	{
		
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 color: COLOR;
			};

			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				//o.color.r = v.vertex.x; //sharp division of color
				//o.color.r = (v.vertex.x + 5); //moving the division
				//o.color.r = (v.vertex.x + 5) / 10; //creating a smooth devision/gradient from the 0 point (where the color appears)
				//o.color.g = (v.vertex.z + 5) / 10; //y coordinate doesn't exist in world space, this is world space
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target //i is what has been returned from appdata v function
			{
				// sample the texture
				fixed4 col;// = i.color; //add this if you're not working in this part //fixed4(0,1,0,1); //will make it complete green
				col.r = i.vertex.x/1000; //same effect as working in vertex part, but larger numbers because it's screen space
				col.g = i.vertex.y/1000; //z does not exist here, this part is less optimized, uses vert part + colors will move with the mesh
				return col;
			}
			ENDCG
		}
	}
}
