function ObjPushableBlockMain()
{
	// Do collision
	object_act_solid(true, true, true, false);
	
	// Check for being pushed
	if Grounded
	{
		if !FoundWall
		{
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
	}
	
	// Adjust position when airborne
	else
	{
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
	
	// Collide with walls
	var LeftDistance = tile_check_collision_h(PosX - 16, PosY, false, true, LayerA)[0];
	if  LeftDistance < 0
	{
		PosX     -= LeftDistance;
		FoundWall = true;
	}
	var RightDistance = tile_check_collision_h(PosX + 16, PosY, true, true, LayerA)[0];
	if  RightDistance < 0
	{
		PosX     += RightDistance;
		FoundWall = true;
	}
	
	// Check for floor collision
	var FindFloor = tile_check_collision_v(PosX, PosY + 16, true, false, LayerA)[0];
	if  FindFloor < 0
	{
		if !Grounded
		{
			PosY	 += FindFloor;
			Grounded  = true;
			Ysp		  = 0;
		}
	}
	else if FindFloor > 0
	{
		if Grounded
		{
			ClipTimer = 4;
			Grounded  = false;
		}
	}
	
	// Update position
	object_update_position(PosX, PosY);
}