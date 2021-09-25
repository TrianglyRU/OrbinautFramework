function AudioHighProcess()
{
	// Exit if no priority track playing
	if !HighTrack[0]
	{
		exit;
	}
	
	// Get priority track data
	var Track     = HighTrack[0];
	var Event     = HighTrack[2];
	var EventTime = HighTrack[3];
	
	// Automaticly mute and unmute non-priority track
	if Track and Event != EventMute and Event != EventStop
	{
		audio_bgm_mute(PriorityLow, 0);
	}
	else if LowTrack[2] == EventMute
	{
		audio_bgm_unmute(PriorityLow, 1);
	}
	
	// Stop track
	if audio_sound_get_track_position(Track) + 0.1 >= audio_sound_length(Track)
	{
		audio_bgm_stop(PriorityHigh, 0);
	}
	
	switch Event
	{
		case EventIdle: break;
		case EventUnmute:
		{
			// Reset event
			if audio_sound_get_gain(Track) == 1
			{
				HighTrack[2] = EventIdle;
				HighTrack[3] = 0;
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
		case EventMute:
		{
			// Decrease track volume
			var VolumeStep  = 1 / (EventTime * 60);
			var VolumeLevel = max(audio_sound_get_gain(Track) - VolumeStep, 0);
			
			audio_sound_gain(Track, VolumeLevel, 0);
		}
		break;
		case EventStop:
		{	
			// Stop and reset track
			if audio_sound_get_gain(Track) == 0
			{		
				HighTrack[2] = EventIdle;
				HighTrack[0] = noone;
				HighTrack[1] = 0;
				HighTrack[3] = 0;
				
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