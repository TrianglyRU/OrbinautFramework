// =============================== //
	/* Post-processing Shaders
			 by MicG           */
// =============================== //
	varying vec2 v_vTexcoord;
	varying vec4 v_vColour;
	
	#region Blur&Bloom&Levels [BBL] (Options)
	
	const float	bloomThreshold = .15;
	const float	bloomRange = .4;
	const vec3  bloomColour = vec3(.7);
	
	const float blurSize = 1. / 512.;
	const float blurIntensity = .2;
	
	const float brightness = .75;
	
	const float blackPoint = 30. / 255.;
	const float whitePoint = 1.;

	#endregion
	
	// Уровни
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
		// Координаты пикселей на текстурной карте
		vec2 OutCoord = v_vTexcoord;
		
		// Заготовка текстуры 
		vec4 OutTex = texture2D(gm_BaseTexture, OutCoord);
		
		#region BBL shader
		vec3 sumTex = vec3(0); // "Сумма" (наложение) текстур со "смещением", создающая эффект блюра
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
		
		// Применение уровней
		OutTex.r = Levels(OutTex.r);
		OutTex.g = Levels(OutTex.g);
		OutTex.b = Levels(OutTex.b);
		#endregion

		// Вывод
	    gl_FragColor = v_vColour * OutTex;
	}