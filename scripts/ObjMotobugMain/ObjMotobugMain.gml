function ObjMotobugMain()
{
	switch State
	{
		// Spawn
		case 0:
		{
			// Fall to the ground
			PosY += Ysp;
			Ysp  += 0.21875;
			
			// Check for the floor
			var FindFloor = tile_find_v(PosX, PosY + 15, true, false, LayerA)[0];
			if  FindFloor < 0
			{
				// Adhere to the surface
				PosY += FindFloor;
				
				// Increment state
				State	  += 1;
				StateTimer = 16;
				
				// Set animation
				animation_play(sprite_index, 8, 0);
			}
		}
		break;
		
		// Moving
		case 1:
		{
			// Move Motobug
			PosX += image_xscale;
			
			// Check for the floor
			var FindFloor = tile_find_v(PosX, PosY + 15, true, false, LayerA)[0];
			if  FindFloor >= 12 or FindFloor < -8
			{
				// Stop animation
				animation_set(sprite_index, 0);
				
				// Increment state
				State	  += 1;
				StateTimer = 60;
			}
			else
			{
				// Create smoke object every 16 frames
				if !(--StateTimer)
				{
					var  ThisObject = id;
					var  NewObject  = instance_create(x - 19 * image_xscale, y - 1, MotobugSmoke);
					with NewObject
					{
						object_set_depth(ThisObject, 0);
					}
					StateTimer = 16;
				}
				
				// Adhere to the surface
				PosY += FindFloor;
			}
		}
		break;
		
		// Idle
		case 2:
		{
			if !(--StateTimer)
			{
				State		 -= 1
				image_xscale *= -1;
				
				// Set animation
				animation_play(sprite_index, 8, 0);
			}
		}
		break;
	}
	
	// Update position
	x = floor(PosX);
	y = floor(PosY);
	
	// Act as badnik
	object_act_enemy(TypeBadnik);
}