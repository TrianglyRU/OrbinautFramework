function SpecialStageStartup()
{
	State	   = 0;
	StateTimer = 0;
	
	fade_perform(ModeFrom, BlendWhite, 1);
	audio_bgm_play(AudioPrimary, SpecialTheme);
}