//
// Simple passthrough fragment shader
//
	varying vec2 v_vTexcoord;
	varying vec4 v_vColour;
	
	uniform bool u_type;
	
	void main()
	{
		vec4 Col = texture2D(gm_BaseTexture, v_vTexcoord);
		if (u_type)
		{
			Col.rgb = vec3(1. - Col.rgb);
		}
		else
		{
			if (Col.rgb == vec3(0.))
			{
				Col.rgb = vec3(1.);
			}
		}
	    gl_FragColor = Col * v_vColour;
	}
