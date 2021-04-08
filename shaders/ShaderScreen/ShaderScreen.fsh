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
	uniform vec3 u_waterCol;
	
	uniform float u_step;
	uniform bool u_mode;
	uniform int u_color;

	vec4 findAltColor(vec4 inCol, vec2 corner, sampler2D sampler) 
	{
	    vec2 testPos;
	    for (float i = corner.y; i < u_Uvs.w; i += u_pixelSize.y) 
		{
			testPos = vec2(corner.x, i);
			if (distance(texture2D(sampler, testPos), inCol) == 0.) 
			{
				float Index = u_palId[int((i - corner.y) / u_pixelSize.y)];
				testPos = vec2(corner.x + u_pixelSize.x * floor(Index + 1.), i);
				return mix(texture2D(sampler, vec2(testPos.x - u_pixelSize.x, testPos.y)), texture2D(sampler, testPos), fract(Index));
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
		if ((u_water != 0.) && (u_water >= 224. - v_vPosition.y))
		{
			col.rgb += u_waterCol / 255.;
		}
		col = findAltColor(col, u_Uvs.xy, u_palTexture);
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