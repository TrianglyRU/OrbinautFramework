function ObjBarrierMain()
{
	// Flame Barrier animation duration
	static FlameAnimationTime = 25;
	
	if Player.BarrierType == false
	{
		instance_destroy();
	}
	
	// Update barrier
	else switch Player.BarrierType
	{
		case BarrierThunder:
		{
			if image_index == 19
			{
				object_set_depth(Player, 0);
			}
			else if image_index == 39
			{
				object_set_depth(Player, 1);
			}
		}
		break;
		case BarrierFlame:
		{
			if sprite_index == spr_obj_barrier_flame_dash
			{
				if !(--FlameAnimationTime)
				{
					// Reset timer and restore player's control
					FlameAnimationTime = 25;
					Player.AirLock     = false;
					
					// Reset animation
					animation_play(spr_obj_barrier_flame, 2, 0);
				}
			}
			else
			{
				if (image_index + 1) mod 2 == 0
				{
					object_set_depth(Player, 1);
				}
				else
				{
					object_set_depth(Player, 0);
				}
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
					// Reset animation
					animation_play(spr_obj_barrier_water, 2, 0);
				}
			}
			object_set_depth(Player, 1);
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