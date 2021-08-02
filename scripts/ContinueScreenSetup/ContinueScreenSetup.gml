function ContinueScreenSetup()
{
	// Get room centre
	RoomX = Game.ResolutionWidth / 2;
	RoomY = Game.ResolutionHeight / 2;
	
	// Set countdown to 11 seconds - 1 frame
	Countdown = 559;
	
	// Create character object
	CharObject = instance_create(RoomX, RoomY + 52, ContinueCharacter);
	with CharObject
	{
		animation_set_frame(spr_obj_cont_sonic_wait, 1);
	}
	
	// Create continue objects
	for (var i = 0; i < Game.Continues; i++)
	{
		ContObject[i] = instance_create(RoomX + 21 * i - max(Game.Continues - 1, 0) * 11, RoomY - 20, ContinueIcon);
	}
	
	// Perfrom fade
	fade_perform(from, black, 1);
	
	// Play music
	audio_play_sound(ContinueMusic, 0, false);
}