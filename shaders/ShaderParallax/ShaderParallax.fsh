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
	
	vec2  CurPos;
	vec2  OutPos;
	float RowX;
	float OutX;
	
	void main() 
	{	
		CurPos = v_vPosition - u_pos;
		OutX   = u_offset;
		if (u_ilHeight > 0.)
		{
			RowX = floor(CurPos.y / u_ilHeight / u_yScale);
			if (u_ilStep < 0.)
			{
				RowX += 1.;
			}
			OutX *= RowX * u_ilStep + 1.;
		}
		OutX = mod(OutX + CurPos.x, u_width) - CurPos.x;
		OutPos = vec2(v_vTexcoord.x + OutX * u_pixelSize, v_vTexcoord.y);

	    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, OutPos);
	}