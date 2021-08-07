// ============================= //
	/* Screen Palette Shader
			by MicG          */
// ============================= //

	varying vec2 v_vTexcoord;
	varying vec4 v_vColour;
	varying vec2 v_vPosition;
	
	#define MaxCol 64 // Max colours on the dynamic palette list. Increase if needed
	
	uniform float u_waterHeight;
	
	// Над водой
	uniform sampler2D u_dryPalTex;
	uniform vec3 u_dryUvs;
	uniform vec2 u_dryPixelSize;
	uniform float u_dryPalId[MaxCol];

	// Под водой
	uniform sampler2D u_wetPalTex;
	uniform vec3 u_wetUvs;
	uniform vec2 u_wetPixelSize;
	uniform float u_wetPalId[MaxCol];
	
	// Затемнение
	uniform float u_step;
	uniform bool u_mode;
	uniform int u_colour;

	vec4 findAltColor(vec4 inCol, vec3 corner, vec2 pixelSize, sampler2D sampler, float palID[MaxCol]) 
	{
	    for (float i = corner.y; i < corner.z; i += pixelSize.y) 
		{
			vec2 testPos = vec2(corner.x, i);
			if (texture2D(sampler, testPos) == inCol) 
			{
				float Index = palID[int((i - corner.y) / pixelSize.y)];
				testPos.x += pixelSize.x * floor(Index + 1.);
				return mix(texture2D(sampler, vec2(testPos.x - pixelSize.x, testPos.y)), texture2D(sampler, testPos), fract(Index));
			}
	    }
	    return inCol;
	}

	float SubA(float Val1, float Val2) // Appear
	{
		if (u_step == 756.) return Val1;
		return Val1 + (u_colour == 1 ? 
			 max(Val2 - Val1 - u_step + 252., 0.): 
			-max(Val2 + Val1 - u_step, 0.));
	}

	float SubD(float Val1, float Val2) // Disappear
	{ 
		if (u_step == 0.) return u_colour == 1 ? 255. : 0.;
		float Diff = max(756. - u_step - Val2, 0.);
		return Val1 + Diff * (u_colour == 1 ? 1. : -1.);
	}

	float Flsh(float Val1) // Appear
	{
		if (u_step == 0.) return 255.;
		if (u_step == 1008.) return Val1;
		return max(252. - u_step, Val1);
	}

	void main() 
	{
	
		#region	Change color
		////////////////////
		vec4 col = texture2D(gm_BaseTexture, v_vTexcoord);
		
		//DoAlphaTest(col); // Не знаю зачем, но пока не удалять
		
		if (u_waterHeight <= v_vPosition.y)
		{
			col = findAltColor(col, u_wetUvs, u_wetPixelSize, u_wetPalTex, u_wetPalId);
		}
		else
		{
			col = findAltColor(col, u_dryUvs, u_dryPixelSize, u_dryPalTex, u_dryPalId);
		}
		#endregion
	
		#region Fade
		////////////
		col.rgb *= 255.;
		vec3 OutCol;
	
		if (u_colour == 2) 
		{
			OutCol = u_mode == true ? 
			vec3(Flsh(col.r), Flsh(col.g), Flsh(col.b)):
			min(col.rgb + max(252. - u_step, 0.), 252.);
		} 
		else 
		{
			OutCol = u_colour == 1 ? 
			u_mode == true ? 
				vec3(SubA(col.r, 504. - col.b - col.g), SubA(col.g, 252. - col.b), SubA(col.b, 0.)): 
				vec3(SubD(col.r, 0.), SubD(col.g, 252. - col.r), SubD(col.b, 504. - col.r - col.g)):
			u_mode == true ? 
				vec3(SubA(col.r, col.b + col.g), SubA(col.g, col.b), SubA(col.b, 0.)): 
				vec3(SubD(col.r, 0.), SubD(col.g, col.r), SubD(col.b, col.r + col.g));
		}
		#endregion
	
		// Output
		gl_FragColor = vec4(OutCol / 255., col.a) * v_vColour;
	}