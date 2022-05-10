/// @description Main
// You can write your code in this editor
	
	// Do collision
	object_act_solid(true, true, true, false);
	
	// Damage player
	if object_check_player(image_xscale == 1 ? ColSolidR : ColSolidL)
	{
		player_damage(false, false, false);
	}