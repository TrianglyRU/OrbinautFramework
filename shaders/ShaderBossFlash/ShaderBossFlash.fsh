// Negative shader

	varying vec2 v_vTexcoord;
	varying vec4 v_vColour;
	
	uniform bool u_type;
	
	void main()
	{
		// Входной (базовый) цвет
		vec4 Col = texture2D(gm_BaseTexture, v_vTexcoord);
		
		// Изменение цвета
		if (u_type)
		{
			// Инверсия
			Col.rgb = vec3(1. - Col.rgb);
		}
		else
		{
			// Если чёрный, то сделать белым
			if (Col.rgb == vec3(0.))
			{
				Col.rgb = vec3(1.);
			}
		}
		
		// Вывод цвета
	    gl_FragColor = Col * v_vColour;
	}
