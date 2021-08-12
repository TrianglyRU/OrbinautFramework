function ObjBarrierMain()
{
	// Exit if stage update is disabled
	if !Stage.DoUpdate
	{
		exit;
	}
	
	// Get current player barrier
	switch Player.BarrierType
	{
		// Normal barrier
		case BarrierNormal:
		{
			// Play animation
			animation_play(spr_barrier_normal, 2, 1);
			
			// Set object depth
			object_set_depth(Player, true);
		}
		break;
		
		// Thunder barrier
		case BarrierThunder:
		{
			// Play animation
			animation_play(spr_barrier_thunder, 2, 1);	
			
			// Switch object depth
			if animation_get_frame(id) == 19
			{
				object_set_depth(Player, false);
			}
			if animation_get_frame(id) == 40
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
				animation_play(spr_barrier_flame, 2, 1);
				
				// Reset horizontal scale
				image_xscale = 1;
			
				// Switch object depth
				if animation_get_frame(id) mod 2 == 0
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
				animation_play(spr_barrier_flame_dash, 2, 1);
				
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
			// Play animation
			animation_play(spr_barrier_water, 2, 1);
			
			// Set object depth
			object_set_depth(Player, true);
		}
		break;
	}
	
	// Hide the barrier when the player is under invincibility bonus
	if Player.InvincibilityBonus or Player.SuperState
	{
		image_alpha = 0;
	}
	else
	{
		image_alpha = 1;
	}
}