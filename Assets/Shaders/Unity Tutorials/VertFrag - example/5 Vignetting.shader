// http://docs.unity3d.com/Documentation/Components/SL-VertexFragmentShaderExamples.html
//
// Examples
// Window coordinates are not commonly used in shaders, because normally the shaders
// work with the position of the texture as you will see in the next lessons. However
// some interesting effects like Render with a Mask or some other image effects use this
// property.
//
// Vignetting

Shader "!Unity Tutorials/Vertex&Fragment: !Example/5 Vignetting (Windows Coordinates)" {
	SubShader {
		Pass {
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0

			#include "UnityCG.cginc"

			float4 vert(appdata_base v) : POSITION {
				return mul (UNITY_MATRIX_MVP, v.vertex);
			}

			float4 frag(float4 sp:WPOS) : COLOR {
				float2 wcoord = sp.xy/_ScreenParams.xy;
				float vig = clamp(3.0*length(wcoord-0.5),0.0,1.0);

				// lerp
				// Standard function of the Cg language, this function in particular is
				// a linear interpolation between the first two arguments given the
				// third as a factor. Many functions are implemented in the Cg language
				// as standard functions.
				return lerp (float4(wcoord,0.0,1.0),float4(0.3,0.3,0.3,1.0),vig);
			}
			ENDCG
		}
	}
}
