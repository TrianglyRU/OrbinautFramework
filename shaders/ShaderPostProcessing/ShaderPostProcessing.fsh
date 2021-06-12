// Simple passthrough fragment shader

	varying vec2 v_vTexcoord;
	varying vec4 v_vColour;
	
	#region Blur&Bloom (Options)
	/*
	const float	bloomThreshold = .1;
	const float	bloomRange = .4;
	const vec3  bloomColour = vec3(.7);
	
	const float blurSize = 1. / 512.;
	const float intensity = .2;
	
	const float brightness = .65;
	*/
	
	const float	bloomThreshold = .1;
	const float	bloomRange = .4;
	const vec3  bloomColour = vec3(.7);
	
	const float blurSize = 1. / 512.;
	const float intensity = .15;
	
	const float brightness = .75;
	#endregion
	
	void main()
	{
		vec2 outCoord = v_vTexcoord;
	
		#region Coord shaders
	
		// Flip vertically 
		//outCoord.y = 1. - outCoord.y;
	
		//Flip horizontally 
		//outCoord.x = 1. - outCoord.x;
	
		//Flip diagonally 
		//outCoord = 1. - outCoord;
	
		#endregion
	
		vec4 outTex = texture2D(gm_BaseTexture, outCoord);
	
		#region Colour shaders
	
		// Black&White
		//float Mixed = (outTex.r + outTex.g + outTex.b) / 3.;
		//outTex.rgb = vec3(Mixed, Mixed, Mixed);
	
		// Sepia
		//float Mixed = (outTex.r + outTex.g + outTex.b) / 3.;
		//outTex.rgb = vec3(Mixed, Mixed, Mixed / 1.5);
	
		// Negative
		//outTex.rgb = 1. - outTex.rgb;
	
		#endregion
		
		#region Blur&Bloom (RTX)
		
		vec4 sumTex = vec4(0);
		float mult = .05;
		float blurSum;
		
		for (float i = -4.; i < 5.; i += 1.)
		{
			blurSum = i * blurSize;
			sumTex += texture2D(gm_BaseTexture, vec2(outCoord.x + blurSum, outCoord.y)) * mult;
			sumTex += texture2D(gm_BaseTexture, vec2(outCoord.x, outCoord.y + blurSum)) * mult;
			mult -= (i - (i >= 0. ? 1. : 0.)) * .01;
		}
	   
		float lum		= dot(outTex.rgb, bloomColour);
		float weight	= smoothstep(bloomThreshold, bloomThreshold + bloomRange, lum);
		outTex.rgb	= mix(vec3(0.), outTex.rgb, weight) * brightness;
		gl_FragColor = sumTex * intensity + v_vColour * outTex;
		
		#endregion
		
		// Without Blur&Bloom
	    //gl_FragColor = v_vColour * outTex;	
	}