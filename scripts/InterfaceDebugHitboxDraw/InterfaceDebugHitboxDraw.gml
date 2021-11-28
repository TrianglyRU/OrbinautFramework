function InterfaceDebugHitboxDraw()
{
	// Exit if not allowed to display
	if !Game.DevMode or !Stage.DoUpdate
	{
		exit;
	}
	
	// Toggle hitboxes debug
	if keyboard_check_pressed(ord("E"))
	{
		DebugHitboxes = !DebugHitboxes;
	}
	
	// Display hitboxes
	if DebugHitboxes
	{		
		draw_set_alpha(0.5);
		with all
		{			
			// Player hitbox
			if object_index == Player
			{
				if Game.Character != CharTails and Animation == AnimCrouch and image_index + 1 == image_number
				{
					var pTop    = floor(PosY - 4);
					var pLeft   = floor(PosX - 8);
					var pRight  = floor(PosX + 8);
					var pBottom = floor(PosY + 16);	
				}
				else
				{
					var pTop    = floor(PosY - RadiusY + 3);
					var pLeft   = floor(PosX - 8);
					var pRight  = floor(PosX + 8);
					var pBottom = floor(PosY + RadiusY - 3);	
				}
				draw_rectangle_colour(pLeft, pTop, pRight, pBottom, $ff00ff, $ff00ff, $ff00ff, $ff00ff, false);	
				
				// Draw double spin attack hitbox
				if DoubleSpinAttack
				{
					draw_rectangle_colour(floor(PosX - 24), floor(PosY - 24), floor(PosX + 24), floor(PosY + 24), $00ff00, $00ff00, $00ff00, $00ff00, false);
				}
			}
			
			// Object hitbox
			else if variable_instance_exists(id, "Obj_HitStatus")
			{
				draw_rectangle_colour(x - Obj_HitX, y - Obj_HitY, x + Obj_HitX - 1, y + Obj_HitY - 1, $ff00ff, $ff00ff, $ff00ff, $ff00ff, false);
			}			
		}
		draw_set_alpha(1.0);
	}
} 