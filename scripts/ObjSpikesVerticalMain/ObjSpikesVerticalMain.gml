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
	
	// Damage player if they're touching hurt side
	var HurtSide = image_yscale == 1 ? SideTop : SideBottom;
	if object_check_touch(HurtSide)
	{
		player_damage(false, false, false);
	}
}