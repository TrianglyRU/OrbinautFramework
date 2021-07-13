function ObjSpikesHorizontalMain()
{
	// Check if player is touching the hurt side
	if object_player_touch(HurtSide)
	{
		// Damage them
		object_damage(false, false, false);
	}
	
	// Do solid collision
	object_act_solid(true, true, true, false);
}