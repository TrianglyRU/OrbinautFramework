/// @description Event
// You can write your code in this editor
	
	if State != 3
	{
		return;
	}
	
	// Send player to the Special Stage Screen
	if fade_check(StateMax) and !audio_sfx_is_playing(sfxSpecialWarp)
	{
		room_goto(Screen_SStage);
	}