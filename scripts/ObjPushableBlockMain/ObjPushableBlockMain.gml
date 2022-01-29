function ObjPushableBlockMain()
{
	// Do collision
	object_act_solid(true, true, true, false);
	
	if State == 0 and !Player.Grounded
	{
		return;
	}
	else switch State
	{
		// Grounded
		case 0:
		{
			// Check for being pushed
			if object_check_push(SideLeft)
			{
				Player.Inertia = 0.25;
				Player.PosX   += 1;
				
				PosX	 += 1;
				Direction = FlipRight;
			}
			else if object_check_push(SideRight)
			{
				Player.Inertia = -0.25;
				Player.PosX   -= 1;
				
				PosX	 -= 1;
				Direction = FlipLeft;
			}
			
			// Exit the code if not pushing
			else
			{
				return;
			}
			
			// Play sound
			if !audio_sfx_is_playing(sfxPush)
			{
				audio_sfx_play(sfxPush, false);
			}
			
			// Check for floor collision
			var FindFloor = tile_find_v(PosX, PosY + 16, true, false, LayerA)[0];
			if  FindFloor > 4
			{
				if Direction == FlipRight
				{
					PosX--;
				}
				State	 += 1;
				ClipTimer = 4;
				
				// Clear player push flag
				Player.Pushing = false;
			}
			else
			{
				PosY += FindFloor;
			}
			
			// Check for wall collision
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
			var FindFloor = tile_find_v(PosX, PosY + 16, true, false, LayerA)[0];
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