function InterfaceDebugHitboxDraw()
{
	// Exit the code if disabled
	if !DebugHitboxes
	{
		exit;
	}
	draw_set_alpha(0.5);
	
	with all
	{			
		// Draw player's hitbox
		if object_index == Player
		{
			if DoubleSpinAttack
			{
				draw_rectangle_colour(HitboxData[1][0], HitboxData[1][1], HitboxData[1][2], HitboxData[1][3], $00ff00, $00ff00, $00ff00, $00ff00, false);
			}
			draw_rectangle_colour(HitboxData[0][0], HitboxData[0][1], HitboxData[0][2], HitboxData[0][3], $ff00ff, $ff00ff, $ff00ff, $ff00ff, false);	
		}
			
		// Draw object's hitbox
		else if variable_instance_exists(id, "Obj_HitX")
		{
			draw_rectangle_colour(x - Obj_HitX, y - Obj_HitY, x + Obj_HitX - 1, y + Obj_HitY - 1, $ff00ff, $ff00ff, $ff00ff, $ff00ff, false);
		}			
	}
	draw_set_alpha(1.0);
} 