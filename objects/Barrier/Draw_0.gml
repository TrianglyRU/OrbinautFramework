/// @description Insert description here
// You can write your code in this editor
	
	// Choose barrier to display
	switch Player.BarrierType
	{
		case BarrierNormal:
			animation_play(spr_barrier_normal, 1, 1);
		break;
	}
	
	// Use player's render position
	x = floor(Player.PosX);
	y = floor(Player.PosY - Player.Rolling * (Player.yRadiusDefault - Player.yRadiusRoll));
	
	// Draw self
	draw_self();