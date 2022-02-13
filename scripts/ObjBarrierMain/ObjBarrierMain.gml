function ObjBarrierMain()
{
	static FlameAnimationTime = 25;
	
	// Destroy if player has no barrier
	if Player.BarrierType == false
	{
		instance_destroy();
	}
	
	// Update barrier
	else switch Player.BarrierType
	{
		case BarrierNormal:
		{
			animation_play(sprite_index, 4, 0);
		}
		break;
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
	
	// Update visuals
	if Player.InvincibleBonus or Player.SuperState
	{
		image_alpha = 0;
	}
	else
	{
		image_alpha = 1;
	}
	image_xscale = Player.Facing;

	// Update position
	x = floor(Player.PosX);
	y = floor(Player.PosY);
}