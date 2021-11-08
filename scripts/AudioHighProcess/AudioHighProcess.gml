function AudioHighProcess()
{
	// Exit if no priority track playing
	if !HighTrack[1]
	{
		exit;
	}
	
	/* Array Pointers
	0 - Event
	1 - TrackID
	2 - EventTime
	3 - LoopData
	*/
	
	// Get priority track data
	var Event     = HighTrack[0];
	var Track     = HighTrack[1];
	var EventTime = HighTrack[2];
	
	// Automaticly mute and unmute non-priority track
	if Track and Event != EventMute and Event != EventStop
	{
		audio_bgm_mute(PriorityLow, 0);
	}
	else if LowTrack[0] == EventMute
	{
		audio_bgm_unmute(PriorityLow, 1);
	}
	
	// Stop track once it finished playing
	if audio_sound_get_track_position(Track) >= audio_sound_length(Track)
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
				HighTrack[0] = EventIdle;
				HighTrack[2] = 0;
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
				HighTrack[0] = EventIdle;
				HighTrack[1] = noone;
				HighTrack[2] = 0;
				
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