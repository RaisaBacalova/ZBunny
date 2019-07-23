Shader "MyShaders/Aniso2" {

Properties {
    _MainTint ("Diffuse Tint", Color) = (1,1,1,1)
    _MainTex ("Base (RGB)", 2D) = "white" {}
    _SpecularColor ("specular Color", Color) = (1,1,1,1)
    _Specular ("Specular Amount", Range(0,1)) = 0.5
    _SpecPower ("Specular Power", Range(0,1)) = 0.5
    _AnisoDir ("Anisotropic Direction", 2D) = "" {}
    _AnisoOffset ("Anisotropic Offset", Range(-1,1)) = -0.2
}

SubShader{

CGPROGRAM

sampler2D _MainTex;
sampler2D _AnisoDir;
float4 _MainTint;
float4 _SpecularColor;
float _AnisoOffset;
float _Specular;
float _SpecPower;

#pragma surface surf Anisotropic

struct SurfaceAnisoOutput
{
    fixed3 Albedo;
    fixed3 Normal;
    fixed3 Emission;
    fixed3 AnisoDirection;
    half Specular;
    fixed Gloss;
    fixed Alpha;
};


inline fixed4 LightingAnisotropic (SurfaceAnisoOutput s, fixed3 lightDir, half3 viewDir, fixed atten)
{
    fixed3 halfVector = normalize(normalize(lightDir) + normalize(viewDir));
    float NdotL = saturate(dot(s.Normal, lightDir));
    
    fixed HdotA = dot(normalize(s.Normal + s.AnisoDirection), halfVector);
    float aniso = max(0, sin(radians((HdotA + _AnisoOffset) * 180.f)));
    
    float spec = saturate(pow(aniso, s.Gloss * 128) * s.Specular);


    
    fixed4 c;
    c.rbg = ((s.Albedo * _LightColor0.rgb * NdotL) + (_LightColor0.rgb * _SpecularColor.rgb * spec)) * tan(atten * 2) * halfVector;
	//c.rbg += (_LightColor0.rgb * _SpecularColor2.rgb * spec * atten * 2);
    c.a = 1.0;
    return c;


}



struct Input  {
    float2 uv_MainTex;
    float2 uv_AnisoDir;
};

void surf (Input IN, inout SurfaceAnisoOutput  o) {
    // Albedo comes from a texture tinted by color
    fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _MainTint;
    float3 anisoTex = UnpackNormal(tex2D(_AnisoDir, IN.uv_AnisoDir));

    o.AnisoDirection = anisoTex;
    o.Specular = _Specular;
    o.Gloss = _SpecPower;
    o.Albedo = c.rgb;
    o.Alpha = c.a;
}

ENDCG

}
FallBack "Diffuse"

}