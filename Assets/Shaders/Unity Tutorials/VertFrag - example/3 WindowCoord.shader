// http://docs.unity3d.com/Documentation/Components/SL-VertexFragmentShaderExamples.html
//
// Window Coordinates
// This Shader defines a static color depending on the pixel coordinate of the window.
// This allows the definition of colors in the screen independent of the geometry
// rendered. If you move the plane you can see the colors don't change on the screen,
// only the visibility depending on the position of the geometry.
Shader "!Unity Tutorials/Vertex&Fragment: !Example/3 Window Coordinates" {
	SubShader {
		Pass {
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			
			// pragma target 3.0
			// The target directive defines the hardware requirements to support the
			// shader.
			#pragma target 3.0

			// include "UnityCG.cginc"
			// Include the file "UnityCG.cginc" inside the code of the shader.
			#include "UnityCG.cginc"

			// appdata_base v
			// Defines a default structure of Unity to set the input variables of the
			// vertex shaders.
			float4 vert(appdata_base v) : POSITION {
				return mul (UNITY_MATRIX_MVP, v.vertex);
			}

			// WPOS
			// Input argument for the frag function, which is declared as a float4 type
			// and WPOS semantics. Semantics is an special clause of Cg to define the
			// default input values of a fragment/vertex Shader. WPOS fills the variable
			// with the values of the pixel coordinates in the screen of the rendered
			// shader. This position needs to be divided by the screen size, the values
			// are transformed into 0 and 1 values so they can be mapped as the RG
			// components of the output color.
			fixed4 frag(float4 sp:WPOS) : COLOR {
			
				// ScreenParams
				// The screen width and height values are stored in the variable 
				//_ScreenParams; this variable is declared in the UnityCG.cginc file.
				return fixed4(sp.xy/_ScreenParams.xy,0.0,1.0);
			}

			ENDCG
		}
	}
}
