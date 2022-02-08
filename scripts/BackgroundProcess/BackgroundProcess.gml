function BackgroundProcess()
{	
	draw_clear(BGColour);
	
	//shader_set(ShaderParallax);
	/*shader_set(ShaderPalette);
	
	// Define a render boundary between type 1 and type 2 palettes
	if instance_exists(Stage) and Stage.WaterEnabled
	{
		var Boundary = Game.Height - clamp(Camera.ViewY - Stage.WaterLevel + Game.Height, 0, Game.Height);
	}
	else
	{
		var Boundary = Game.Height;
	}
	
	// Transfer boundary data into the shader
	shader_set_uniform_f(Shader.PalBoundary, Boundary);
		
	// Render palette type 1
	if Boundary > 0 and Palette.ColourSet[TypePrimary] != false
	{
		shader_set_uniform_f_array(Shader.PalIndex1, Palette.IndexType1);
		texture_set_stage(Shader.PalTex1,			 Palette.ColourSet[0][0]);
		shader_set_uniform_f(Shader.PalTexelSize1,   Palette.ColourSet[0][1], Palette.ColourSet[0][2]);
		shader_set_uniform_f(Shader.PalUVs1,		 Palette.ColourSet[0][3], Palette.ColourSet[0][4], Palette.ColourSet[0][5]);
	}
		
	// Render palette type 2
	if Boundary < Game.Height and Palette.ColourSet[TypeSecondary] != false
	{
		texture_set_stage(Shader.PalTex2,			 Palette.ColourSet[1][0]);
		shader_set_uniform_f_array(Shader.PalIndex2, Palette.IndexType2);
		shader_set_uniform_f(Shader.PalTexelSize2,   Palette.ColourSet[1][1], Palette.ColourSet[1][2]);
		shader_set_uniform_f(Shader.PalUVs2,		 Palette.ColourSet[1][3], Palette.ColourSet[1][4], Palette.ColourSet[1][5]);
	}
	
	shader_set_uniform_i(Shader.PrlActive, true);*/
	
	var Length = array_length(BGSprites);
	for (var i = 0; i < Length; i++)
	{
		// Update autoscroll value
		if Game.UpdateAnimations
		{
			BGValues[i][12] += BGValues[i][4];
		}
		
		// Get background data
		var PosX	      = BGValues[i][0];
		var PosY	      = BGValues[i][1];
		var ScrollX	      = BGValues[i][2];
		var ScrollY	      = BGValues[i][3];
		var InclineHeight = BGValues[i][5];
		var InclineStep   = BGValues[i][6];
		var InclineY      = BGValues[i][7];
		var AnimSpeed     = BGValues[i][8];
		var Height	      = BGValues[i][9];
		var Width	      = BGValues[i][10];
		var MapSize       = BGValues[i][11];
		var AutoXOffset	  = BGValues[i][12];
		
		// Define draw position
		var DrawX = Camera.ViewX 					    + PosX;
		var DrawY = floor(Camera.ViewY * (1 - ScrollY)) + PosY;
		
		// Set y-scale mode properties
		if InclineY and instance_exists(Stage) and Stage.WaterEnabled
		{
			var YScale = clamp((Stage.WaterLevel - DrawY) / Height, -1, 1);
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
			var Frame = Game.AnimationTime[? GlobalTime] div AnimSpeed mod sprite_get_number(BGSprites[i]);
		}
		
		// Transfer data to the shader
		if InclineHeight != 0 
		{
			shader_set_uniform_f(Shader.PrlIncStep,   InclineStep / ScrollX);
			shader_set_uniform_f(Shader.PrlIncHeight, InclineHeight);
			shader_set_uniform_f(Shader.PrlYScale,    YScale);
		}
		shader_set_uniform_f(Shader.PrlOffset, (DrawX - PosX) * ScrollX - AutoXOffset);
		shader_set_uniform_f(Shader.PrlPos,     DrawX, DrawY);
		shader_set_uniform_f(Shader.PrlWidth,   Width);
		shader_set_uniform_f(Shader.PrlMapSize, MapSize);
		
		// Draw background piece
		if InclineY
		{
			draw_sprite_ext(BGSprites[i], Frame, DrawX, DrawY, 1, YScale, 0, c_white, 1);
		}
		else
		{
			draw_sprite(BGSprites[i], Frame, DrawX, DrawY);
		}
		if InclineHeight != 0 
		{
			shader_set_uniform_f(Shader.PrlIncHeight, 0);
		}
	}
	//shader_reset();
	shader_set_uniform_i(Shader.PrlActive, false);
	
}