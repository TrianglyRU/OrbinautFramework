function ObjMotobugMain()
{
	// Is motobug currently stopped?
	if StopTimer 
	{
		// Flip Motobug and restore its speed
		if !(--StopTimer)
		{
			Xsp		      =  1;
			image_xscale *= -1;
		}
	}
	
	// Move Motobug
	PosX += Xsp * image_xscale;
	
	// Is Motobug currently moving?
	if Xsp != 0
	{
		if SmokeTimer
		{
			SmokeTimer--
			if !SmokeTimer
			{
				var  ThisID   = id;
				var  Object = instance_create_children(x - 19 * image_xscale, y - 1, MotobugSmoke, ChildrenData);
				with Object
				{
					object_set_depth(ThisID, false);
				}
				SmokeTimer = 17;
			}
		}
		
		// Play animation
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
	x = floor(PosX);
	y = floor(PosY);
	
	// Act as badnik
	object_act_enemy(EnemyBadnik);
}