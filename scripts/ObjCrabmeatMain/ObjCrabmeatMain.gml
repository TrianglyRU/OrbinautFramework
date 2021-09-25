function ObjCrabmeatMain()
{
	switch State
	{
		// Walk
		case 0:
		{
			// Animate
			animation_play(sprite_index, 16, 0);
			
			// Move and update position
			if (--Timer)
			{
				PosX += 0.5 * Direction;
				x     = floor(PosX);
			}
			
			// Check for floor
			var FindFloor  = tile_check_collision_v(x,					y + 16, true, false, LayerA);
			var CheckFloor = tile_check_collision_v(x + 16 * Direction, y + 16, true, false, LayerA)[0];
			
			// Change state
			if CheckFloor > 12 or CheckFloor < -8 or !Timer
			{
				image_index = 2;
				
				PrevAnim = sprite_index;
				Timer    = 59;
				State++;
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
			}
		}
		break;
		
		// Fire
		case 1:
		{
			if !(--Timer)
			{
				State++;
				Timer        = 59;
				Direction   *= -1;
				sprite_index = spr_obj_crabmeat_fire;
				
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
					  object_set_depth(ThisObject, false);
				  }
				}
			}
		}
		break;
		
		// Wait after firing, then start moving
		case 2:
		{
			if !(--Timer)
			{
				State		 -= 2;
				Timer         = 127;
				sprite_index  = PrevAnim;
			}
		}
		break;	
	}

	// Act as badnik
	object_act_enemy(EnemyBadnik)
}