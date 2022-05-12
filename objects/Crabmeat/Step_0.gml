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
			PosY += Ysp;
			Ysp  += 0.21875;
			
			// Check for floor
			var FindFloor = tile_find_v(PosX, PosY + 16, true, LayerA)[0];
			if  FindFloor < 0
			{
				PosY += FindFloor;
				animation_play(sprite_index, 16, 0);
				
				// Increment state
				StateTimer = 127;
				State	  += 1;
			}
		}
		break;
		case 1:
		{	
			// Move
			if (--StateTimer)
			{
				PosX += 0.5 * Direction;
			}
			
			// Check for floor
			if StateTimer mod 2 == 0
			{
				var FindFloor = tile_find_v(PosX + 16 * Direction, PosY + 16, true, LayerA)[0]; 
			}
			else
			{
				var FindFloor = tile_find_v(PosX, PosY + 16, true, LayerA);
			}
			
			// Increment state
			if StateTimer mod 2 == 0 or !StateTimer
			{
				if StateTimer mod 2 == 0 and !(FindFloor < -8 or FindFloor >= 12)
				{
					break;
				}	
				
				if object_is_onscreen(id)
				{
					// Crabmeat should fire
					State += 2;
				}
				else
				{
					// Crabmeat should turn around
					State += 1;
				}
				PreviousSprite = sprite_index;
				StateTimer     = 59;
				
				animation_set(sprite_index, 0);
			}
			
			// Adhere to the surface
			else
			{	
				if FindFloor[1] >= 8.44 and FindFloor[1] <= 351.56
				{
					// If surface is angled, update sprite
					image_xscale = FindFloor[1] > 180 ? -1 : 1;
					sprite_index = spr_obj_crabmeat_move_angled;
				}
				else
				{
					sprite_index = spr_obj_crabmeat_move;
				}
				
				PosY += FindFloor[0];				
				animation_play(sprite_index, 16, 0);
			}
		}
		break;
		
		// Wait until next action...
		case 2:
		case 3:
		{
			if !(--StateTimer)
			{
				// Fire!..
				if State == 3
				{
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
					
					// Increment state
					StateTimer = 59;
					State	  += 1;
				}
				
				// ...or turn around and continue to walk
				else
				{	
					StateTimer    = 127;
					State		 -=   1;
					Direction    *=  -1;
					image_xscale *=  -1;
				
					animation_play(PreviousSprite, 16, 0); image_index = 1;
				}
			}
		}
		break;
		
		// If performed fire action, wait for a second and then continue to walk
		case 4:
		{
			if !(--StateTimer)
			{
				StateTimer    = 127;
				State		 -=   3;
				Direction    *=  -1;
				image_xscale *=  -1;
					
				animation_play(PreviousSprite, 16, 0); image_index = 1;
			}
		}
		break;	
	}
	
	// Update position
	x = floor(PosX);
	y = floor(PosY);