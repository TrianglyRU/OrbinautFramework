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
		return Val1 + (u_colour == 1 ? 
			 max(Val2 - Val1 - u_step + 252., 0.): 
			-max(Val2 + Val1 - u_step, 0.));
	}

	float SubD(float Val1, float Val2) // Disappear
	{ 
		float Diff = max(756. - u_step - Val2, 0.);
		return Val1 + Diff * (u_colour == 1 ? 1. : -1.);
	}

	float Flsh(float Val1) // Appear
	{
		return max(252. - u_step, Val1);
	}

	void main() 
	{
	
		#region	Change colour
		/////////////////////
		vec4 Col = texture2D(gm_BaseTexture, v_vTexcoord);
		
		//DoAlphaTest(Col); // Не знаю зачем, но пока не удалять
		
		if (u_waterHeight <= v_vPosition.y)
		{
			Col = findAltColor(Col, u_wetUvs, u_wetPixelSize, u_wetPalTex, u_wetPalId);
		}
		else
		{
			Col = findAltColor(Col, u_dryUvs, u_dryPixelSize, u_dryPalTex, u_dryPalId);
		}
		#endregion
	
		#region Fade
		////////////
		Col.rgb *= 255.;
		
		if (u_step == 0.)
		{
			Col.rgb = vec3(u_colour == 0 ? 0. : 255.);
		}
		else if (u_colour == 2) 
		{
			if (u_step != 252.)
			{
			Col.rgb = u_mode == true ? 
				vec3(Flsh(Col.r), Flsh(Col.g), Flsh(Col.b)):
				min(Col.rgb + max(252. - u_step, 0.), 252.);
			}
		} 
		else if (u_step != 756.)
		{
			Col.rgb = u_colour == 1 ? 
			u_mode == true ? 
				vec3(SubA(Col.r, 504. - Col.b - Col.g), SubA(Col.g, 252. - Col.b), SubA(Col.b, 0.)): 
				vec3(SubD(Col.r, 0.), SubD(Col.g, 252. - Col.r), SubD(Col.b, 504. - Col.r - Col.g)):
			u_mode == true ? 
				vec3(SubA(Col.r, Col.b + Col.g), SubA(Col.g, Col.b), SubA(Col.b, 0.)): 
				vec3(SubD(Col.r, 0.), SubD(Col.g, Col.r), SubD(Col.b, Col.r + Col.g));
		}
		#endregion
	
		// Output
		gl_FragColor = vec4(Col.rgb / 255., Col.a) * v_vColour;
	}