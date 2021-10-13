function ObjStarPostEffectEvent()
{
	// Exit if in state 0
	if !State
	{
		exit;
	}
	
	// Send player to the Bonus Stage
	if fade_check(FadeMax)
	{
		// TODO
		room_restart();
	}
	
}