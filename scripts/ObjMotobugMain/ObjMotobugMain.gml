function ObjMotobugMain()
{
	switch State
	{
		// Moving
		case 0:
		{
			// Move Motobug
			PosX += image_xscale;
			
			// Collide tiles and check for if Motobug is 8 pixels away from the surface
			var FindFloor = tile_check_collision_v(PosX, PosY + 15, true, false, LayerA)[0];
			if  FindFloor > 8
			{
				// Stop animation
				animation_stop(0, 0);
				
				// Stop Motobug
				State++;
				Timer = 59;
			}
			else
			{
				// Create smoke object every 16 frames
				if !(--Timer)
				{
					var  ThisObject = id;
					var  NewObject  = instance_create(x - 19 * image_xscale, y - 1, MotobugSmoke);
					with NewObject
					{
						object_set_depth(ThisObject, false);
					}
					Timer = 16;
				}
				
				// Attach to the surface
				if FindFloor > -16
				{
					PosY += FindFloor;
				}
				
				// Update position
				x = floor(PosX);
				y = floor(PosY);
			}
		}
		break;
		
		// Idle
		case 1:
		{
			if !(--Timer)
			{
				State		 -= 1
				image_xscale *= -1;
				
				// Set animation
				animation_set(sprite_index, 8, 0, 0);
			}
		}
		break;
		
	}
	
	// Act as badnik
	object_act_enemy(EnemyBadnik);
}