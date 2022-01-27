function AudioSetup()
{
	/* The game will refer to data stored here to loop the tracks. 
	If no data set here for the track, it won't be looped */
	
	audio_bgm_setloop(TestStage,	     0.44,  81.29);
	audio_bgm_setloop(SuperTheme,		 3.45,  23.12);
	audio_bgm_setloop(BossTheme,		 6.33,  31.93);
	audio_bgm_setloop(SpecialTheme,		 11.21, 49.76);
	audio_bgm_setloop(BonusTheme,		 10.85, 39.85);
	audio_bgm_setloop(HighSpeed,		 9.57,  35.54);
	audio_bgm_setloop(Invincibility,     0.92,  11.49);
	
	/* The game will refer to data stored here to add play an additional
	channel. If no data set here for the track, nothing will happen */
	
	audio_bgm_add_channel(TestStage,    TestStage_DAC);
	audio_bgm_add_channel(ExtraLife,    ExtraLife_DAC);
	audio_bgm_add_channel(Continue,     Continue_DAC);
	audio_bgm_add_channel(BossTheme,    BossTheme_DAC);
	audio_bgm_add_channel(SuperTheme,   SuperTheme_DAC);
	audio_bgm_add_channel(BonusTheme,   BonusTheme_DAC);
	audio_bgm_add_channel(SpecialTheme, SpecialTheme_DAC);
}