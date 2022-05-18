/// @description Startup
// You can call your scripts in this editor
	
	// Initialise bonus stage data if it doesn't exist (in case we loaded from devmenu)
	if !array_length(global.BonusStageData)
	{
		global.BonusStageData[0] = 0;
		global.BonusStageData[1] = 0;
	}
	
	State	   = 0;
	RingTarget = (global.BonusStageData[0] div 100 * 100) + 100;
	
	fade_perform(ModeFrom, BlendBlack, 1);
	audio_bgm_play(AudioPrimary, BonusTheme);