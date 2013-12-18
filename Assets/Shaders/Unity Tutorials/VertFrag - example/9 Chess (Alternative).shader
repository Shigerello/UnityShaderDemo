// http://docs.unity3d.com/Documentation/Components/SL-VertexFragmentShaderExamples.html
//
// Examples
// ChessOpt
Shader "!Unity Tutorials/Vertex&Fragment: !Example/9 Chess (Alternative)" {
	SubShader {
		Pass {
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag

			#include "UnityCG.cginc"

			float4 frag(v2f_img i) : COLOR {
				bool p = fmod(i.uv.x*8.0,2.0) < 1.0;
				bool q = fmod(i.uv.y*8.0,2.0) > 1.0;
				bool val = (p && q) || !(p || q);
				return float4(float3(val,val,val),1.0);
			}
			ENDCG
		}
	} 
}
