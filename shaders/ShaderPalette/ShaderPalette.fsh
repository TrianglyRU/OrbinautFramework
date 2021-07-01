// ================================= //
	 /* Palette Shader by MicG */
// ================================= //

	varying vec2 v_vTexcoord;
	varying vec4 v_vColour;
	varying vec2 v_vPosition;

	uniform sampler2D u_palTexture;
	uniform vec4 u_Uvs;
	uniform float u_palId[64];	// Max colours on the palette list. Increase if needed
	uniform vec2 u_pixelSize;

	uniform float u_step;
	uniform bool u_mode;
	uniform int u_color;

	vec4 findAltColor(vec4 inCol, vec2 corner) 
	{
	    vec2 testPos;
	    for (float i = corner.y; i < u_Uvs.w; i += u_pixelSize.y) 
		{
			testPos = vec2(corner.x, i);
			if (distance(texture2D(u_palTexture, testPos), inCol) == 0.) 
			{
				float Index = u_palId[int((i - corner.y) / u_pixelSize.y)];
				testPos = vec2(corner.x + u_pixelSize.x * floor(Index + 1.), i);
				return mix(texture2D(u_palTexture, vec2(testPos.x - u_pixelSize.x, testPos.y)), texture2D(u_palTexture, testPos), fract(Index));
			}
	    }
	    return inCol;
	}

	void main()
	{
	
		vec4 col = texture2D(gm_BaseTexture, v_vTexcoord);
		DoAlphaTest(col);

		// Output
		gl_FragColor = findAltColor(col, u_Uvs.xy) * v_vColour;
	}