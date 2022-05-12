/// @description Startup / Setup
// You can write your code in this editor
	
	#region Startup
	{
		/* Value Table Reference
		------------------------
		[0] - Event
		[1] - Track ID - Not asset ID!
		[2] - Event Time
		[3] - Loop Data (Primary) / 2nd Channel (Secondary)
		[4] - 2nd Channel ID - Not asset ID!
		------------------------
		*/
	
		// Set channels data
		PrimaryTrack[0]   = EventIdle;
		PrimaryTrack[1]   = noone;
		PrimaryTrack[2]   = 0;
		PrimaryTrack[3]   = [];
		PrimaryTrack[4]   = noone;
		SecondaryTrack[0] = EventIdle;
		SecondaryTrack[1] = noone;
		SecondaryTrack[2] = 0;
		SecondaryTrack[3] = noone;
	
		// Create data structures
		TrackLoopData = ds_map_create();
		SubTrackData  = ds_map_create();
	}
	#endregion
	
	#region Setup
	{
		/* The game will refer to data stored here to loop music tracks. 
		If no data set here for the track, it won't be looped */
	
		audio_bgm_setloop(TestStage,	 16.74, 87.66);
		audio_bgm_setloop(SuperTheme,	 3.45,  23.12);
		audio_bgm_setloop(BossTheme,	 6.33,  31.93);
		audio_bgm_setloop(SpecialTheme,	 11.21, 49.76);
		audio_bgm_setloop(BonusTheme,	 10.85, 39.85);
		audio_bgm_setloop(HighSpeed,	 1.4,   27.37);
		audio_bgm_setloop(Invincibility, 3.7,   15.48);
	
		/* The game will refer to data stored here to play an additional channel. 
		If no data set here for the track, nothing will happen. You are not forced to do this */

		audio_bgm_add_subtrack(TestStage,     TestStage_DAC);
		audio_bgm_add_subtrack(HighSpeed,     HighSpeed_DAC);
		audio_bgm_add_subtrack(Invincibility, Invincibility_DAC);
		audio_bgm_add_subtrack(ExtraLife,     ExtraLife_DAC);
		audio_bgm_add_subtrack(Continue,      Continue_DAC);
		audio_bgm_add_subtrack(BossTheme,     BossTheme_DAC);
		audio_bgm_add_subtrack(SuperTheme,    SuperTheme_DAC);
		audio_bgm_add_subtrack(BonusTheme,    BonusTheme_DAC);
		audio_bgm_add_subtrack(SpecialTheme,  SpecialTheme_DAC);
	}
	#endregion