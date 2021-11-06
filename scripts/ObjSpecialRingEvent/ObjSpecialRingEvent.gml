function ObjSpecialRingEvent()
{
	// Exit if not in state 3
	if State != 3
	{
		exit;
	}
	
	// Send player to the Special Stage Screen
	if fade_check(StateMax) and !audio_sfx_is_playing(sfxSpecialWarp)
	{
		room_goto(Screen_SStage);
	}
}