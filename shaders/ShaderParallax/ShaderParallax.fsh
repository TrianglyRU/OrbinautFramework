// ================================= //
    /* Parallax Scrolling Shader
	       by MicG           */
// ================================= //
	
	varying vec2 v_vTexcoord;
	varying vec2 v_vPosition;
	varying vec4 v_vColour;
	
	// Под объектом я имею в виду часть рисуемого задника, возмонжо это 
	// стоит как-то иначе назвать, да и в целом поработать над неймингом
	
	uniform vec2  u_pos;	   // Позиция объекта
	uniform float u_width;	   // Размер объекта по горизонтали (в пикселях)
	uniform float u_yScale;    // Множитель размера объекта по вертикали 
	uniform float u_offset;	   // Смещение задника в пикселях
	uniform float u_ilHeight;  // Размер части по вертикали (для воды)
	uniform float u_ilStep;	   // Возрастание смещения частей по вертикали с каждой частью (для воды)
	uniform float u_pixelSize; // Тексель (Это отношение координат в игре к координатам на текстурной карте)
	
	void main() 
	{	
		// Глобальная позиция данного пикселя
		vec2 Crnt = v_vPosition - u_pos;
		
		// Расстояние для смещение пикселя
		float OutX  = mod(floor(u_offset * (u_ilHeight > 0. ? 1. + ceil((Crnt.y - 1.) / u_ilHeight / u_yScale) * u_ilStep : 1.)) + Crnt.x, u_width) - Crnt.x;
		
		// Готовая (выводная) позиция 
		vec2 OutPos = vec2(v_vTexcoord.x + OutX * u_pixelSize, v_vTexcoord.y);
		
		// Вывод
	    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, OutPos);
	}