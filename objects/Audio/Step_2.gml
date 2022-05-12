/// @description Process Audio
// You can write your code in this editor
	
	#region Primary Process
	{
		if !PrimaryTrack[1] 
		{
			return;
		}
	
		/* Value Table Reference
		------------------------
		[0] - Event
		[1] - Track ID - Not asset ID!
		[2] - Event Time
		[3] - Loop Data
		[4] - SubTrack ID - Not asset ID!
		------------------------
		*/
	
		// Get track data
		var Event     = PrimaryTrack[0];
		var Track     = PrimaryTrack[1];
		var EventTime = PrimaryTrack[2];
		var LoopData  = PrimaryTrack[3];
		var SubTrack  = PrimaryTrack[4];

		// Loop track
		var TrackPosition = audio_sound_get_track_position(Track);
		if  array_length(LoopData)
		{
			if TrackPosition >= LoopData[1]
			{
				if SubTrack
				{
					audio_sound_set_track_position(SubTrack, LoopData[0] + (TrackPosition - LoopData[1]));
				}
				audio_sound_set_track_position(Track, LoopData[0] + (TrackPosition - LoopData[1]));
			}
		}
		else if !audio_bgm_is_playing(Track)
		{
			if SubTrack
			{
				audio_stop_sound(SubTrack);
			}
			audio_bgm_stop(AudioPrimary, 0);
		}
	
		switch Event
		{
			case EventIdle: break;
			case EventUnmute:
			{
				// Reset event
				if audio_sound_get_gain(Track) == 1
				{
					if SubTrack
					{
						audio_sound_gain(SubTrack, 1, 0);
					}
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
			
				if SubTrack
				{
					audio_sound_gain(SubTrack, 0, 0);
				}
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
					PrimaryTrack[4] = noone;
				
					audio_stop_sound(Track);
					audio_sound_gain(Track, global.MusicVolume, 0);
				}
				else
				{
					// Decrease track volume
					var VolumeStep  = 1 / (EventTime * 60);
					var VolumeLevel = max(audio_sound_get_gain(Track) - VolumeStep, 0);
				
					if SubTrack
					{
						audio_stop_sound(SubTrack);
						audio_sound_gain(SubTrack, global.MusicVolume, 0);
					}
					audio_sound_gain(Track, VolumeLevel, 0);
				}
			}
			break;
		}
	}
	#endregion
	
	#region Secondary Process
	{
		if !SecondaryTrack[1]
		{
			return;
		}
	
		/* Value Table Reference
		------------------------
		[0] - Event
		[1] - Track ID - Not asset ID!
		[2] - Event Time
		[3] - SubTrack ID - Not asset ID!
		------------------------
		*/
	
		// Get secondary track data
		var Event     = SecondaryTrack[0];
		var Track     = SecondaryTrack[1];
		var EventTime = SecondaryTrack[2];
		var SubTrack  = SecondaryTrack[3];
	
		// Automatically mute and unmute primary track
		if Track and Event != EventMute and Event != EventStop
		{
			audio_bgm_mute(AudioPrimary, 0);
		}
		else if PrimaryTrack[0] == EventMute
		{
			audio_bgm_unmute(AudioPrimary, 1);
		}
	
		// Stop track once it finished playing
		if !audio_bgm_is_playing(Track)
		{
			if SubTrack
			{
				audio_stop_sound(SubTrack);
			}
			audio_bgm_stop(AudioSecondary, 0);
		}
	
		switch Event
		{
			case EventIdle: break;
			case EventUnmute:
			{
				// Reset event
				if audio_sound_get_gain(Track) == 1
				{
					if SubTrack
					{
						audio_sound_gain(SubTrack, 1, 0);
					}
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
			
				if SubTrack
				{
					audio_sound_gain(SubTrack, 0, 0);
				}
				audio_sound_gain(Track, VolumeLevel, 0);
			}
			break;
			case EventStop:
			{	
				// Stop and reset track
				if !audio_bgm_is_playing(Track) or audio_sound_get_gain(Track) == 0
				{		
					SecondaryTrack[0] = EventIdle;
					SecondaryTrack[1] = noone;
					SecondaryTrack[2] = 0;
					SecondaryTrack[3] = noone;
				
					audio_stop_sound(Track);
					audio_sound_gain(Track, global.MusicVolume, 0);
				}
			
				// Decrease track volume
				else
				{
					var VolumeStep  = 1 / (EventTime * 60);
					var VolumeLevel = max(audio_sound_get_gain(Track) - VolumeStep, 0);
				
					if SubTrack
					{
						audio_stop_sound(SubTrack);
						audio_sound_gain(SubTrack, global.MusicVolume, 0);
					}
					audio_sound_gain(Track, VolumeLevel, 0);
				}
			}
			break;
		}
	}
	#endregion