Shader "CGCookie.com UnityCookie/FlatVertex" {
	Properties {
	}
	SubShader {
		Pass{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			/*
			 * Full members of input struct
			 * (http://docs.unity3d.com/Documentation/Components/SL-VertexProgramInputs.html)
			 *
			 * float4 vertex: the vertex position
			 * float3 normal: the vertex normal
			 * float4 texcoord: the first UV coordinate
			 * float4 texcoord1: the second UV coordinate
			 * float4 tangent: the tangent vector (used for normal mapping)
			 * float4 color: per-vertex color
 			 */
			struct vertexInput {
				float4 vertex : POSITION;
				float4 color : COLOR;
			};
			struct vertexOutput {
				float4 pos : SV_POSITION;
				float4 vertCol : COLOR;
			};

			// vertex function
			vertexOutput vert(vertexInput v) {
				vertexOutput o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.vertCol = v.color;
				return o;
			}
			
			// fragment function
			float4 frag(vertexOutput i) : COLOR
			{
				return i.vertCol;
			}
			ENDCG
		}
	}
	//FallBack "Diffuse"
}
