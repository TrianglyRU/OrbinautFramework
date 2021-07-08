function BackgroundParallaxPerform()
{
	if keyboard_check(vk_alt) Stage.WaterLevel++;
	if keyboard_check(vk_control) Stage.WaterLevel--;
	
	// Draw gray background
	draw_clear(c_gray);
	
	// Use shader
	shader_set(ShaderParallax);
	
	// Draw actual background
	var BackgroundParts = array_length(BackgroundSprites);
	for (var i = 0; i < BackgroundParts; i++)
	{
		// Get values
		var PosX		  = BackgroundValues[i][0];
		var PosY		  = BackgroundValues[i][1];
		var ScrollX		  = BackgroundValues[i][2];
		var ScrollY		  = BackgroundValues[i][3];
		var OffsetX		  = BackgroundValues[i][4];
		var OffsetY		  = BackgroundValues[i][5];
		var Top			  = BackgroundValues[i][6];
		var Bottom		  = BackgroundValues[i][7];
		var InclineHeight = BackgroundValues[i][8];
		var InclineForce  = BackgroundValues[i][9];
		var	YScaleMode	  = BackgroundValues[i][10];
		var Width		  = BackgroundValues[i][11];
		var Texel         = BackgroundValues[i][12];
		
		// Set variables
		var DrawX = Screen.CameraX;
		var DrawY = floor(Screen.CameraY * (1 - ScrollY)) + Top + PosY;

		var Height = Bottom - Top + 1;
		if YScaleMode
		{
			var Yscale = (Stage.WaterLevel - DrawY) / Height;
			if YScaleMode > 1
			{
				var Min, Max;
				switch YScaleMode
				{
					case 2: 
						Min = -1; 
						Max =  1; 
					break;
					case 3: 
						Min = (Screen.CameraY - DrawY) / Height;
						Max = (Screen.CameraY + Screen.Height - DrawY) / Height;
					break;
					case 4: 
						Min = min(-1, (Screen.CameraY - DrawY) / Height);
						Max = max( 1, (Screen.CameraY + Screen.Height - DrawY) / Height);
					break;
				}
				Yscale = clamp(Yscale, Min, Max);
			}
		}
		else 
		{
			Yscale = 1;
		}

		// Set shader uniforms
		shader_set_uniform_f(Shader.Prlx_Ofst, DrawX * ScrollX - OffsetX);
		shader_set_uniform_f(Shader.Prlx_Pos,  DrawX + PosX, DrawY - OffsetY);
	
		shader_set_uniform_f(Shader.Prlx_Scale, Width, Yscale);
		shader_set_uniform_f(Shader.Prlx_Texel, Texel);
	
		// Skip incline parallax if incline height is 0
		if InclineHeight != 0 
		{
		    shader_set_uniform_f(Shader.Prlx_Step, (InclineForce / 10) * InclineHeight);
			shader_set_uniform_f(Shader.Prlx_Hght, InclineHeight);
		}
	
		// Render sprite
		if YScaleMode
		{
			draw_sprite_part_ext(BackgroundSprites[i], 0, 0, Top, Width, Height, DrawX + PosX, DrawY, 1, Yscale, c_white, 1);
		}
		else
		{
			draw_sprite_part(BackgroundSprites[i], 0, 0, Top, Width, Height, DrawX + PosX, DrawY);
		}

		// Reset incline height
		if InclineHeight != 0 
		{
			shader_set_uniform_f(Shader.Prlx_Hght, 0); 
		}
		
	}
	
	// Reset shader
	shader_reset();
}