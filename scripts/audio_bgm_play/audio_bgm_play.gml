/// @function audio_bgm_play(priority,soundid)
function audio_bgm_play(priority,soundid)
{	
	// Exit if no audio set
	if !soundid
	{
		exit;
	}
	
	// Play new track
	switch priority
	{
		case PriorityLow:
		{
			// Stop previous track
			audio_stop_sound(Audio.LowTrack[1]);
			
			Audio.LowTrack[0] = EventIdle;
			Audio.LowTrack[1] = audio_play_sound(soundid, 0, false);
			
			// Set loopdata
			if ds_map_exists(Audio.TrackLoop, soundid)
			{
				Audio.LowTrack[3] = Audio.TrackLoop[? soundid];
			}
			else
			{
				Audio.LowTrack[3] = [];
			}
		}
		break;
		case PriorityHigh:
		{
			// Stop previous track
			audio_stop_sound(Audio.HighTrack[1]);

			Audio.HighTrack[0] = EventIdle;
			Audio.HighTrack[1] = audio_play_sound(soundid, 0, false);
		}
		break;
	}
	
	// Set track volume
	audio_sound_gain(soundid, Game.MusicVolume, 0);
}