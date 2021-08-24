//
// Parallax shader
//
	varying vec2 v_vTexcoord;
	varying vec2 v_vPosition;
	varying vec4 v_vColour;
	
	uniform vec2  u_pos;	   
	uniform float u_width;	   
	uniform float u_yScale;   
	uniform float u_offset;	 
	uniform float u_ilHeight; 
	uniform float u_ilStep;	   
	uniform float u_pixelSize; 
	
	void main() 
	{	
		vec2  Crnt   = v_vPosition - u_pos;
		float OutX   = mod(floor(u_offset * (u_ilHeight > 0. ? 1. + ceil((Crnt.y - 1.) / u_ilHeight / u_yScale) * u_ilStep : 1.)) + Crnt.x, u_width) - Crnt.x;
		vec2  OutPos = vec2(v_vTexcoord.x + OutX * u_pixelSize, v_vTexcoord.y);

	    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, OutPos);
	}