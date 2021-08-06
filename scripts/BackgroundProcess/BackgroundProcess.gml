function BackgroundProcess()
{	
	// Draw white background colour
	draw_clear(c_gray);
	
	// Use parallax shader
	shader_set(ShaderParallax);
	
	// Work with each parallax piece individually
	var BackgroundParts = array_length(BackgroundSprites);
	for (var i = 0; i < BackgroundParts; i++)
	{
		// Get parallax piece data
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
		var PixelSize     = BackgroundValues[i][12];
		
		// Get screen position
		var DrawX = Screen.CameraX;
		var DrawY = floor(Screen.CameraY * (1 - ScrollY)) + Top + PosY;
		
		// Set y-scale mode properties
		var Height = Bottom - Top + 1;
		if  YScaleMode
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
						var Min = (Screen.CameraY - DrawY) / Height;
						var Max = (Screen.CameraY + Screen.Height - DrawY) / Height;
					}
					break;
					
					// "Smart" limit
					case 4:
					{
						var Min = min(-1, (Screen.CameraY - DrawY) / Height);
						var Max = max( 1, (Screen.CameraY + Screen.Height - DrawY) / Height);
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
		
		// Transfer data into the shader
		shader_set_uniform_f(Shader.Prlx_Ofst,  DrawX * ScrollX - OffsetX);
		shader_set_uniform_f(Shader.Prlx_Pos,   DrawX + PosX, DrawY - OffsetY);
		shader_set_uniform_f(Shader.Prlx_Scale, Width, YScale);
		shader_set_uniform_f(Shader.Prlx_Texel, PixelSize);
		
		// Set incline height
		if InclineHeight != 0 
		{
		    shader_set_uniform_f(Shader.Prlx_Step, (InclineForce / 10) * InclineHeight);
			shader_set_uniform_f(Shader.Prlx_Hght, InclineHeight);
		}
		
		// Draw parallax piece
		if YScaleMode
		{
			draw_sprite_part_ext(BackgroundSprites[i], 0, 0, Top, Width, Height, DrawX + PosX, DrawY, 1, YScale, c_white, 1);
		}
		else
		{
			draw_sprite_part(BackgroundSprites[i], 0, 0, Top, Width, Height, DrawX + PosX, DrawY);
		}
		
		// Reset incline height (else entire background will be under this effect)
		if InclineHeight != 0 
		{
			shader_set_uniform_f(Shader.Prlx_Hght, 0); 
		}
	}
	
	// Reset shader
	shader_reset();
}