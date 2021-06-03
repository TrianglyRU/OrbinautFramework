/// @description Insert description here
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
			animation_play(spr_barrier_thunder, 3, 1);	
			
			if animation_get_frame(id) == 13
			{
				object_set_depth(Player, false);
			}
			if animation_get_frame(id) == 22
			{
				object_set_depth(Player, true);
			}
		}
		break;
		case BarrierFlame:
		{
			animation_play(spr_barrier_flame, 2, 1);
			
			if animation_get_frame(id) mod 2 != 0
			{
				object_set_depth(Player, false);
			}
			else
			{
				object_set_depth(Player, true);
			}
		}
	}
	
	// Use player's render position
	x = floor(Player.PosX);
	y = floor(Player.PosY);
	
	// Draw self
	draw_self();