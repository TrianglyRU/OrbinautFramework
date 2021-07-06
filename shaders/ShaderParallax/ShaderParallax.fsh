// ================================= //
	/* Parallax Scrolling Shader
	         by MicG            */
// ================================= //
	
	varying vec2 v_vTexcoord;
	varying vec2 v_vPosition;
	varying vec4 v_vColour;
	
	uniform vec2  o_pos;
	uniform vec2  scale;
	uniform float ofst;
	uniform float y_height;
	uniform float y_step;
	uniform float texel;
	 

	vec2 Crnt;
	
	void main() 
	{	
		Crnt.x = v_vPosition.x - o_pos.x;
		Crnt.y = v_vPosition.y - o_pos.y;
		float OutX  = mod(floor(ofst * (y_height > 0. ? 1. + ceil((Crnt.y - 1.) / y_height / scale.z) * y_step : 1.)) + Crnt.x, scale.x) - Crnt.x;
		vec2 OutPos = vec2(v_vTexcoord.x + OutX * texel, v_vTexcoord.y);
	    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, OutPos);
	}