function GameAudioJingleHandle()
{
	// Get jingle track data
	var Track     = Game.JingleTrack[TrackID];
	var Index     = Game.JingleTrack[TrackIndex];
	var Event     = Game.JingleTrack[TrackEvent];
	var EventTime = Game.JingleTrack[TrackEventTime];
	
	// Check if jingle is playing
	if audio_is_playing(Track)
	{	
		// Check what track should do
		switch Event
		{
			// If idle, don't do anything
			case EventIdle: break;
			
			// Unmute
			case EventUnmute:
			{
				// Get the volume step
				var VolumeStep = Game.MusicVolume / (EventTime * 60);
	
				// Set the target volume
				var VolumeLevel = min(audio_sound_get_gain(Track) + VolumeStep, Game.MusicVolume);
	
				// Update BGM volume
				audio_sound_gain(Track, VolumeLevel, 0);
				
				// Check if track volume is music volume
				if audio_sound_get_gain(Track) == Game.MusicVolume
				{
					// Reset event
					Game.JingleTrack[TrackEvent] = EventIdle;
				}
			}
			break;
			
			// Mute
			case EventMute:
			{
				// Get the volume step
				var VolumeStep = Game.MusicVolume / (EventTime * 60);
	
				// Set the target volume
				var VolumeLevel = max(audio_sound_get_gain(Track) - VolumeStep, 0);
	
				// Update BGM volume
				audio_sound_gain(Track, VolumeLevel, 0);
				
				// Check if track volume is 0 and we stop the bgm
				if audio_sound_get_gain(Track) == 0 and State == StateToggle
				{
					audio_stop_sound(Track);
					Game.JingleTrack[TrackID]		 = 0;
					Game.JingleTrack[TrackIndex]	 = 0;	
					Game.JingleTrack[TrackEventTime] = 0;
					Game.JingleTrack[TrackEvent]     = EventIdle;
					
					audio_bgm_unmute(TypeNormal, 1);
					audio_bgm_unmute(TypePriority, 1);
					
					// Reset volume
					audio_sound_gain(Track, Game.MusicVolume, 0);
				}
			}
			break;
			
			// Stop
			case EventStop:
			{
				// Get the volume step
				var VolumeStep = Game.MusicVolume / (EventTime * 60);
	
				// Set the target volume
				var VolumeLevel = max(audio_sound_get_gain(Track) - VolumeStep, 0);
	
				// Update BGM volume
				audio_sound_gain(Track, VolumeLevel, 0);
				
				// Check if track volume is 0 and we stop the bgm
				if audio_sound_get_gain(Track) == 0
				{	
					Game.JingleTrack[TrackID]		 = 0;
					Game.JingleTrack[TrackIndex]	 = 0;	
					Game.JingleTrack[TrackEventTime] = 0;
					Game.JingleTrack[TrackEvent]     = EventIdle;
					
					// Stop and reset volume
					audio_stop_sound(Track);
					audio_sound_gain(Track, Game.MusicVolume, 0);
				}
			}
			break;
		}
	}
	
	// Reset data if jingle is not playing
	else
	{
		Game.JingleTrack[TrackID]		 = 0;
		Game.JingleTrack[TrackIndex]	 = 0;	
		Game.JingleTrack[TrackEventTime] = 0;
		Game.JingleTrack[TrackEvent]     = EventIdle;
	}
	
	// Automatic behaviour
	if Track and Event != EventMute and Event != EventStop
	{
		audio_bgm_mute(TypeNormal,   0);
		audio_bgm_mute(TypePriority, 0);
	}
	else if Game.PriorityTrack[TrackEvent] == EventMute
	{
		if !audio_is_playing(Drowning)
		{
			audio_bgm_unmute(TypePriority, 1);
		}
	}
}