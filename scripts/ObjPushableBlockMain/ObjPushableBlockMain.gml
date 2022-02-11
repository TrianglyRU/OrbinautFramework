function ObjPushableBlockMain()
{
	switch State
	{
		case 0:
		{
			// Do collision
			object_act_solid(true, true, true, false);
			
			// Check for being pushed
			if Player.Grounded and object_check_touch(ColSolidP)
			{
				if floor(Player.PosX) < x
				{
					Player.Gsp   = 0.25;
					Player.PosX += 1;
				
					PosX	 += 1;
					Direction = FlipRight;
				}
				if floor(Player.PosX) > x
				{
					Player.Gsp   = -0.25;
					Player.PosX -= 1;
				
					PosX	 -= 1;
					Direction = FlipLeft;
				}
			}
			else
			{
				break;
			}
			
			if !audio_sfx_is_playing(sfxPush)
			{
				audio_sfx_play(sfxPush, false);
			}
			
			// Check for floor
			var FindFloor = tile_find_v(PosX, PosY + 16, true, false, LayerA)[0];
			if  FindFloor > 4
			{
				if Direction == FlipRight
				{
					PosX	    -= 1;
					Player.PosX -= 1;
				}
				
				Player.Xsp	   = 0;
				Player.Gsp     = 0;
				Player.Pushing = false;
				
				// Increment state
				ClipTimer = 4;
				State	 += 1;
			}
			else
			{
				PosY += FindFloor;
			}
			
			// Check for walls and increment state if the wall was found
			var FindWall = tile_find_h(PosX - 16, PosY, false, true, LayerA)[0];
			if  FindWall < 0
			{
				PosX  -= FindWall;
				State += 2;
			}
			var FindWall = tile_find_h(PosX + 16, PosY, true, true, LayerA)[0];
			if  FindWall < 0
			{
				PosX  += FindWall;
				State += 2;
			}
		}
		break;
		case 1:
		{
			// Move and fall
			if ClipTimer--
			{
				PosX += 4 * Direction;
			}
			else
			{
				Ysp  += 0.21875;
				PosY += Ysp;
			}
		
			// Check for floor
			var FindFloor = tile_find_v(PosX, PosY + 16, true, false, LayerA)[0];
			if  FindFloor < 0
			{
				PosY += FindFloor;
				Ysp	  = 0;
				
				// Decrement state
				State = 0;
			}
		}
	}
	
	// Update position
	x = floor(PosX);
	y = floor(PosY);
}