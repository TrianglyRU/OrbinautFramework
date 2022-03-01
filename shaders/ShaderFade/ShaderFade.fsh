//
// Fade Shader
//
	
	/* Fade */

	varying vec2 v_vTexcoord;
	varying vec4 v_vColour;
	
	uniform float u_step;
	uniform bool  u_mode;
	uniform int   u_colour;
	
	float SubA(float Val1, float Val2)
	{
		if (u_colour == 1)
		{
			return Val1 + max(Val2 - u_step - Val1 + 252., 0.);
		}
		else
		{
			return Val1 - max(Val2 - u_step + Val1, 0.);
		}
	}

	float SubD(float Val1, float Val2)
	{ 
	    float Diff = max(756. - u_step - Val2, 0.);
		if (u_colour == 1)
		{
			return Val1 + Diff;
		}
		else
		{
			return Val1 - Diff;
		}
	}

	float Flash(float Val1)
	{
	    return max(252. - u_step, Val1);
	}
	
	/* Process */

	void main()
	{
		vec4 Col = texture2D(gm_BaseTexture, v_vTexcoord) * 255.;
		
		if (u_step == 0.)
		{
			Col.rgb = vec3(u_colour == 0 ? 0. : 255.);
		}
		else if (u_colour == 2) 
		{
			if (u_step != 252.)
			{
				if (u_mode == true)
				{
					Col.rgb = vec3(Flash(Col.r), Flash(Col.g), Flash(Col.b));
				}
				else
				{
					Col.rgb = min(Col.rgb + max(252. - u_step, 0.), 252.);
				}   
			}
		} 
		else if (u_step != 756.)
		{
			if (u_colour == 1)
			{
				if (u_mode == true)
				{
					Col.rgb = vec3(SubA(Col.r, 504. - Col.b - Col.g), SubA(Col.g, 252. - Col.b), SubA(Col.b, 0.));
				}
				else
				{
					Col.rgb = vec3(SubD(Col.r, 0.), SubD(Col.g, 252. - Col.r), SubD(Col.b, 504. - Col.r - Col.g));
				}
			}
			else
			{
				if (u_mode == true)
				{
					Col.rgb = vec3(SubA(Col.r, Col.b + Col.g), SubA(Col.g, Col.b), SubA(Col.b, 0.));
				}
				else
				{
					Col.rgb = vec3(SubD(Col.r, 0.), SubD(Col.g, Col.r), SubD(Col.b, Col.r + Col.g));
				}
			}
		}
		
		gl_FragColor = Col / 255. * v_vColour;
	}
