function BonusStageStartup()
{
	// Set variables
	State	   = 0;
	RingTarget = (Game.BonusStageData[0] div 100 * 100) + 100;
	
	// Perform fade
	fade_perform(ModeFrom, BlendBlack, 1);
	
	// Play bgm
	audio_bgm_play(ChannelPrimary, BonusStageTheme);
}