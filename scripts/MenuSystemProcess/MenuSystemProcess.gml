function MenuSystemProcess()
{	
	// Navigate between options
	if Input.DownPress
	{
		OptionID++;
		
		// Play sound
		audio_sfx_play(sfxScoreCount, false);
	}
	else if Input.UpPress
	{
		OptionID--; 
		
		// Play sound
		audio_sfx_play(sfxScoreCount, false);
	}
	OptionID = loop_value(OptionID, 0, MenuSize[MenuID]);

	// React to key B
	if Input.BPress and MenuID != 0
	{
		// Highlight remembered option
		if PreviousOptionID[MenuID] != noone
		{
			OptionID = PreviousOptionID[MenuID];
		}
		else
		{
			OptionID = 0;
		}
		
		// Back to previous menu
		MenuID = PreviousMenuID[MenuID];
		
		// Play sound
		audio_sfx_play(sfxPauseBack, false);
	}
}