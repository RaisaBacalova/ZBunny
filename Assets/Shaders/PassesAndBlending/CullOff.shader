Shader "Holistic/CullOff" {

Properties {
	_MainTex ("Texture", 2D) = "black" {} //the object is fully transparent, you cannot see the texture
}
Subshader {
	Tags {"Queue" = "Transparent"}
	
	Blend SrcAlpha OneMinusSrcAlpha
	Cull Off
	Pass {
		SetTexture [_MainTex] {combine texture}
	}
}
}