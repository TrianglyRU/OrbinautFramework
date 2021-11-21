function ObjCrabmeatMain()
{
	switch State
	{
		// Walk
		case 0:
		{	
			// Move and update position
			if (--Timer)
			{
				PosX += 0.5 * image_xscale;
				x     = floor(PosX);
			}
			
			// Check for floor
			var FindFloor = tile_check_collision_v(x, y + 16, true, false, LayerA);
			var EdgeCheck = tile_check_collision_v(x + 16 * image_xscale, y + 16, true, false, LayerA)[0];
			
			// Change state
			if EdgeCheck > 12 or EdgeCheck < -8 or !Timer
			{	
				PrevAnim = sprite_index;
				Timer    = 59;
				State++;
				
				// Stop animation
				animation_set(sprite_index, 0);
			}
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
				
				// Align to surface
				y += FindFloor[0];
				
				// Set animation
				animation_play(sprite_index, 16, 0, 0);
			}
		}
		break;
		
		// Fire or continue walking
		case 1:
		{
			if !(--Timer)
			{
				if object_is_onscreen(id)
				{
					State++;
					Timer         = 59;
					image_xscale *= -1;
					
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
							Ysp		   = -4;
							sprite_index = spr_obj_projectile_crabmeat;
					  
							// Set object depth
							object_set_depth(ThisObject, 0);
						}
					}
				}
				else
				{
					State -= 1;
					Timer = 127;
					
					// Update animation
					animation_play(PrevAnim, 16, 1, 0);
				}
			}
		}
		break;
		
		// Wait after firing, then start moving
		case 2:
		{
			if !(--Timer)
			{
				State -= 2;
				Timer  = 127;
					
				// Update animation
				animation_play(PrevAnim, 16, 1, 0);
			}
		}
		break;	
	}

	// Act as badnik
	object_act_enemy(TypeBadnik);
}