// http://docs.unity3d.com/Documentation/Components/SL-VertexFragmentShaderExamples.html
//
// Texture Coordinates
// This lesson presents a set of shaders which use texture coordinates to draw the faces
// of a mesh with different effects.
//
// Texture position in a mesh is given by the variable texcoord0, which is set for each
// vertex. The vertex and fragment shader can modify this variable. You should select in
// which shader you modify texcoord0, depending of the variables needed for the
// operation, the number of vertex in the scene and the screen resolution. You should
// select the modification of texcoord0 values looking for the smallest number of
// executions.
//
// The range of the values of texcoord0 is from 0 to 1 and are mapped to a specific
// texture. Textures are images store in the memory of the GPU representing a square or
// rectangular image, the textures in the fragment shader can be also used as procedural
// textures which uses mathematical functions to define the color of each pixel in the
// screen. In the code below the texcoord0 values where used to set the colors of
// the Red and Green channels, given a gradient effect for each color.
Shader "!Unity Tutorials/Vertex&Fragment: !Example/7 Texture Coordinates" {
	SubShader {
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0

			#include "UnityCG.cginc"

			struct vertexInput {
				float4 vertex : POSITION;
				float4 texcoord0 : TEXCOORD0;
			};

			struct fragmentInput{
				float4 position : SV_POSITION;
				float4 texcoord0 : TEXCOORD0;
			};

			fragmentInput vert(vertexInput i){
				fragmentInput o;
				o.position = mul (UNITY_MATRIX_MVP, i.vertex);
				o.texcoord0 = i.texcoord0;
				return o;
			}
			float4 frag(fragmentInput i) : COLOR {
				return float4(i.texcoord0.xy,0.0,1.0);
			}
			ENDCG
		}
	}
}
