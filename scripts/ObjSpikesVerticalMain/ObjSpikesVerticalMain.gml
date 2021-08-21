function ObjSpikesVerticalMain()
{
	// Damage player if they're touching hurt side
	if object_player_touch(HurtSide)
	{
		player_damage(false, false, false);
	}
	
	// Do collision
	object_act_solid(true, true, true);
}