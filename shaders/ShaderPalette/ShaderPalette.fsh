//
// Screen shader
//
	varying vec2 v_vTexcoord;
	varying vec4 v_vColour;
	varying vec2 v_vPosition;
	
	#define PaletteLimit 64
	
	uniform float u_waterHeight;
	
	uniform sampler2D u_dryPalTex;
	uniform vec3	  u_dryUvs;
	uniform vec2	  u_dryPixelSize;
	uniform float     u_dryPalId[PaletteLimit];

	uniform sampler2D u_wetPalTex;
	uniform vec3      u_wetUvs;
	uniform vec2      u_wetPixelSize;
	uniform float     u_wetPalId[PaletteLimit];
	
	uniform float u_step;
	uniform bool  u_mode;
	uniform int   u_colour;
	
	// This block of code is based on the shader by Pixelated Pope, which we purchased! Credits to him <3
	vec4 findAltColor(vec4 inCol, vec3 corner, vec2 pixelSize, sampler2D sampler, float palID[PaletteLimit]) 
	{
		for (float i = corner.y; i < corner.z; i += pixelSize.y) 
		{
			vec2 testPos = vec2(corner.x, i);
			if (texture2D(sampler, testPos) == inCol) 
			{
				float Index = palID[int((i - corner.y) / pixelSize.y)];
				testPos.x  += pixelSize.x * floor(Index + 1.);
				
				return mix(texture2D(sampler, vec2(testPos.x - pixelSize.x, testPos.y)), texture2D(sampler, testPos), fract(Index));
			}
		}
		return inCol;
	}

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

	void main() 
	{
		vec4 Col = texture2D(gm_BaseTexture, v_vTexcoord);
		if  (u_waterHeight <= v_vPosition.y)
		{
			Col = findAltColor(Col, u_wetUvs, u_wetPixelSize, u_wetPalTex, u_wetPalId);
		}
		else
		{
			Col = findAltColor(Col, u_dryUvs, u_dryPixelSize, u_dryPalTex, u_dryPalId);
		}
    
		Col.rgb *= 255.;
		
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
		
		gl_FragColor = vec4(Col.rgb / 255., Col.a) * v_vColour;
	}