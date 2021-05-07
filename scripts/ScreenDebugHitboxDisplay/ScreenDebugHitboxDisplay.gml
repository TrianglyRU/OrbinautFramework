function ScreenDebugHitboxDisplay()
{
	// Exit the code if devmode is disabled
	if (!Game.DevMode) exit;
	
	// Activate hitbox debugging
	if Stage.State != ActStateLoading
	{
		if keyboard_check_pressed(ord("E"))
		{
			DebugHitboxes = !DebugHitboxes;
		}
	}

	// Check if general and hitbox debugging is enabled
	if DebugToggle and DebugHitboxes
	{		
		// Draw player hitbox
		with Player
		{
			if Animation == AnimCrouch or Animation == AnimSpindash
			{
				var pTop    = floor(PosY - 4);
				var pLeft   = floor(PosX - 8);
				var pRight  = floor(PosX + 8);
				var pBottom = floor(PosY + 16);	
			}
			else
			{
				var pLeft   = floor(PosX - 8);
				var pRight  = floor(PosX + 8);			     
				var pTop	= floor(PosY - yRadius + 3);
				var pBottom = floor(PosY + yRadius - 3);
			}
			
			draw_set_alpha(0.5);
			draw_rectangle_colour(pLeft, pTop, pRight, pBottom, $ff00ff, $ff00ff, $ff00ff, $ff00ff, false);
			draw_set_alpha(1.0);
		}
			
		// Draw object hitbox
		with Objects 
		{
			if variable_instance_exists(id, "objXRadiusHit")
			{
				draw_set_alpha(0.5);
				draw_rectangle_colour(x - objXRadiusHit, y - objYRadiusHit, x + objXRadiusHit - 1, y + objYRadiusHit - 1, $ff00ff, $ff00ff, $ff00ff, $ff00ff, false);		
				draw_set_alpha(1.0);
			}
		}
	}
} 