function AudioPrimaryProcess()
{
	// Exit if primary track is playing
	if !PrimaryTrack[1] 
	{
		exit;
	}
	
	// Get track data
	var Event     = PrimaryTrack[0];
	var Track     = PrimaryTrack[1];
	var EventTime = PrimaryTrack[2];
	var LoopData  = PrimaryTrack[3];
	
	// Loop track
	var TrackPosition = audio_sound_get_track_position(Track);
	if  array_length(LoopData)
	{
		if TrackPosition >= LoopData[1]
		{
			audio_sound_set_track_position(Track, LoopData[0] + (TrackPosition - LoopData[1]));
		}
	}
	else if TrackPosition >= audio_sound_length(Track) - 0.1
	{
		audio_bgm_stop(ChannelPrimary, 0);
	}
	
	switch Event
	{
		case EventIdle: break;
		case EventUnmute:
		{
			// Reset event
			if audio_sound_get_gain(Track) == 1
			{
				PrimaryTrack[0] = EventIdle;
				PrimaryTrack[2] = 0;
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
				PrimaryTrack[0] = EventIdle;
				PrimaryTrack[1] = noone;
				PrimaryTrack[2] = 0;
				PrimaryTrack[3]	= [];
				
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