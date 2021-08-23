function ObjCrabmeatMain()
{
	// Check if timer is higher than 0
	if (--Timer)
	{
		// Move
		if Xsp != 0 
		{
			PosX += Xsp * image_xscale;
			x = floor(PosX);
			
			// Collide tiles and check for if Crabmeat is 8 pixels away from the surface
			var FindFloor = tile_check_collision_v(x + 16 * image_xscale, y + 16, true, false, LayerA)[0];
			if  FindFloor > 8
			{
				Timer = 0;
			}
			else
			{
				y += FindFloor;
			}
			
			// Play animation
			animation_play(sprite_index, 16, 0);
		}
		
		// Fire
		else if Timer == 60
		{
			// Set sprite
			sprite_index = spr_obj_crabmeat_fire;
			
			// Create two bullets
			var i = 1;
			repeat(2)
			{
				var Bullet = instance_create_depth(x + 16 * i, y, depth, CrabmeatBullet)
				with Bullet 
				{
					Xsp = i;    
				}
				i = -1;
			}
		}
	}
	
	// If 0, flip badnik and restore speed
	else
	{
		if Xsp == 0
		{
			sprite_index = spr_obj_crabmeat_move;
			Timer        = 128;
			Xsp          = 0.5;
			
			// Set xscale to Crabmeat direction
			image_xscale *= -1;
		}
		else
		{
			// Stop Motobug
			Timer = 120;
			Xsp   = 0;
			sprite_index = spr_obj_crabmeat_idle;
		}
	}

	// Check for hitbox overlap
	object_act_enemy(EnemyBadnik)
}