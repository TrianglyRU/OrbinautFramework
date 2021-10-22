function ObjBarrierMain()
{
	// Set static animation value for flame barrier
	static FlameAnimationTime = 25;
	
	// Delete barrier if player doesn't have it anymore
	if Player.BarrierType == false
	{
		instance_destroy();
	}
	switch Player.BarrierType
	{
		// Update normal barrier
		case BarrierNormal:
		{
			object_set_depth(Player, true);
			animation_play(spr_obj_barrier_normal, 2, 0, 0);
		}
		break;
		
		// Update thunder barrier
		case BarrierThunder:
		{
			if image_index == 18
			{
				object_set_depth(Player, false);
			}
			else if image_index == 39
			{
				object_set_depth(Player, true);
			}
			animation_play(spr_obj_barrier_thunder, 2, 0, 0);
		}
		break;
		
		// Update flame barrier depth and animation
		case BarrierFlame:
		{
			if sprite_index == spr_obj_barrier_flame_dash
			{
				if !(--FlameAnimationTime)
				{
					// Reset to default animation after 24 frames
					animation_play(spr_obj_barrier_flame, 2, 0, 0);
					
					// Reset timer
					FlameAnimationTime = 25;
					
					// Restore control
					Player.AirLock = false;
				}
				object_set_depth(Player, true);
			}
			else
			{
				if (image_index + 1) mod 2 == 0
				{
					object_set_depth(Player, true);
				}
				else
				{
					object_set_depth(Player, false);
				}
				animation_play(spr_obj_barrier_flame, 2, 0, 0);
			}
		}
		break;
		case BarrierWater:
		{
			if sprite_index == spr_obj_barrier_water_drop
			or sprite_index == spr_obj_barrier_water_bounce
			{
				if image_index == 2
				{
					animation_play(spr_obj_barrier_water, 2, 0, 0);
				}
			}
			else
			{
				animation_play(spr_obj_barrier_water, 2, 0, 0);
			}
			object_set_depth(Player, true);
		}
		break;
	}
	
	// Match scale to player's facing direction
	image_xscale = Player.Facing;
	
	// Hide the barrier
	if Player.InvincibleBonus or Player.SuperState
	{
		image_alpha = 0;
	}
	else
	{
		image_alpha = 1;
	}

	// Update position
	x = floor(Player.PosX);
	y = floor(Player.PosY);
}