// http://docs.unity3d.com/Documentation/Components/SL-VertexFragmentShaderExamples.html
//
// Simple Shader
// The difference between vertex and fragment shaders is the process developed in the
// render pipeline. Vertex shader could be define as the shader programs that modifies
// the geometry of the scene and made the 3D projection. Fragment shaders are related to
// the render window and defines the color for each pixel. Fragment and Vertex shader
// can present more functionality in new graphics cards like moving the vertex position
// or storing more data for each pixel.

Shader "!Unity Tutorials/Vertex&Fragment: !Example/2 SolidColor" {
	SubShader {
		Pass {
			CGPROGRAM

			// pragma vertex vert
			// Vertex Shader is a shader program to modify the geometry of the scene.
			// It is executed for each vertex in the scene, and outputs are the
			// coordinates of the projection, color, textures and other data passed to
			// the fragment shader. The directive #pragma vertex [function name] is
			// used to define the name of the vertex function.
			#pragma vertex vert
			
			// pragma fragment frag
			// Fragment Shader is a shader program to modify image properties in the
			// render window. It is executed for each pixel and the output is the color
			// info of the pixel. The directive #pragma fragment define the name of the
			// function of the fragment shader.
			#pragma fragment frag

			// float4 vert(float4 v:POSITION) : SV_POSITION
			// The variable v contains the values for the vertex, this function is
			// called for each vertex of the scene rendered. The returned value is a
			// float4 variable with the position of the vertex in the screen, the use
			// of four float values to store a SV_POSITION coordinate in a 2D window is
			// because the geometry of the projection is expected in homogeneous
			// coordinates which use two values for the pixel in the screen (x,y), one
			// value for the depth (z), and one value for the homogeneous space (w).
			// You can transform homogeneous coordinates into 3D coordinates, but you
			// will lose the ability to obtain the 3D position of the vertex in the
			// future; also you can delete the z value, but you will lose the ability
			// to perform depth testing in the final rendering. The homogeneous
			// coordinates are used in almost all GPUs. Eliminating variables of the
			// vertex shader output shaders doesn't represent any optimization of the
			// code, instead making the code less generic and more difficult to
			// understand.
			float4 vert(float4 v:POSITION) : SV_POSITION
			{

				// return mul (UNITY_MATRIX_MVP, v.vertex);
				// This is the core of the vertex function, where a coordinate in 3D is
				// projected into a 2D window. The process involves multiplying the 3D
				// position with a matrix know as Model-View-Projection
				return mul (UNITY_MATRIX_MVP, v);
			}

			// fixed4 frag() : COLOR
			// This line defines the function frag, which is going to be used by the
			// fragment shader as its main function. In this lesson, there are no input
			// parameters for the fragment function, and the output is defined as a
			// COLOR value defined in a fixed4 variable that contains the RGBA (red,
			// green, blue, alpha) of the color. It's possible to use the color as a
			// visualization of a float variable, or even to pass information between
			// the vertex and fragment shaders. However the COLOR variable its clamped
			// between the values 0 and 1 so Its expected a change of the values in the
			// COLOR variable.
			fixed4 frag() : COLOR {
			
				// return fixed4(1.0,0.0,0.0,1.0);
				// Fragment function core functionality, where for each pixel processed
				// in the fragment shader a color red is defined.
				return fixed4(1.0,0.0,0.0,1.0);
			}

			ENDCG
		}
	}
}
