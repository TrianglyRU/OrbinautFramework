function SpecialStageStartup()
{
	// Set blank values
	State	   = 0;
	StateTimer = 0;
	
	// Perform fade from white
	fade_perform(FadeFrom, ColourWhite, 1);
	
	// Play bgm
	audio_bgm_play(PriorityLow, SpecialStageTheme, other, other);
}