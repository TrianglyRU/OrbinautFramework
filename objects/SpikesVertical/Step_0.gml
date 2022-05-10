/// @description Main
// You can write your code in this editor
	
	// Do collision
	if !Player.InvincibleBonus and !Player.InvincibilityFrames and !Player.SuperState
	{
		object_act_solid(true, true, true, true);
	}
	else
	{
		// Allow player to bounce and perform dropdash on the spikes if they're invincible
		object_act_solid(true, true, true, false);
	}
	
	// Damage player
	if object_check_player(image_yscale == 1 ? ColSolidU : ColSolidD)
	{
		player_damage(false, false, false);
	}