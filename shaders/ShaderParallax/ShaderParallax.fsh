// ================================= //
	/* Parallax Scrolling Shader
	         by MicG            */
// ================================= //
	
	varying vec2 v_vTexcoord;
	varying vec2 v_vPosition;
	varying vec4 v_vColour;
	
	uniform vec2  o_pos;
	uniform float x_ofst;
	uniform float wid;
	uniform float power;
	uniform float y_height;
	uniform float y_step;
	uniform float texel;
	
	void main() 
	{	
		float CrntX  = v_vPosition.x - o_pos.x;
		float CrntY  = v_vPosition.y - o_pos.y;
		float OutX   = mod(floor(x_ofst * (y_height > 0. ? 1. + ceil((CrntY - 1.) / y_height) * y_step : 1.)) + CrntX, wid) - CrntX;
		vec2  OutPos = vec2(v_vTexcoord.x + OutX * texel, v_vTexcoord.y);
	    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, OutPos);
	}