function ObjPushableBlockMain()
{
	// Do collision
	object_act_solid(true, true, true, false);
	
	switch State
	{
		// Grounded
		case 0:
		{
			// Check for being pushed
			if object_check_touch(SideLeft)
			{
				Player.Inertia = 0.25;
				Player.PosX   += 1;
				
				PosX	 += 1;
				Direction = FlipRight;				
			}
			else if object_check_touch(SideRight)
			{
				Player.Inertia = -0.25;
				Player.PosX   -= 1;
				
				PosX	 -= 1;
				Direction = FlipLeft;
			}
			
			// Check for floor collision
			var FindFloor = tile_check_collision_v(PosX, PosY + 16, true, false, LayerA)[0];
			if  FindFloor > 0
			{
				PosX     -= Direction;
				State	 += 1;
				ClipTimer = 4;
				
				// Clear player push flag
				Player.Pushing = false;
			}
			
			// Check for wall collision
			var LeftDistance = tile_check_collision_h(PosX - 16, PosY, false, true, LayerA)[0];
			if  LeftDistance < 0
			{
				PosX  -= LeftDistance;
				State += 2;
			}
			var RightDistance = tile_check_collision_h(PosX + 16, PosY, true, true, LayerA)[0];
			if  RightDistance < 0
			{
				PosX  += RightDistance;
				State += 2;
			}
		}
		break;
		
		// Airborne
		case 1:
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
		
			// Check for floor collision
			var FindFloor = tile_check_collision_v(PosX, PosY + 16, true, false, LayerA)[0];
			if  FindFloor < 0
			{
				PosY += FindFloor;
				State = 0;
				Ysp	  = 0;
			}
		}
	}
	
	// Update position
	x = floor(PosX);
	y = floor(PosY);
}