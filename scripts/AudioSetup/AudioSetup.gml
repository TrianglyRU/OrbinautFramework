function AudioSetup()
{
	/* The game will refer to data stored here to loop the tracks. 
	If no data set here for the track, it won't be looped */
	
	audio_bgm_setloop(TestStage,	     0.44, 81.29);
	audio_bgm_setloop(SuperTheme,		 0,    54.38);
	audio_bgm_setloop(Boss,			     3.25, 28.84);
	audio_bgm_setloop(SpecialStageTheme, 11.66, 50.2);
	audio_bgm_setloop(BonusStageTheme,   3.67, 32.65);
	audio_bgm_setloop(HighSpeed,		 9.57, 35.54);
	audio_bgm_setloop(Invincibility,     0.92, 11.49);
	
	/* The game will refer to data stored here to add play an additional
	channel. If no data set here for the track, nothing will happen */
	
	audio_bgm_add_channel(TestStage, TestStage_DAC);
}