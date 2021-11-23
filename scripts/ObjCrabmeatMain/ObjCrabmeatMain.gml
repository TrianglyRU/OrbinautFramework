function ObjCrabmeatMain()
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
			var FindFloor = tile_check_collision_v(PosX, PosY + 15, true, false, LayerA)[0];
			if  FindFloor < 0
			{
				// Adhere to the surface
				PosY += FindFloor;
				
				// Increment state
				State	  += 1;
				StateTimer = 127;
				
				// Set animation
				animation_play(sprite_index, 16, 0, 0);
			}
		}
		break;
		
		// Walk
		case 1:
		{	
			// Move
			if (--StateTimer)
			{
				PosX += 0.5 * image_xscale;
			}
			
			// Check for floor
			if StateTimer mod 2 == 0
			{
				var FindFloor = tile_check_collision_v(x + 16 * image_xscale, y + 16, true, false, LayerA)[0]; 
			}
			else
			{
				var FindFloor = tile_check_collision_v(x, y + 16, true, false, LayerA);
			}
			
			// Increment state
			if StateTimer mod 2 == 0 or !StateTimer
			{
				if (FindFloor < -8 or FindFloor >= 12) or !StateTimer
				{
					PreviousSprite = sprite_index;
					StateTimer     = 60;
					State		  += 1;
				
					// Stop animation
					animation_set(sprite_index, 0);
				}
			}
			
			// Adhere to the surface
			else
			{
				// If surface is angled, update sprite
				if FindFloor[1] >= 8.44 and FindFloor[1] <= 351.56
				{
					image_xscale = FindFloor[1] > 180 ? -1 : 1;
					sprite_index = spr_obj_crabmeat_move_angled;
				}
				else
				{
					sprite_index = spr_obj_crabmeat_move;
				}
				PosY += FindFloor[0];
				
				// Set animation
				animation_play(sprite_index, 16, 0, 0);
			}
		}
		break;
		
		// Fire or turn around
		case 2:
		{
			if !(--StateTimer)
			{
				// Fire if on-screen
				if object_is_onscreen(id)
				{
					StateTimer = 59;
					State	  += 1;
					
					// Update animation
					animation_set(spr_obj_crabmeat_fire, 0);
				
					// Create bullets
					for (var i = 1; i > -3; i -= 2)
					{
						var  ThisObject = id;
						var  NewObject  = instance_create(x + 16 * i, y, Projectile);
						with NewObject
						{
							Xsp          = i;
							Ysp		     = -4;
							sprite_index = spr_obj_projectile_crabmeat;
					  
							// Set object depth
							object_set_depth(ThisObject, 0);
						}
					}
				}
				
				// Turn around and continue to walk
				else
				{	
					StateTimer    = 127;
					State		 -=   1;
					image_xscale *=  -1;
					
					// Update animation
					animation_play(PreviousSprite, 16, 1, 0);
				}
			}
		}
		break;
		
		// Wait for a second after firing, then turn around and continue to walk
		case 3:
		{
			if !(--StateTimer)
			{
				StateTimer    = 127;
				State		 -=   2;
				image_xscale *=  -1;
					
				// Update animation
				animation_play(PreviousSprite, 16, 1, 0);
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