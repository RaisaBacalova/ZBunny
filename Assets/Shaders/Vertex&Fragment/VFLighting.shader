﻿Shader "Unlit/VFLighting"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{

		Pass
		{
			Tags{"LightMode" = "ForwardBase"}

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			#include "UnityLightingCommon.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal: NORMAL;
				float4 texcoord: TEXCOORD0;
			};

			struct v2f
			{
				float2 uv: TEXCOORD0;
				fixed4 diff: COLORO;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.texcoord;
				half3 worldNormal = UnityObjectToWorldNormal(v.normal); //converting normal from local space to world space
				half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz)); //_WorldSpaceLightPos0 gets from UnityLightingCommon file, holds the light position
				o.diff = nl * _LightColor0; //also from light file, holds the light color info
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
				col *= i.diff;
				return col;
			}
			ENDCG
		}
	}
}
