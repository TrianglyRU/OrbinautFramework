function ObjBarrierMain()
{
	switch Player.BarrierType
	{
		// Normal barrier
		case BarrierNormal:
		{
			// Play animation
			animation_play(spr_barrier_normal, 2, 0);
			
			// Set object depth
			object_set_depth(Player, true);
		}
		break;
		
		// Thunder barrier
		case BarrierThunder:
		{
			// Play animation
			animation_play(spr_barrier_thunder, 2, 0);	
			
			// Switch object depth
			if image_index == 18
			{
				object_set_depth(Player, false);
			}
			if image_index == 39
			{
				object_set_depth(Player, true);
			}
		}
		break;
		
		// Flame barrier
		case BarrierFlame:
		{
			// Check if the barrier ability wasn't used
			if !Player.BarrierIsActive
			{
				// Play animation
				animation_play(spr_barrier_flame, 2, 0);
				
				// Reset horizontal scale
				image_xscale = 1;
			
				// Switch object depth
				if (image_index + 1) mod 2 == 0
				{
					object_set_depth(Player, true);
				}
				else
				{
					object_set_depth(Player, false);
				}
			}
			
			// Check if the barrier ability was used
			else
			{
				// Play animation
				animation_play(spr_barrier_flame_dash, 2, 0);
				
				// Set object depth
				object_set_depth(Player, true);
				
				// Set the scale to the side the player is facing
				image_xscale = Player.Facing;
			}
		}
		break;
		
		// Water barrier
		case BarrierWater:
		{
			// Set object depth
			object_set_depth(Player, true);
			
			// Check if the barrier ability wasn't used
			if !Player.BarrierIsActive
			{
				// Play animation
				if sprite_index == spr_barrier_water_bounce
				{
					var Frame = image_index;
					if  Frame == 0
					{
						var Duration = 13;
					}
					else
					{
						var Duration = 7;
					}
					animation_play(spr_barrier_water_bounce, Duration, 2);
					
					// Reset to normal animation
					if image_index == 2
					{
						sprite_index = spr_barrier_water;
						image_index  = 0;
					}
				}
				else
				{
					animation_play(spr_barrier_water, 2, 0);
				}
			}
			
			// Check if the barrier ability was used
			else
			{
				// Play animation
				if sprite_index == spr_barrier_water_drop
				{
					var Frame = image_index;
					if !Frame
					{
						var Duration = 6;
					}
					else
					{
						var Duration = 19;
					}
					animation_play(spr_barrier_water_drop, Duration, 2);
				
					// Reset to normal animation
					if image_index == 2
					{
						sprite_index = spr_barrier_water;
						image_index  = 0;
					}
				}
				else
				{
					animation_play(spr_barrier_water, 2, 0);
				}
			}			
		}
		break;
	}
	
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
	object_update_position(Player.PosX, Player.PosY);
}