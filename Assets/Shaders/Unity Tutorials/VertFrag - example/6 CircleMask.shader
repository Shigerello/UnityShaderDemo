// http://docs.unity3d.com/Documentation/Components/SL-VertexFragmentShaderExamples.html
//
// Examples
// Window coordinates are not commonly used in shaders, because normally the shaders
// work with the position of the texture as you will see in the next lessons. However
// some interesting effects like Render with a Mask or some other image effects use this
// property.
//
// Circles Mask
// Some shaders need external information given in types like Variables, Arrays,
// Textures. These cases are cover by the use of uniforms and properties in ShaderLab.
// Properties define a set of type which can be passed to the shader in every run. The
// variables can modify the behavior of the shader, the following example show how to
// change the values of a shader mask full of circles, The number of rows and columns
// can be change also the size of the circles.
Shader "!Unity Tutorials/Vertex&Fragment: !Example/6 Circles Mask (Windows Coordinates)" {
	Properties {
		_CirclesX ("Circles in X", Float) = 40
		_CirclesY ("Circles in Y", Float) = 20
		_Fade ("Fade", Range (0.1,1.0)) = 0.5
	}
	SubShader {
		Pass {

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0

			#include "UnityCG.cginc"

			// uniform
			// ShaderLab define properties as values that are transfered from the
			// application to the shader. Properties are defined with different types
			// like Color, Float, 2D, and others. To use the properties values defined
			// into the shader the keyword uniform should be use declaring the
			// variables, so the compiler identify that variables as external values
			// which should be transferred to the shader in each execution.
			uniform float _CirclesX;
			uniform float _CirclesY;
			uniform float _Fade;

			float4 vert(appdata_base v) : POSITION {
				return mul (UNITY_MATRIX_MVP, v.vertex);
			}

			float4 frag(float4 sp:WPOS) : COLOR {
				float2 wcoord = sp.xy/_ScreenParams.xy;
				float4 color;
				if (length(fmod(float2(_CirclesX*wcoord.x,_CirclesY*wcoord.y),2.0)-1.0)<_Fade) {
					color = float4(sp.xy/_ScreenParams.xy,0.0,1.0);
				} else {
					color = float4(0.3,0.3,0.3,1.0);
				} 
				return color;
			}
			ENDCG
		}
	}
}
