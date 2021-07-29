// ================================= //
	/* Parallax Scrolling Shader
	         by MicG            */
// ================================= //
	
	varying vec2 v_vTexcoord;
	varying vec2 v_vPosition;
	varying vec4 v_vColour;
	
	// Под объектом я имею в виду часть рисуемого задника, возмонжо это 
	// стоит как-то иначе назвать, да и в целом поработать над неймингом
	
	uniform vec2  o_pos; // Позиция объекта
	uniform vec2  scale; // Размер объекта
	uniform float ofst;  // Смещение задника в пикселях
	uniform float y_height; // Размер части по вертикали (для воды)
	uniform float y_step;   // Возрастание смещения частей по вертикали с каждой частью (для воды)
	uniform float texel; // Тексель (Это отношение координат в игре к координатам на текстурной карте)
	
	void main() 
	{	
		// Глобальная позиция данного пикселя
		vec2 Crnt = v_vPosition - o_pos;
		
		// Расстояние для смещение пикселя
		float OutX  = mod(floor(ofst * (y_height > 0. ? 1. + ceil((Crnt.y - 1.) / y_height / scale.y) * y_step : 1.)) + Crnt.x, scale.x) - Crnt.x;
		
		// Готовая (выводная) позиция 
		vec2 OutPos = vec2(v_vTexcoord.x + OutX * texel, v_vTexcoord.y);
		
		// Вывод
	    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, OutPos);
	}