// http://docs.unity3d.com/Documentation/Components/SL-VertexFragmentShaderExamples.html
//
// Examples
// Window coordinates are not commonly used in shaders, because normally the shaders
// work with the position of the texture as you will see in the next lessons. However
// some interesting effects like Render with a Mask or some other image effects use this
// property.
//
// Behind bars

Shader "!Unity Tutorials/Vertex&Fragment: !Example/4 Behind Bars (Windows Coordinates)" {
	SubShader {
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			// struct vertOut
			// Defines a new type of variable, this is a compound type, which represent
			// a set of other variables with native or compound types. The struct is
			// used when more than a native data is needed to be pass from the vertex to
			// the fragment shader. As the return data of a function is only a variable,
			// with struct a set of values can be represented as an only value.
			struct vertOut {
				float4 pos : SV_POSITION;
				float4 scrPos : TEXCOORD2; // Giving TEXCOORD2 as a dummy semantics
			};

			vertOut vert(appdata_base v) {
				vertOut o;
				o.pos = mul (UNITY_MATRIX_MVP, v.vertex);

				// ComputeScreenPos
				// Function define in the UnityCG.cginc file, this functions return the
				// screen position for the fragment shader. The difference with the
				// previous example were a WPOS semantic variable was used, this
				// function is multiplatform and it does not need target 3.0.
				o.scrPos = ComputeScreenPos(o.pos);
				return o;
			}

			fixed4 frag(vertOut i) : COLOR0 {
				float2 wcoord = (i.scrPos.xy/i.scrPos.w);
				fixed4 color;

				if (fmod(20.0*wcoord.x,2.0)<1.0) {
					// Red & green tint
					color = fixed4(wcoord.xy,0.0,1.0);
				} else {
					// Gray
					color = fixed4(0.3,0.3,0.3,1.0);
				}
				return color;
			}

			ENDCG
		}
	}
}
