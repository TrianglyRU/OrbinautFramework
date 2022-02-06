function ObjSpikesVerticalMain()
{
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
	if object_check_touch(image_yscale == 1 ? TypeSolidU : TypeSolidD)
	{
		player_damage(false, false, false);
	}
}