function AudioLowProcess()
{
	// Exit if no non-priority track is playing
	if !LowTrack[0] 
	{
		exit;
	}
	
	// Get track data
	var Track     = LowTrack[0];
	var LoopData  = LowTrack[1];
	var Event     = LowTrack[2];
	var EventTime = LowTrack[3];
	
	// Loop track
	var TrackPosition = audio_sound_get_track_position(Track);
	if  LoopData[1]
	{
		if TrackPosition >= LoopData[1]
		{
			audio_sound_set_track_position(Track, LoopData[0] + (TrackPosition - LoopData[1]));
		}
	}
	else if TrackPosition >= audio_sound_length(Track)
	{
		audio_bgm_stop(PriorityLow, 0);
	}
	
	switch Event
	{
		case EventIdle: break;
		case EventUnmute:
		{
			// Reset event
			if audio_sound_get_gain(Track) == 1
			{
				LowTrack[2] = EventIdle;
				LowTrack[3] = 0;
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
				LowTrack[2]    = EventIdle;
				LowTrack[0]    = noone;
				LowTrack[3]    = 0;
				LowTrack[1][0] = 0;
				LowTrack[1][1] = 0;
				
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