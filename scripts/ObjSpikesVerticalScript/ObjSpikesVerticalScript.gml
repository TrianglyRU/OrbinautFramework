function ObjSpikesVerticalScript()
{
	// Get hurt side
	var hurtSide = image_yscale == 1 ? SideTop : SideBottom
	
	// Check if player is touching the hurt side
	if object_player_touch(hurtSide)
	{
		// Damage them
		object_damage(false, false, false);
	}
	
	// Do solid collision
	object_act_solid(true, true, true, false);
}