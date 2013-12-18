// http://docs.unity3d.com/Documentation/Components/SL-VertexFragmentShaderExamples.html
//
// Empty Shader
// This will explain the four main parts of a Shader in ShaderLab that
// you can see in the code.


// Shader
// The Shader command contains a string with the name of the Shader.
// This name can be subdivided with the "/" character simulating a folder
// structure, simplifying the future reutilization of the Shader. The
// name should be unique in all shaders.
Shader "!Unity Tutorials/Vertex&Fragment: !Example/1 Empty" {

	// SubShader
	// A Shader can contain one or more SubShaders, which are primarily
	// used to implement shaders for different GPU capabilities. All the
	// SubShaders should present similar results using different
	// techniques for each architecture. ShaderLab translates the code
	// of the shader automatically to other architectures, but in some
	// cases full functionality of the Shader in mobile architectures is
	// not desired or some inputs are missing, You are going to work
	// with a simple SubShader in the Shader and the lessons are
	// implemented for desktop architectures.
	SubShader {
	
		// Pass
		// Each SubShader is composed by a number of Passes, and each
		// Pass represents an execution of the Vertex and Fragment code
		// for the same object rendered with the Material of the Shader.
		// You should implement the shader with the smallest number of
		// Passes possible for performance reasons.
		Pass {
		
			// CGPROGRAM - ENDCG
			// These directives define in ShaderLab the language used
			// for the Shader. Unity can work with the shader languages
			// of Cg and GLSL. the Cg language is recommended, because
			// several optimization steps are implemented for the
			// different architectures.
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			float4 vert() : POSITION {return float4(0,0,0,0);}
			float4 frag(float4 pos : POSITION) : Color {return float4(0,0,0,0);} 
			ENDCG
		}
	}
}
