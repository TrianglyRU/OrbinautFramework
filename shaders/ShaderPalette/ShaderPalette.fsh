// ================================= //
	/* Screen Palette Shader
			by MicG       */
// ================================= //

	varying vec2 v_vTexcoord;
	varying vec4 v_vColour;
	varying vec2 v_vPosition;

	uniform sampler2D u_palTexture;
	uniform vec4 u_Uvs;
	uniform float u_palId[64];	// Max colours on the palette list. Increase if needed
	uniform vec2 u_pixelSize;

	uniform float u_water;
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

	float SubA(float Val1, float Val2) // Appear
	{
		return (u_color == 1 ? 
			Val1 + max(Val2 - Val1 - u_step + 252., 0.): 
			Val1 - max(Val2 + Val1 - u_step, 0.));
	}

	float SubD(float Val1, float Val2) // Disappear
	{ 
		float Diff = max(756. - u_step - Val2, 0.);
		return Val1 + Diff * (u_color == 1 ? 1. : -1.);
	}

	float Flsh(float Val1) // Appear
	{
		return max(252. - u_step, Val1);
	}

	void main() 
	{
	
		#region	Change color
		////////////////////
		vec4 col = texture2D(gm_BaseTexture, v_vTexcoord);
		DoAlphaTest(col);
		col = findAltColor(col, u_Uvs.xy);
		if ((u_water != 0.) && (u_water >= v_vPosition.y))
		{
			//col.rgb = vec4(-0.1, -0.2, 0.5) + col.rgb * vec4(0.5, 0.6, 0.1);
			col.rgb -= vec3(80. / 255., 64. / 255., 24. / 255.);
		}
		#endregion
	
		#region Fade
		////////////
		vec3 OutCol;
		col = min(col * 255., 252.);
	
		if (u_color == 2) 
		{
			OutCol = u_mode == true ? 
			vec3(Flsh(col.r), Flsh(col.g), Flsh(col.b)):
			min(col.rgb + max(252. - u_step, 0.), 252.);
		} 
		else 
		{
			OutCol = u_color == 1 ? 
			u_mode == true ? 
				vec3(SubA(col.r, 504. - col.b - col.g), SubA(col.g, 252. - col.b), SubA(col.b, 0.)): 
				vec3(SubD(col.r, 0.), SubD(col.g, 252. - col.r), SubD(col.b, 504. - col.r - col.g)):
			u_mode == true ? 
				vec3(SubA(col.r, col.b + col.g), SubA(col.g, col.b), SubA(col.b, 0.)): 
				vec3(SubD(col.r, 0.), SubD(col.g, col.r), SubD(col.b, col.r + col.g));
		}
		#endregion
	
		// Output
		gl_FragColor = vec4(OutCol, col.a) / 255. * v_vColour;
	}