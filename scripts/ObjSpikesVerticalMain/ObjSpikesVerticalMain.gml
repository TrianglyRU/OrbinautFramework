function ObjSpikesVerticalMain()
{
	// Do collision
	if !Player.InvincibleBonus and !Player.InvincibilityFrames and !Player.SuperState
	{
		object_act_solid(true, true, true, true);
	}
	else
	{
		// Allow to bounce and dropdash on the spikes
		object_act_solid(true, true, true, false);
	}
	
	// Damage player if they're touching the hurt side
	if object_check_touch(image_yscale == 1 ? TypeSolidU : TypeSolidD)
	{
		player_damage(false, false, false);
	}
}