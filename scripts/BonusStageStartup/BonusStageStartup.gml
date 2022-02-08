function BonusStageStartup()
{
	State	   = 0;
	RingTarget = (Game.BonusStageData[0] div 100 * 100) + 100;
	
	fade_perform(ModeFrom, BlendBlack, 1);
	audio_bgm_play(TypePrimary, BonusTheme);
}