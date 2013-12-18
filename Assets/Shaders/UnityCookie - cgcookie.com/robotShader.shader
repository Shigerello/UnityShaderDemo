Shader "CGCookie.com UnityCookie/Robot" {
	Properties {
		_MainTex ("Diffuse (Gloss A)", 2D) = "white" {}
		_BumpMap ("Normal Map", 2D) = "bump" {}
		_IllumTex ("Illumination", 2D) = "white" {}
		_IllumPower ("Illumination Intensity", Range(0.001,2)) = 1
		//_SpecColor ("Specular Color", Color) = (1,1,1,1)
		_SpecPower ("Specular Power", Range(0.001, 1.0)) = 0.5
		_RimColor ("Rim Color", Color) = (0.26,0.19,0.16,0.0)
		_RimPower ("Rim Power", Range(0.5,8.0)) = 3.0
		_RimCP ("Rim Contrast Point", Range(0.0, 1.0)) = 0.5
		_RimCL ("Rim Contrast Level", Range(0.0, 10.0)) = 0.5
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		#pragma surface surf BlinnPhong
		#pragma target 3.0
		struct Input {
			float2 uv_MainTex; 
			float4 viewDir;
		};
		sampler2D _MainTex;
		sampler2D _BumpMap;
		sampler2D _IllumTex;
		float _IllumPower;
		float _SpecPower;
		float4 _RimColor;
		float _RimPower;
		float _RimCP;
		float _RimCL;

		void surf (Input IN, inout SurfaceOutput o) {
			// Generate a texture from 1st arg by sampling coordinates given by 2nd arg
			fixed4 IllumTex = tex2D(_IllumTex, IN.uv_MainTex); 
			fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
			// Albedo, also called "reflection coefficient" - how much will be reflected.
			o.Albedo = tex.rgb;
			o.Specular = _SpecPower; // fixed3 -> half?
			// Gloss - both specular and diffused reflection
			o.Gloss = tex.a; // requires #pragma target 3.0
			o.Normal = UnpackNormal( tex2D(_BumpMap, IN.uv_MainTex) );
			// saturate: clamp value within range of 0-1
			// rim will appear at the surpace where normal vector is
			// perpendicular to view direction vector.
			half rim = (((1-saturate(dot(normalize(IN.viewDir), o.Normal))) - _RimCP) * _RimCL) + _RimCP;
			o.Emission = ( _RimColor.rgb * pow(rim, _RimPower) + (IllumTex.rgb * _IllumPower), tex.a );
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
