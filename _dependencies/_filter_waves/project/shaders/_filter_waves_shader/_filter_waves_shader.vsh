//
// Simple passthrough vertex shader
//
	attribute vec3 in_Position;         // (x,y,z)
	attribute vec4 in_Colour;           // (r,g,b,a)
	attribute vec2 in_TextureCoord;     // (u,v)
	
	varying vec2 v_vTexcoord;
	varying vec2 v_vPosition;
	varying vec4 v_vColour;
	
	void main() 
	{	
		gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position.xyz, 1.);
		v_vTexcoord = in_TextureCoord;
		v_vPosition = in_Position.xy;
		v_vColour   = in_Colour;
	}