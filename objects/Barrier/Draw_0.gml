/// @description Display
// You can write your code in this editor

	// Choose barrier to display
	switch Player.BarrierType
	{
		case BarrierNormal:
		{
			animation_play(spr_barrier_normal, 1, 1);
			object_set_depth(Player, true);
		}
		break;
		case BarrierThunder:
		{
			animation_play(spr_barrier_thunder, 2, 1);	
			
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
		case BarrierFlame:
		{
			if !Player.BarrierIsActive
			{
				// Play animation
				animation_play(spr_barrier_flame, 2, 1);
				
				image_xscale = 1;
			
				// Switch depth every second frame
				if animation_get_frame(id) mod 2 != 0
				{
					object_set_depth(Player, false);
				}
				else
				{
					object_set_depth(Player, true);
				}
			}
			else
			{
				animation_play(spr_barrier_flame_dash, 2, 1);
				
				object_set_depth(Player, true);
				
				image_xscale = Player.Facing;
			}
		}
		break;
		case BarrierWater:
		{
			animation_play(spr_barrier_water, 2, 1);
			object_set_depth(Player, true);
		}
		break;
	}
	
	// Hide when player is under invincibility bonus
	image_alpha = Player.InvincibilityBonus ? false : true;
	
	// Use player's render position
	x = floor(Player.PosX);
	y = floor(Player.PosY);
	
	draw_self();