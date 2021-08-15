function GameMusicHighProcess()
{
	// Exit if music is disabled
	if Game.MusicVolume == 0 or !Game.HighTrack[0]
	{
		exit;
	}
	
	// Get track data
	var Track     = Game.HighTrack[0];
	var Loop      = Game.HighTrack[1];
	var Event     = Game.HighTrack[2];
	var EventTime = Game.HighTrack[3];
	
	// Automaticly mute/unmute normal channel
	if Track and Event != EventMute and Event != EventStop
	{
		audio_bgm_mute(PriorityLow, 0);
	}
	else if Game.LowTrack[2] == EventMute
	{
		audio_bgm_unmute(PriorityLow, 1);
	}
	
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
			audio_bgm_stop(PriorityHigh, 0);
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
				Game.HighTrack[2] = EventIdle;
				Game.HighTrack[3] = 0;
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
				Game.HighTrack[2] = EventIdle;
				Game.HighTrack[0] = noone;
				Game.HighTrack[1] = 0;
				Game.HighTrack[3] = 0;
				
				audio_stop_sound(Track);
				audio_sound_gain(Track, Game.MusicVolume, 0);
			}
			
			// Decrease track volume
			else
			{
				var VolumeStep  = 1 / (EventTime * 60);
				var VolumeLevel = max(audio_sound_get_gain(Track) - VolumeStep, 0);
				
				audio_sound_gain(Track, VolumeLevel, 0);
			}
		}
		break;
	}
}