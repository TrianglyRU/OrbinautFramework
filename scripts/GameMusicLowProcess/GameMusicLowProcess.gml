function GameMusicLowProcess()
{
	// Exit if music is disabled
	if !Game.LowTrack[0]
	{
		exit;
	}
	
	// Get track data
	var Track     = Game.LowTrack[0];
	var Loop      = Game.LowTrack[1];
	var Event     = Game.LowTrack[2];
	var EventTime = Game.LowTrack[3];
	
	// Exit if channel is inactive
	if !Track
	{
		exit;
	}
	
	// Loop
	if audio_sound_get_track_position(Track) + 0.1 >= audio_sound_length(Track)
	{
		if Loop != noone
		{
			audio_sound_set_track_position(Track, Loop);
		}
		else
		{
			audio_bgm_stop(PriorityLow, 0);
		}
	}
	
	switch Event
	{
		// If idle, don't do anything
		case EventIdle: break;
			
		// Unmute
		case EventUnmute:
		{
			// Reset event
			if audio_sound_get_gain(Track) == 1
			{
				Game.LowTrack[2] = EventIdle;
				Game.LowTrack[3] = 0;
			}
			
			// Increase track volume
			else
			{		
				var VolumeStep  = 1 / (EventTime * 60);
				var VolumeLevel = min(audio_sound_get_gain(Track) + VolumeStep, 1);
				
				audio_sound_gain(Track, VolumeLevel, 0);
			}
		}
		break;
			
		// Mute
		case EventMute:
		{	
			// Decrease track volume
			var VolumeStep  = 1 / (EventTime * 60);
			var VolumeLevel = max(audio_sound_get_gain(Track) - VolumeStep, 0);
			
			audio_sound_gain(Track, VolumeLevel, 0);
		}
		break;
			
		// Stop
		case EventStop:
		{	
			// Stop and reset track
			if audio_sound_get_gain(Track) == 0
			{		
				Game.LowTrack[2] = EventIdle;
				Game.LowTrack[0] = noone;
				Game.LowTrack[1] = 0;
				Game.LowTrack[3] = 0;
				
				audio_stop_sound(Track);
				audio_sound_gain(Track, Game.MusicVolume, 0);
			}
			else
			{
				// Decrease track volume
				var VolumeStep  = 1 / (EventTime * 60);
				var VolumeLevel = max(audio_sound_get_gain(Track) - VolumeStep, 0);
			
				audio_sound_gain(Track, VolumeLevel, 0);
			}
		}
	}
}