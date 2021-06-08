function GameMusicEngine()
{
	// Normal audio
	var Track     = Game.NormalTrack[TrackID];
	var Index     = Game.NormalTrack[TrackIndex];
	var Loop      = Game.NormalTrack[TrackLoop];
	var Event     = Game.NormalTrack[TrackEvent];
	var EventTime = Game.NormalTrack[TrackEventTime];
		
	if Track
	{
		var Position = audio_sound_get_track_position(Index);
		var Length   = audio_sound_length(Track);
		
		if Position >= Length - 0.1
		{
			audio_sound_set_track_position(Index, Loop);
		}
		
		switch Event
		{
			case EventPlay: break;
			case EventMute:
			{
				// Get the volume step
				var VolumeStep = Game.MusicVolume / (EventTime * 60);
	
				// Set the target volume
				var VolumeLevel = max(audio_sound_get_gain(Track) - VolumeStep, 0);
	
				// Update BGM volume
				audio_sound_gain(Track, VolumeLevel, 0);
			}
			break;
			case EventUnmute:
			{
				// Get the volume step
				var VolumeStep = Game.MusicVolume / (EventTime * 60);
	
				// Set the target volume
				var VolumeLevel = min(audio_sound_get_gain(Track) + VolumeStep, Game.MusicVolume);
	
				// Update BGM volume
				audio_sound_gain(Track, VolumeLevel, 0);
			}
			break;
			case EventStop:
			{
				// Fade out the BGM if the fade time is set and its volume is not 0
				if audio_sound_get_gain(Track) != 0
				{
					// Get the volume step
					var VolumeStep = Game.MusicVolume / (EventTime * 60);
	
					// Set the target volume
					var VolumeLevel = max(audio_sound_get_gain(Track) - VolumeStep, 0);
	
					// Update BGM volume
					audio_sound_gain(Track, VolumeLevel, 0);		
				}
					
				// Stop the BGM
				else
				{
					audio_stop_sound(Track);
					Game.NormalTrack[TrackID]		 = 0;
					Game.NormalTrack[TrackEventTime] = 0;
				}		
			}
			break;
		}
	}
	
	// Priority audio
	var Track     = Game.PriorityTrack[TrackID];
	var Index     = Game.PriorityTrack[TrackIndex];
	var Loop      = Game.PriorityTrack[TrackLoop];
	var Event     = Game.PriorityTrack[TrackEvent];
	var EventTime = Game.PriorityTrack[TrackEventTime];
		
	if Track
	{
		var Position = audio_sound_get_track_position(Index);
		var Length   = audio_sound_length(Track);
		
		if Position >= Length - 0.1
		{
			audio_sound_set_track_position(Index, Loop);
		}
		
		switch Event
		{
			case EventPlay: 
			{
				audio_bgm_mute(TypeNormal, 0);
			}
			break;
			case EventMute:
			{
				// Get the volume step
				var VolumeStep = Game.MusicVolume / (EventTime * 60);
	
				// Set the target volume
				var VolumeLevel = max(audio_sound_get_gain(Track) - VolumeStep, 0);
	
				// Update BGM volume
				audio_sound_gain(Track, VolumeLevel, 0);	
			}
			break;
			case EventUnmute:
			{
				// Get the volume step
				var VolumeStep = Game.MusicVolume / (EventTime * 60);
	
				// Set the target volume
				var VolumeLevel = min(audio_sound_get_gain(Track) + VolumeStep, Game.MusicVolume);
	
				// Update BGM volume
				audio_sound_gain(Track, VolumeLevel, 0);	
			}
			break;
			case EventStop:
			{
				// Fade out the BGM if the fade time is set and its volume is not 0
				if audio_sound_get_gain(Track) != 0
				{
					// Get the volume step
					var VolumeStep = Game.MusicVolume / (EventTime * 60);
	
					// Set the target volume
					var VolumeLevel = max(audio_sound_get_gain(Track) - VolumeStep, 0);
	
					// Update BGM volume
					audio_sound_gain(Track, VolumeLevel, 0);
				}
					
				// Stop the BGM
				else
				{
					audio_stop_sound(Track);
					Game.PriorityTrack[TrackID]		   = 0;
					Game.PriorityTrack[TrackEventTime] = 0;
				}
			}
			break;
		}
	}
	if Event == EventStop and Game.NormalTrack[TrackEvent] == EventMute
	{
		audio_bgm_unmute(TypeNormal, 1);
	}
	
	// Jingle audio
	var Track     = Game.JingleTrack[TrackID];
	var Index     = Game.JingleTrack[TrackIndex];
	var Event     = Game.JingleTrack[TrackEvent];
	var EventTime = Game.JingleTrack[TrackEventTime];
		
	if Track
	{
		switch Event
		{
			case EventPlay: 
			{
				audio_bgm_mute(TypeNormal,   0);
				audio_bgm_mute(TypePriority, 0);
				
				var Position = audio_sound_get_track_position(Index);
				var Length   = audio_sound_length(Track);
		
				if Position >= Length - 0.1
				{
					Game.JingleTrack[TrackEvent] = EventStop;
				}
			}
			break;
			case EventMute:
			{
				// Get the volume step
				var VolumeStep = Game.MusicVolume / (EventTime * 60);
	
				// Set the target volume
				var VolumeLevel = max(audio_sound_get_gain(Track) - VolumeStep, 0);
	
				// Update BGM volume
				audio_sound_gain(Track, VolumeLevel, 0);
			}
			break;
			case EventUnmute:
			{
				// Get the volume step
				var VolumeStep = Game.MusicVolume / (EventTime * 60);
	
				// Set the target volume
				var VolumeLevel = min(audio_sound_get_gain(Track) + VolumeStep, Game.MusicVolume);
	
				// Update BGM volume
				audio_sound_gain(Track, VolumeLevel, 0);
			}
			break;
			case EventStop:
			{
				// Fade out the BGM if the fade time is set and its volume is not 0
				if audio_sound_get_gain(Track) != 0
				{
					// Get the volume step
					var VolumeStep = Game.MusicVolume / (EventTime * 60);
	
					// Set the target volume
					var VolumeLevel = max(audio_sound_get_gain(Track) - VolumeStep, 0);
	
					// Update BGM volume
					audio_sound_gain(Track, VolumeLevel, 0);		
				}
					
				// Stop the BGM
				else
				{
					audio_stop_sound(Track);
					Game.JingleTrack[TrackID]		 = 0;
					Game.JingleTrack[TrackEventTime] = 0;
				}		
			}
			break;
		}
	}
	else
	{
		if Game.NormalTrack[TrackEvent] == EventMute and !Game.PriorityTrack[TrackID]
		{
			audio_bgm_unmute(TypeNormal, 1);
		}
		if Game.PriorityTrack[TrackEvent] == EventMute
		{
			audio_bgm_unmute(TypePriority, 1);
		}
	}
}