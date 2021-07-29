// Negative shader

	varying vec2 v_vTexcoord;
	varying vec4 v_vColour;

	void main()
	{
		// Входной (базовый) цвет
		vec4 col = texture2D(gm_BaseTexture, v_vTexcoord);
		
		// Инверсия и вывод цвета
	    gl_FragColor = vec4(1. - col.rgb, col.a) * v_vColour;
	}
