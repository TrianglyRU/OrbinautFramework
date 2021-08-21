// Negative shader

	varying vec2 v_vTexcoord;
	varying vec4 v_vColour;
	
	uniform bool u_type;
	
	void main()
	{
		// Input colour
		vec4 Col = texture2D(gm_BaseTexture, v_vTexcoord);
		
		// Change colour
		if (u_type)
		{
			// Negate
			Col.rgb = vec3(1. - Col.rgb);
		}
		else
		{
			// Replace black with white
			if (Col.rgb == vec3(0.))
			{
				Col.rgb = vec3(1.);
			}
		}
		
		// Result colour
	    gl_FragColor = Col * v_vColour;
	}
