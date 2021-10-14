function BonusStageStartup()
{
	// Set variables
	State	  = 0;
	RingState = 1;
	
	// Perform fade
	fade_perform(FadeFrom, ColourBlack, 1);
	
	// Play bgm
	audio_bgm_play(PriorityLow, BonusStageTheme, other, other);
}