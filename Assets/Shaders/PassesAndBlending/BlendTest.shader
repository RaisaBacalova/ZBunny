Shader "Holistic/BlendTest" {

Properties {
	_MainTex ("Texture", 2D) = "black" {} //the object is fully transparent, you cannot see the texture
}
Subshader {
	Tags {"Queue" = "Transparent"}
	
	//Blend One One
	//Blend SrcAlpha OneMinusSrcAlpha
	//Blend DstColor Zero
	Blend DstColor One
	Pass {
		SetTexture [_MainTex] {combine texture}
	}
}
}