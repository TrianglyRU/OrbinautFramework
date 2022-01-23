function SpecialStageStartup()
{
	// Initialise variables
	State	   = 0;
	StateTimer = 0;
	
	// Fade in
	fade_perform(ModeFrom, BlendWhite, 1);
	
	// Play music
	audio_bgm_play(TypePrimary, SpecialStageTheme);
}