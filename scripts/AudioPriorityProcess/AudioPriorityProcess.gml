function AudioPriorityProcess()
{
	if !SecondaryTrack[1]
	{
		exit;
	}
	
	/* Value Table Reference
	------------------------
	[0] - Event
	[1] - Track ID
	[2] - Event Time
	[3] - Loop Data
	------------------------
	*/
	
	// Get secondary track data
	var Event     = SecondaryTrack[0];
	var Track     = SecondaryTrack[1];
	var EventTime = SecondaryTrack[2];
	
	// Automatically mute and unmute primary track
	if Track and Event != EventMute and Event != EventStop
	{
		audio_bgm_mute(ChannelPrimary, 0);
	}
	else if PrimaryTrack[0] == EventMute
	{
		audio_bgm_unmute(ChannelPrimary, 1);
	}
	
	// Stop track once it finished playing
	if audio_sound_get_track_position(Track) >= audio_sound_length(Track) - 0.1
	{
		audio_bgm_stop(ChannelSecondary, 0);
	}
	
	switch Event
	{
		case EventIdle: break;
		case EventUnmute:
		{
			// Reset event
			if audio_sound_get_gain(Track) == 1
			{
				SecondaryTrack[0] = EventIdle;
				SecondaryTrack[2] = 0;
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
				SecondaryTrack[0] = EventIdle;
				SecondaryTrack[1] = noone;
				SecondaryTrack[2] = 0;
				
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