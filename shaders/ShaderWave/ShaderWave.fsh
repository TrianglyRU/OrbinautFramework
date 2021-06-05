// Simple passthrough fragment shader

	varying vec2 v_vTexcoord;
	varying vec2 v_vPosition;
	varying vec4 v_vColour;

	uniform float u_scrnHeight;
	uniform float u_texel;
	uniform float u_time;
	uniform float u_water;
	uniform float u_camY;
	
	void main()
	{
		vec2 OutPos = v_vTexcoord;
		if ((u_water != 0.) && (u_water >= u_scrnHeight - v_vPosition.y))
		{
			float wave = sin((v_vPosition.y + u_time + u_camY) / 28.);
			OutPos.x += max(0., abs(wave) * 100. - 97.) * sign(wave) * u_texel;
		}
		gl_FragColor = v_vColour * texture2D(gm_BaseTexture, OutPos);
	}
