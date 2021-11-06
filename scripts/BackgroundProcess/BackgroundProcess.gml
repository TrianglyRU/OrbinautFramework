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
		var PosX	  = BGValues[i][0];
		var PosY	  = BGValues[i][1];
		var ScrollX	  = BGValues[i][2];
		var ScrollY	  = BGValues[i][3];
		var ScrollXAuto	  = BGValues[i][11];
		var InclineHeight = BGValues[i][5];
		var InclineForce  = BGValues[i][6];
		var YScaleMode	  = BGValues[i][7];
		var Height	  = BGValues[i][8];
		var Width	  = BGValues[i][9];
		var PixelSize     = BGValues[i][10];
		
		// Get screen position
		var DrawX = ViewX;
		var DrawY = floor(ViewY * (1 - ScrollY)) + PosY;
		
		// Set y-scale mode properties
		if YScaleMode
		{
			var YScale = (Stage.WaterLevel - DrawY) / Height;
			if  YScaleMode > 1
			{
				switch YScaleMode
				{
					// Classic-like
					case 2:
					{
						var Min = -1; 
						var Max =  1; 
					}
					break;
					
					// Adaptive limit
					case 3:
					{
						var Min = (ViewY - DrawY) / Height;
						var Max = (ViewY + Game.Height - DrawY) / Height;
					}
					break;
					
					// "Smart" limit
					case 4:
					{
						var Min = min(-1, (ViewY - DrawY) / Height);
						var Max = max( 1, (ViewY + Game.Height - DrawY) / Height);
					}
					break;
				}
				YScale = clamp(YScale, Min, Max);
			}
		} 
		else 
		{
			YScale = 1;
		}
		
		// Transfer data to the shader
		shader_set_uniform_f(Shader.ParOffset,    DrawX * ScrollX - ScrollXAuto);
		shader_set_uniform_f(Shader.ParPos,       DrawX + PosX, DrawY);
		shader_set_uniform_f(Shader.ParWidth,     Width);
		shader_set_uniform_f(Shader.ParPixelSize, PixelSize);
		
		// Set incline height
		if InclineHeight != 0 
		{
			shader_set_uniform_f(Shader.ParILStep,  (InclineForce / 10) * InclineHeight);
			shader_set_uniform_f(Shader.ParILHeight, InclineHeight);
			shader_set_uniform_f(Shader.ParYScale,   YScale);
		}
		
		// Draw parallax piece
		if YScaleMode
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
			shader_set_uniform_f(Shader.ParILHeight, 0);
		}
	}
	
	// Reset shader
	shader_reset();
}