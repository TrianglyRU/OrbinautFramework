/// @description Stage Music
// You can call your scripts in this editor
	
	// Reset all volume for BGM
	audio_group_set_gain(BGM, Game.MusicVolume, 0);
	
	// Set BGM
	switch room
	{		
		case MBZ: play_sound(MoonlightBase, true); break;
	}