/// @description Draw Background
// You can write your code in this editor

	// Draw background colour
	draw_clear(BGColour);
	
	var BGData = array_length(BGSprites);
	if !BGData
	{
		return;
	}
	var ScreenBuffer = global.ScreenBuffer;
	
	// Draw background
	try
	{
		// Apply parallax
		shader_set_uniform_i(Shader.PrlActive, true);
	
		for (var i = 0; i < BGData; i++)
		{
			// Update ScrollX offset
			if Renderer.UpdateAnimations
			{
				BGValues[i][13] -= BGValues[i][5];
			}
		
			// Get background data
			var PosY	     = BGValues[i][0];
			var NodeY	     = BGValues[i][1];
			var Height	     = BGValues[i][2];
			var FactorX	     = BGValues[i][3];
			var FactorY	     = BGValues[i][4];
			var ScaleXHeight = BGValues[i][6];
			var ScaleXStep   = BGValues[i][7];
			var ScaleYFlag   = BGValues[i][8];
			var AnimDuration = BGValues[i][9];
			var TexHeight	 = BGValues[i][10];
			var TexWidth	 = BGValues[i][11];
			var TexMapSize   = BGValues[i][12];
			var AutoXOffset	 = BGValues[i][13];
		
			// Define draw position
			var DrawX = Camera.ViewX - ScreenBuffer;
			var DrawY = floor(Camera.ViewY * (1 - FactorY)) + PosY;
		
			// Set ScaleY properties
			if ScaleYFlag and instance_exists(Stage) and Stage.WaterEnabled
			{
				var ScaleY = clamp((Stage.WaterLevel - DrawY) / TexHeight, -1, 1);
			} 
			else 
			{
				var ScaleY = 1;
			}
			
			// Get a frame to display
			if !AnimDuration
			{
				var Frame = 0;
			}
			else
			{
				var Frame = Renderer.AnimationTime[? GlobalTime] div AnimDuration mod sprite_get_number(BGSprites[i]);
			}
		
			// Set shader data
			if ScaleXHeight != 0 
			{
				if ScaleXStep < 0
				{
					shader_set_uniform_f(Shader.PrlHeight, abs(Height));
				}	
				shader_set_uniform_f(Shader.PrlIncStep,   ScaleXStep / FactorX);
				shader_set_uniform_f(Shader.PrlIncHeight, ScaleXHeight);
				shader_set_uniform_f(Shader.PrlScaleY,    ScaleY);
			}
			shader_set_uniform_f(Shader.PrlOffset,  Camera.ViewX * FactorX - AutoXOffset, ScreenBuffer);
			shader_set_uniform_f(Shader.PrlPos,     DrawX, DrawY);
			shader_set_uniform_f(Shader.PrlWidth,   TexWidth);
			shader_set_uniform_f(Shader.PrlMapSize, TexMapSize);
		
			// Draw background piece
			if Height < 0
			{
				if ScaleYFlag
				{
					draw_sprite_ext(BGSprites[i], Frame, DrawX, DrawY, 1, ScaleY, 0, c_white, 1);
				}
				else
				{
					draw_sprite(BGSprites[i], Frame, DrawX, DrawY);
				}
			}
			else 
			{
				if ScaleYFlag
				{
					draw_sprite_part_ext(BGSprites[i], Frame, 0, NodeY, sprite_get_width(BGSprites[i]), Height, DrawX, DrawY, 1, ScaleY, c_white, 1);
				}
				else
				{
					draw_sprite_part(BGSprites[i], Frame, 0, NodeY, sprite_get_width(BGSprites[i]), Height, DrawX, DrawY);
				}
			}
		
			// Reset ScaleX
			if ScaleXHeight != 0
			{
				if ScaleXStep < 0
				{
					shader_set_uniform_f(Shader.PrlHeight, 0);
				}
				shader_set_uniform_f(Shader.PrlIncHeight, 0);
			}
		}
	
		// Stop parallax
		shader_set_uniform_i(Shader.PrlActive, false);
	}
	catch (Exception)
	{
		show_message("BACKGROUND PROCESS ERROR! \nAn error has occured. Make sure the amount of layers that have been set up matches the amount of added layers\n" + "\n" + Exception.message);
		room_goto(Screen_DevMenu);
	}
