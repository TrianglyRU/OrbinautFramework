function ObjSpecialRingEvent()
{
	// Exit if not in state 3
	if State != 3
	{
		exit;
	}
	
	// Send player to the Special Stage Screen
	if fade_check(FadeMax)
	{
		room_goto(Screen_SStage);
	}
}