function ScreenDebugSolidboxDisplay()
{
	// Exit the code if devmode is disabled
	if (!Game.DevMode) exit;
	
	// Activate solidbox debugging
	if Stage.State != ActStateLoading
	{
		if keyboard_check_pressed(ord("W"))
		{
			DebugSolids = !DebugSolids;
		}
	}

	// Check if general and hitbox debugging is enabled
	if DebugToggle and DebugSolids
	{
		// Draw player solidbox
		with Player
		{
			var pTop    = floor(PosY - yRadius);
			var pLeft   = floor(PosX - 10);
			var pRight  = floor(PosX + 10);
			var pBottom = floor(PosY + yRadius);
			
			draw_set_alpha(0.5);
			draw_rectangle_colour(pLeft, pTop, pRight, pBottom, $00ffff, $00ffff, $00ffff, $00ffff, false);
			draw_set_alpha(1.0);
		}
			
		// Draw object hitbox
		with Objects 
		{
			if variable_instance_exists(id, "objXRadiusSolid")
			{
				if Player.OnObject == id
				{
					draw_set_alpha(0.8);
					
					if variable_instance_exists(id, "isPlatformObj") and isPlatformObj
					{
						draw_line_colour(x - objXRadiusSolid - 1,  y - objYRadiusSolid - 20, x + objXRadiusSolid - 1, y - objYRadiusSolid - 20, $00ff00, $00ff00);
					}
					else
					{
						draw_line_colour(x - objXRadiusSolid - 11, y - objYRadiusSolid - 20, x + objXRadiusSolid + 9, y - objYRadiusSolid - 20, $00ff00, $00ff00);
					}
					
					draw_set_alpha(1.0);
				}
				else
				{
					draw_set_alpha(0.5);
					
					if variable_instance_exists(id, "isCollidable")
					{
						if variable_instance_exists(id, "isSlopeObj") and isSlopeObj != false
						{
							for (var i = 0; i < objXRadiusSolid * 2; i++)
							{
								var arrayX = floor(x - objXRadiusSolid + i);
								var baseY  = image_yscale ? floor(y + objYRadiusSolid) : floor(y - objYRadiusSolid);
								
								if image_xscale
								{
									var arrayY = image_yscale ? floor(y - isSlopeObj[i]) : floor(y + isSlopeObj[i]);
								}
								else
								{
									var arrayY = image_yscale ? floor(y - isSlopeObj[objXRadiusSolid * 2 - i]) : floor(y + isSlopeObj[objXRadiusSolid * 2 - i]);
								}
								draw_line_colour(arrayX, arrayY, arrayX, baseY, $00ff00, $00ff00);
							}	
						}
						else
						{
							draw_rectangle_colour(x - objXRadiusSolid, y - objYRadiusSolid, x + objXRadiusSolid - 1, y + objYRadiusSolid - 1, $00ff00, $00ff00, $00ff00, $00ff00, false);
						}
					}
					else
					{
						draw_rectangle_colour(x - objXRadiusSolid, y - objYRadiusSolid, x + objXRadiusSolid - 1, y + objYRadiusSolid - 1, $00ffff, $00ffff, $00ffff, $00ffff, false);
					}
					
					draw_set_alpha(1.0);	
					
				}		
			}
		}
	}
}