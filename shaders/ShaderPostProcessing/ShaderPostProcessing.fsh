// =============================== //
	/* Post-processing Shaders
			 by MicG           */
// =============================== //
	varying vec2 v_vTexcoord;
	varying vec4 v_vColour;
	
	#region Blur&Bloom (Options)
	
	const float	bloomThreshold = .1;
	const float	bloomRange = .4;
	const vec3  bloomColour = vec3(.7);
	
	const float blurSize = 1. / 512.;
	const float blurIntensity = .15;
	
	const float brightness = .75;
	/*
	const float blurIntensity = .2;
	
	const float brightness = .65;
	*/

	#endregion
	
	void main()
	{
		// Координаты пикселей на текстурной карте
		vec2 OutCoord = v_vTexcoord;
	
		#region Coord shaders
	
		// Flip vertically 
		//OutCoord.y = 1. - OutCoord.y;
	
		//Flip horizontally 
		//OutCoord.x = 1. - OutCoord.x;
	
		//Flip diagonally 
		//OutCoord = 1. - OutCoord;
	
		#endregion
		
		// Заготовка текстуры 
		vec4 OutTex = texture2D(gm_BaseTexture, OutCoord);
	
		#region Colour shaders
	
		// Black&White
		//OutTex.rgb = vec3((OutTex.r + OutTex.g + OutTex.b) / 3.);
	
		// Sepia
		//float Mixed = (OutTex.r + OutTex.g + OutTex.b) / 3.; // Смешивание цветов
		//OutTex.rgb = vec3(Mixed, Mixed, Mixed / 1.5);
	
		// Negative
		//OutTex.rgb = 1. - OutTex.rgb;
	
		#endregion
		
		#region Blur&Bloom (RTX)
		vec3 sumTex = vec3(0); // "Сумма" (наложение) текстур со "смещением", создающее эффект блюра
		float mult = .05; // Множитель смещения
		float blurSum; // Показатель наложение блюра  
		
		// Приминение блюра
		for (float i = -4.; i < 5.; i += 1.)
		{
			blurSum = i * blurSize;
			sumTex += texture2D(gm_BaseTexture, vec2(OutCoord.x + blurSum, OutCoord.y)).rgb * mult;
			sumTex += texture2D(gm_BaseTexture, vec2(OutCoord.x, OutCoord.y + blurSum)).rgb * mult;
			mult -= (i - (i >= 0. ? 1. : 0.)) * .01;
		}
		
		// Применение блума
		float weight = smoothstep(bloomThreshold, bloomThreshold + bloomRange, dot(OutTex.rgb, bloomColour));
		
		// Совмещение эффектов
		OutTex.rgb = (mix(vec3(0.), OutTex.rgb, weight) + sumTex.rgb * blurIntensity) * brightness;
		#endregion

		// Вывод
	    gl_FragColor = v_vColour * OutTex;
	}