function ObjSpikesHorizontalMain()
{	
	// Do collision
	object_act_solid(true, true, true, false);
	
	// Damage player if they're touching the hurt side
	if object_check_touch(image_xscale == 1 ? TypeSolidR : TypeSolidL)
	{
		player_damage(false, false, false);
	}
}