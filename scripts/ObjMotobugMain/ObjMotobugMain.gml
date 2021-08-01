function ObjMotobugMain()
{
	// Is motobug currently stopped?
	if StopTimer 
	{
		// Count down the timer
		StopTimer--;
		
		// Flip Motobug and restore its speed
		if !StopTimer
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
				var  SmokeObj = instance_create(floor(PosX - 19 * Direction), floor(PosY - 1), MotobugSmoke);
				with SmokeObj
				{
					object_set_depth(ThisID, false);
				}
				SmokeTimer = 17;
			}
		}
		
		animation_play(spr_obj_motobug, 8, 1);
		
		// Collide tiles & check for if Motobug is 2 pixels away from the surface
		var CollideFloor = object_collide_tiles_v(false, SideBottom, 2, LayerA);
		if !CollideFloor
		{
			animation_set_frame(sprite_index, 1);
			
			// Stop Motobug
			StopTimer = 60;
			Xsp       = 0;
		}
	}
	
	// Update image direction
	image_xscale = Direction;
	
	// Act as badnik
	object_act_enemy(EnemyBadnik);
}