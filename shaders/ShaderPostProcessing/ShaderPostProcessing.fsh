//
// Simple passthrough fragment shader
//
	varying vec2 v_vTexcoord;
	varying vec4 v_vColour;
	
	#region Blur, Bloom and Levels [BBL]
	
		const float	bloomThreshold = .15;
		const float	bloomRange     = .4;
		const vec3  bloomColour    = vec3(.7);
	
		const float blurSize      = 1. / 512.;
		const float blurIntensity = .2;
	
		const float brightness = .75;
	
		const float blackPoint = 30. / 255.;
		const float whitePoint = 1.;
		
	#endregion
	
	float Levels(float colour)
	{
		if (colour < blackPoint)
		{
			return 0.;
		}
		else if (colour > whitePoint)
		{
			return 1.;	
		}
		return colour;
	}
	
	void main()
	{
		vec2 OutCoord = v_vTexcoord;
		vec4 OutTex   = texture2D(gm_BaseTexture, OutCoord);
		
		#region BBL shader

			vec3  sumTex = vec3(0);
			float mult   = .05;
			float blurSum; 
		
			for (float i = -4.; i < 5.; i += 1.)
			{
				blurSum = i * blurSize;
				sumTex += texture2D(gm_BaseTexture, vec2(OutCoord.x + blurSum, OutCoord.y)).rgb * mult;
				sumTex += texture2D(gm_BaseTexture, vec2(OutCoord.x, OutCoord.y + blurSum)).rgb * mult;
				mult   -= (i - (i >= 0. ? 1. : 0.)) * .01;
			}
			float weight = smoothstep(bloomThreshold, bloomThreshold + bloomRange, dot(OutTex.rgb, bloomColour));
		
			OutTex.rgb = (mix(vec3(0.), OutTex.rgb, weight) + sumTex.rgb * blurIntensity) * brightness;
		
			OutTex.r = Levels(OutTex.r);
			OutTex.g = Levels(OutTex.g);
			OutTex.b = Levels(OutTex.b);

		#endregion

	    gl_FragColor = v_vColour * OutTex;
	}