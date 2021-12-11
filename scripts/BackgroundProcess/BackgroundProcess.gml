function BackgroundProcess()
{	
	// Draw background colour
	draw_clear(BGColour);
	
	// Use parallax shader
	shader_set(ShaderParallax);
	
	// Get camera position
	var ViewX = Camera.ViewX;
	var ViewY = Camera.ViewY;
	
	// Check if we should update autoscroll value
	var UpdateAutoscroll = !(fade_check(StateActive) or variable_check(Stage, "IsPaused"));
	
	// Work with each layer individually
	var Length = array_length(BGSprites);
	for (var i = 0; i < Length; i++)
	{
		// Update autoscroll value
		if UpdateAutoscroll
		{
			BGValues[i][11] += BGValues[i][4];
		}
		
		// Get data
		var PosX	      = BGValues[i][0];
		var PosY	      = BGValues[i][1];
		var ScrollX	      = BGValues[i][2];
		var ScrollY	      = BGValues[i][3];
		var ScrollXAuto	  = BGValues[i][11];
		var InclineHeight = BGValues[i][5];
		var InclineStep   = BGValues[i][6];
		var InclineModeY  = BGValues[i][7];
		var Height	      = BGValues[i][8];
		var Width	      = BGValues[i][9];
		var MapSize       = BGValues[i][10];
		
		// Get screen position
		var DrawX = ViewX;
		var DrawY = floor(ViewY * (1 - ScrollY)) + PosY;
		
		// Set y-scale mode properties
		if InclineModeY and variable_check(Stage, "WaterLevel")
		{
			var YScale = clamp((Stage.WaterLevel - DrawY) / Height, -1, 1);
		} 
		else 
		{
			YScale = 1;
		}
		
		// Transfer data to the shader
		shader_set_uniform_f(Shader.PrlOffset,  DrawX * ScrollX - ScrollXAuto);
		shader_set_uniform_f(Shader.PrlPos,     DrawX + PosX, DrawY);
		shader_set_uniform_f(Shader.PrlWidth,   Width);
		shader_set_uniform_f(Shader.PrlMapSize, MapSize);
		
		// Set incline height
		if InclineHeight != 0 
		{
			shader_set_uniform_f(Shader.PrlIncStep,   InclineStep / ScrollX);
			shader_set_uniform_f(Shader.PrlIncHeight, InclineHeight);
			shader_set_uniform_f(Shader.PrlYScale,    YScale);
		}
		
		// Draw parallax piece
		if InclineModeY
		{
			draw_sprite_ext(BGSprites[i], 0, DrawX + PosX, DrawY, 1, YScale, 0, c_white, 1);
		}
		else
		{
			draw_sprite(BGSprites[i], 0, DrawX + PosX, DrawY);
		}
		
		// Reset incline height
		if InclineHeight != 0 
		{
			shader_set_uniform_f(Shader.PrlIncHeight, 0);
		}
	}

	// Reset shader
	shader_reset();
}