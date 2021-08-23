function ObjMotobugMain()
{
	// Is motobug currently stopped?
	if StopTimer 
	{
		// Flip Motobug and restore its speed
		if !(--StopTimer)
		{
			Xsp		   =  1;
			Direction *= -1;
		}
	}
	
	// Move Motobug
	PosX += Xsp * Direction;
	
	// Is Motobug currently moving?
	if Xsp != 0
	{
		if SmokeTimer
		{
			SmokeTimer--
			if !SmokeTimer
			{
				var  ThisID   = id;
				var  Object = instance_create(x - 19 * Direction, y - 1, MotobugSmoke);
				with Object
				{
					object_set_depth(ThisID, false);
				}
				SmokeTimer = 17;
			}
		}
		
		animation_play(spr_obj_motobug, 8, 0);
		
		// Collide tiles and check for if Motobug is 8 pixels away from the surface
		var FindFloor = tile_check_collision_v(PosX, PosY + 15, true, false, LayerA)[0];
		if  FindFloor > 8
		{
			// Set first frame
			image_index = 0;
			
			// Stop Motobug
			StopTimer = 60;
			Xsp       = 0;
		}
		else if FindFloor > -8
		{
			PosY += FindFloor;
		}
	}
	
	// Update position
	object_update_position(PosX, PosY);
	
	// Update image direction
	image_xscale = Direction;
	
	// Act as badnik
	object_act_enemy(EnemyBadnik);
}