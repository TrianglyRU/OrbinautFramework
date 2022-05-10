/// @description Main
// You can write your code in this editor
	
	// Act as badnik and exit if it was destroyed
	if object_act_enemy(EnemyBadnik)
	{
		return;
	}
	
	switch State
	{
		case 0:
		{
			// Fall to the ground
			PosY += Ysp;
			Ysp  += 0.21875;
			
			// Check for floor
			var FindFloor = tile_find_v(PosX, PosY + 15, true, false, LayerA)[0];
			if  FindFloor < 0
			{
				PosY += FindFloor;
				animation_play(sprite_index, 8, 0);
				
				// Increment state
				StateTimer = 16;
				State	  += 1;
			}
		}
		break;
		case 1:
		{
			// Move
			PosX += image_xscale;
			
			// Check for floor
			var FindFloor = tile_find_v(PosX, PosY + 15, true, false, LayerA)[0];
			if  FindFloor >= 12 or FindFloor < -8
			{
				animation_set(sprite_index, 0);
				
				// Increment state
				StateTimer = 60;
				State	  += 1;
			}
			else
			{
				if !(--StateTimer)
				{
					// Create smoke object every 16th frame
					var  ThisObject = id;
					var  NewObject  = instance_create(x - 19 * image_xscale, y - 1, MotobugSmoke);
					with NewObject
					{
						object_set_depth(ThisObject, 0);
					}
					StateTimer = 16;
				}
				PosY += FindFloor;
			}
		}
		break;
		case 2:
		{
			if !(--StateTimer)
			{
				// Decrement state
				State		 -=  1
				image_xscale *= -1;
				
				animation_play(sprite_index, 8, 0);
			}
		}
		break;
	}
	
	// Update position
	x = floor(PosX);
	y = floor(PosY);