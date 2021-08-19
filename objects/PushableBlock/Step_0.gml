/// @description
// You can write your code in this editor
	
	// Act solid
	object_act_solid(true, true, true);
	
	if Grounded
	{
		// Check for being pushed
		if object_check_push(SideLeft)
		{
			Player.Inertia = 0.25;
			Player.PosX   += 1;
			PosX		  += 1;
			Direction	   = FlipRight;	
		}
		else if object_check_push(SideRight)
		{
			Player.Inertia = -0.25;
			Player.PosX   -= 1;
			PosX		  -= 1;
			Direction	   = FlipLeft;	
		}
	}
	else
	{
		// Adjust position when airborne
		if ClipTimer--
		{
			PosX += 4 * Direction;
		}
		else
		{
			Ysp  += 0.21875;
			PosY += Ysp;
		}	
	}
	
	// Update position
	object_update_position(PosX, PosY);
	
	// Collide with walls
	object_collide_tiles_h(Direction, SideCentre, 0, LayerA);
	
	// Check for floor collision
	var CollisionCheck = object_collide_tiles_v(SideCentre, SideBottom, 0, LayerA);	
	if !CollisionCheck
	{
		if Grounded
		{
			ClipTimer = 4;
			Grounded  = false;
		}
	}
	else if !Grounded
	{
		Grounded  = true;
		Ysp		  = 0;
		ClipTimer = 4;
	}