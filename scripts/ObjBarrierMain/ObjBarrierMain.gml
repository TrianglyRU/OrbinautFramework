function ObjBarrierMain()
{
	// Delete barrier if player doesn't have barrier anymore
	if Player.BarrierType == false
	{
		instance_destroy();
	}
	else 
	{
		switch Player.BarrierType
		{
			case BarrierNormal:
			{
				// Play animation
				animation_play(spr_obj_barrier_normal, 2, 0);
			
				// Set object depth
				object_set_depth(Player, true);
			}
			break;
			case BarrierThunder:
			{
				// Play animation
				animation_play(spr_obj_barrier_thunder, 2, 0);	
			
				// Switch object depth
				if image_index == 18
				{
					object_set_depth(Player, false);
				}
				else if image_index == 39
				{
					object_set_depth(Player, true);
				}
			}
			break;
			case BarrierFlame:
			{
				// Play animation
				animation_play(sprite_index, 2, 0);
			
				// Dash animation
				if sprite_index == spr_obj_barrier_flame_dash
				{
					// Set object depth
					object_set_depth(Player, true);
				
					// Reset to default animation after 24 frames
					static FlameAnimationTime = 25;
					if !(--FlameAnimationTime)
					{
						FlameAnimationTime = 25;
						animation_set(spr_obj_barrier_flame, 0);
					
						// Restore control
						Player.AirLock = false;
					}
				}
				else
				{
					// Default animation
					sprite_index = spr_obj_barrier_flame;
				
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
			}
			break;
			case BarrierWater:
			{
				// Set object depth
				object_set_depth(Player, true);
			
				if !Player.BarrierIsActive
				{
					// If bouncing animation is playing, end it
					if sprite_index == spr_obj_barrier_water_bounce
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
						animation_play(sprite_index, Duration, 2);
					
						// Reset
						if image_index == 2
						{
							animation_set(spr_obj_barrier_water, 0);
						}
					}
				
					// Play default animation
					else
					{
						animation_play(spr_obj_barrier_water, 2, 0);
					}
				}
				else
				{
					// Play drop animation
					if sprite_index == spr_obj_barrier_water_drop
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
						animation_play(spr_obj_barrier_water_drop, Duration, 2);
				
						// Reset
						if image_index == 2
						{
							animation_set(spr_obj_barrier_water, 0);
						}
					}
				
					// Play default animation if dropping for too long
					else
					{
						animation_play(spr_obj_barrier_water, 2, 0);
					}
				}
			}
			break;
		}
		
		// Match scale to player's facing direction
		image_xscale = Player.Facing;
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
	x = floor(Player.PosX);
	y = floor(Player.PosY);
}