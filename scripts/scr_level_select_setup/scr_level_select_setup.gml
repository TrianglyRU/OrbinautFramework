/// @self obj_rm_level_select
function scr_level_select_setup()
{
	// Entries
	level_entries =
	[
		"GREEN HILL|1",
		"		   |2",
		"		   |3",
		"",
		"EMERALD HILL|1",
		"		     |2",
		"",
		"UNDEFINED|1",
		"         |2",
		"",
		"UNDEFINED|1",
		"         |2",
		"",
		"UNDEFINED|1",
		"         |2",
		"",
		"UNDEFINED|1",
		"         |2",
		"",
		"UNDEFINED|1",
		"         |2",
		"/n",
		"UNDEFINED|1",
		"         |2",
		"/p",
		"",
		"TERMINAL SPECTRUM",
		"",
		"",
		"SPECIAL STAGE",
		"",
		"",
		"BONUS STAGE",
		"",
		"",
		"SOUND TEST"
	];
	
	// Redirections
	level_rediretions =
	[
		0,  rm_stage_ghz_1,
		4,  rm_stage_ehz_1,
		26, rm_stage_tsz,
		29, rm_special,
		32, rm_bonus
	];
	
	// Cheat codes
	cheat_codes =
	[
		{
			code: "04010206",
			execute: function()
			{
				if global.emerald_count < 7
				{
				    global.emerald_count = 7;
				
					audio_bgm_stop(0, AUDIO_CHANNEL_JINGLE);
					audio_bgm_stop(0);
					audio_bgm_play(snd_bgm_emerald);
				}
			}
		},
		{
			code: "01010204",
			execute: function()
			{
				if global.continue_count < 14
				{
				    global.continue_count = 14;
					audio_sfx_play(snd_continue);
				}
			}
		},
		{
			code: "0200020400090007",
			execute: function()
			{
				if !global.enable_debug_mode
				{
				    global.enable_debug_mode = true;
					audio_sfx_play_ring();
				}
			}
		},
	];
}