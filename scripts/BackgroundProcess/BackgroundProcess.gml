function BackgroundProcess()
{	
	// Draw background colour
	draw_clear(BGColour);
	
	var BGData = array_length(BGSprites);
	if !BGData
	{
		return;
	}
	var ScreenBuffer = global.ScreenBuffer;
	
	// Enable parallax
	shader_set_uniform_i(Shader.PrlActive, true);
	
	for (var i = 0; i < BGData; i++)
	{
		// Update autoscroll value
		if Renderer.UpdateAnimations
		{
			BGValues[i][13] += BGValues[i][5];
		}
		
		// Get background data
		var PosY	      = BGValues[i][0];
		var NodeY	      = BGValues[i][1];
		var HeightY	      = BGValues[i][2];
		var ScrollX	      = BGValues[i][3];
		var ScrollY	      = BGValues[i][4];
		var InclineHeight = BGValues[i][6];
		var InclineStep   = BGValues[i][7];
		var InclineY      = BGValues[i][8];
		var AnimSpeed     = BGValues[i][9];
		var TexHeight	  = BGValues[i][10];
		var TexWidth	  = BGValues[i][11];
		var TexMapSize    = BGValues[i][12];
		var AutoXOffset	  = BGValues[i][13];
		
		// Define draw position
		var DrawX = Camera.ViewX - ScreenBuffer;
		var DrawY = floor(Camera.ViewY * (1 - ScrollY)) + PosY;
		
		// Set y-scale mode properties
		if InclineY and instance_exists(Stage) and Stage.WaterEnabled
		{
			var YScale = clamp((Stage.WaterLevel - DrawY) / TexHeight, -1, 1);
		} 
		else 
		{
			YScale = 1;
		}
			
		// Get a frame to display
		if !AnimSpeed
		{
			var Frame = 0;
		}
		else
		{
			var Frame = Renderer.AnimationTime[? GlobalTime] div AnimSpeed mod sprite_get_number(BGSprites[i]);
		}
		
		// Transfer data to the shader
		if InclineHeight != 0 
		{
			shader_set_uniform_f(Shader.PrlIncStep,   InclineStep / ScrollX);
			shader_set_uniform_f(Shader.PrlIncHeight, InclineHeight);
			shader_set_uniform_f(Shader.PrlScaleY,    YScale);
		}
		shader_set_uniform_f(Shader.PrlOffset,  Camera.ViewX * ScrollX - AutoXOffset, ScreenBuffer);
		shader_set_uniform_f(Shader.PrlPos,     DrawX, DrawY);
		shader_set_uniform_f(Shader.PrlWidth,   TexWidth);
		shader_set_uniform_f(Shader.PrlMapSize, TexMapSize);
		
		// Draw background piece
		if InclineHeight or HeightY == -1
		{
			if InclineY
			{
				draw_sprite_ext(BGSprites[i], Frame, DrawX, DrawY, 1, YScale, 0, c_white, 1);
			}
			else
			{
				draw_sprite(BGSprites[i], Frame, DrawX, DrawY);
			}
		}
		else 
		{
			draw_sprite_part(BGSprites[i], Frame, 0, NodeY, sprite_get_width(BGSprites[i]), HeightY, DrawX, DrawY);
		}
		if InclineHeight != 0
		{
			shader_set_uniform_f(Shader.PrlIncHeight, 0);
		}
	}
	
	// Disable parallax
	shader_set_uniform_i(Shader.PrlActive, false);
}