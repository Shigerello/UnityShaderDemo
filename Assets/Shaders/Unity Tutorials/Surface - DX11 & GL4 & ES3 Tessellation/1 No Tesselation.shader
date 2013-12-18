// http://docs.unity3d.com/Documentation/Components/SL-SurfaceShaderTessellation.html
// Surface Shaders with DX11 Tessellation
// Page last updated: 2012-09-18
//
// Surface Shaders have some support for DirectX 11 GPU Tessellation. Idea is:
//
// * Tessellation is indicated by tessellate:FunctionName modifier. That function
// computes triangle edge and inside tessellation factors.
// * When tessellation is used, "vertex modifier" (vertex:FunctionName) is invoked
// after tessellation, for each generated vertex in the domain shader. Here you'd
// typically to displacement mapping.
// * Surface shaders can optionally compute phong tessellation to smooth model surface
// even without any displacement mapping.
// Current limitations of tessellation support:
//
// * Only triangle domain - no quads, no isoline tessellation.
// * When tessellation is used, shader is automatically compiled into Shader Model 5.0
// target, which means it will only work on DX11.


// No GPU tessellation, displacement in the vertex modifier
// Let's start with a surface shader that does some displacement mapping without using
// tessellation. It just moves vertices along their normals based on amount coming
// from a displacement map:
Shader "!Unity Tutorials/Surf: NextGen Tesselation Shader/1 No Tesselation" {
	Properties {
		_MainTex ("Base Texture (RGB)", 2D) = "white" {}
		_DispTex ("Displacement Map", 2D) = "gray" {}
		_NormalMap ("Normal Map", 2D) = "bump" {}
		_Displacement ("Displacement", Range(0, 1.0)) = 0.3
		_Color ("Color", color) = (1,1,1,0)
		_SpecColor ("Specular color", color) = (0.5,0.5,0.5,0.5)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 300
        
		CGPROGRAM
		// Since our vertex data does not have 2nd UV coordinate, we add nolightmap
		// directive to exclude lightmaps.
#pragma surface surf BlinnPhong addshadow fullforwardshadows vertex:disp nolightmap
#pragma target 5.0
        
		// It uses custom "vertex data input" structure (displaceOutput) instead of
		// default appdata_full. This is not needed yet, but it's more efficient for
		// tessellation to use as small structure as possible.
		struct displaceOutput {
			float4 vertex : POSITION;
			float4 tangent : TANGENT;
			float3 normal : NORMAL;
			float2 texcoord : TEXCOORD0; // used to be float4 (see UnityCG.cginc)
		};
        
		sampler2D _DispTex;
		float _Displacement;
        
		// Vertex modifier disp samples the displacement map and moves vertices along
		// their normals.
		void disp (inout displaceOutput v)
		{
			float d = tex2Dlod(_DispTex, float4(v.texcoord.xy,0,0)).r * _Displacement;
			v.vertex.xyz += v.normal * d;
		}
        
		struct Input {
			float2 uv_MainTex;
		};
        
		sampler2D _MainTex;
		sampler2D _NormalMap;
		fixed4 _Color;
        
		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Specular = 0.2;
			o.Gloss = 1.0;
			o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_MainTex));
		}
		ENDCG
	}
	FallBack "Diffuse"
}
